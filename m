Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261878AbVDESFm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261878AbVDESFm (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Apr 2005 14:05:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261836AbVDESFf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Apr 2005 14:05:35 -0400
Received: from tetsuo.zabbo.net ([207.173.201.20]:53208 "EHLO tetsuo.zabbo.net")
	by vger.kernel.org with ESMTP id S261861AbVDESDh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Apr 2005 14:03:37 -0400
Message-ID: <4252D2FE.5010500@zabbo.net>
Date: Tue, 05 Apr 2005 11:03:42 -0700
From: Zach Brown <zab@zabbo.net>
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.7.2) Gecko/20040803
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Arjan van de Ven <arjan@infradead.org>
Cc: Joel Becker <Joel.Becker@oracle.com>, linux-kernel@vger.kernel.org,
       linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH] configfs, a filesystem for userspace-driven kernel	object
 configuration
References: <20050403195728.GH31163@ca-server1.us.oracle.com> <1112635079.6270.68.camel@laptopd505.fenrus.org>
In-Reply-To: <1112635079.6270.68.camel@laptopd505.fenrus.org>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Arjan van de Ven wrote:
> On Sun, 2005-04-03 at 12:57 -0700, Joel Becker wrote:
> 
>>Folks,
>>	I humbly submit configfs.  With configfs, a configfs
>>config_item is created via an explicit userspace operation: mkdir(2).
>>It is destroyed via rmdir(2).  The attributes appear at mkdir(2) time,
>>and can be read or modified via read(2) and write(2).  readdir(3)
>>queries the list of items and/or attributes.
>>	The lifetime of the filesystem representation is completely
>>driven by userspace.  The lifetime of the objects themselves are managed
>>by a kref, but at rmdir(2) time they disappear from the filesystem.
> 
> 
> does that mean you rmdir a non-empty directory ??

Yeah, but only attributes and default groups are automatically torn
down.  You can't rmdir() an item that is the destination of links and
you can't rmdir() groups that still contain items.

- z
