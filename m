Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264446AbTH1Xdr (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 28 Aug 2003 19:33:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264450AbTH1Xdq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Aug 2003 19:33:46 -0400
Received: from fw.osdl.org ([65.172.181.6]:31682 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S264446AbTH1Xdp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Aug 2003 19:33:45 -0400
Date: Thu, 28 Aug 2003 16:39:37 -0700 (PDT)
From: Patrick Mochel <mochel@osdl.org>
X-X-Sender: mochel@cherise
To: Thomas Spatzier <TSPAT@de.ibm.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] memory leak in sysfs
In-Reply-To: <OF846221A1.E004CC84-ONC1256D8F.00491EF9-C1256D8F.004A7867@de.ibm.com>
Message-ID: <Pine.LNX.4.44.0308281638160.4140-100000@cherise>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> please verify the following patch. We found a memory leak in sysfs. Entries
> in the dentry_cache allocated for objects in sysfs are not freed when the
> objects in sysfs are deleted. This effect is due to inconsistent reference
> counting in sysfs. Furthermore, when calling sysfs_remove_dir the deleted
> directory was not removed from its parent's list of children. The attached
> patch should fix the problems.

Thanks. Martin Schwidefsky had mentioned this to me at OLS (I presume it's 
the same problem). I haven't had a chance to look closely at the patch, 
but it's in my immediate queue..


	Pat


