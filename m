Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932254AbWHJVBE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932254AbWHJVBE (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Aug 2006 17:01:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932344AbWHJVBA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Aug 2006 17:01:00 -0400
Received: from srv5.dvmed.net ([207.36.208.214]:33670 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S932254AbWHJVAc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Aug 2006 17:00:32 -0400
Message-ID: <44DB9E6C.9070808@garzik.org>
Date: Thu, 10 Aug 2006 17:00:28 -0400
From: Jeff Garzik <jeff@garzik.org>
User-Agent: Thunderbird 1.5.0.4 (X11/20060614)
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: Badari Pulavarty <pbadari@us.ibm.com>, cmm@us.ibm.com,
       linux-kernel@vger.kernel.org, ext2-devel@lists.sourceforge.net,
       linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 1/5] Forking ext4 filesystem from ext3 filesystem
References: <1155172622.3161.73.camel@localhost.localdomain>	<20060809233914.35ab8792.akpm@osdl.org>	<44DB8036.5020706@us.ibm.com>	<44DB936D.2080909@garzik.org> <20060810132720.4d9fced4.akpm@osdl.org>
In-Reply-To: <20060810132720.4d9fced4.akpm@osdl.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Score: -4.3 (----)
X-Spam-Report: SpamAssassin version 3.1.3 on srv5.dvmed.net summary:
	Content analysis details:   (-4.3 points, 5.0 required)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton wrote:
> On Thu, 10 Aug 2006 16:13:33 -0400
> Jeff Garzik <jeff@garzik.org> wrote:
> 
>> The sooner we kill buffer heads and use submit_bio(), the better :)
> 
> A buffer_head is a caching entity and a bio is an IO container.  They're
> quite separate concepts.

Yeah, sorry, I meant direct pagecache I/O.  I forgot that bio doesn't 
handle caching.


> A buffer_head is the kernel's sole abstraction of a disk block. 
> Filesystems use disk blocks a lot, and they need such an abstraction.

IMO Al Viro work has shown that you can do pagecache I/O without needing 
such a heavyweight system.

	Jeff



