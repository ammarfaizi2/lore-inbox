Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319282AbSIKSzn>; Wed, 11 Sep 2002 14:55:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319283AbSIKSzn>; Wed, 11 Sep 2002 14:55:43 -0400
Received: from tolkor.SGI.COM ([192.48.180.13]:51899 "EHLO tolkor.sgi.com")
	by vger.kernel.org with ESMTP id <S319282AbSIKSzm>;
	Wed, 11 Sep 2002 14:55:42 -0400
Subject: Re: XFS?
From: Eric Sandeen <sandeen@sgi.com>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Bill Davidsen <davidsen@tmr.com>, Andi Kleen <ak@suse.de>,
       Thunder from the hill <thunder@lightweight.ods.org>,
       linux-kernel@vger.kernel.org
In-Reply-To: <1031760229.2768.54.camel@irongate.swansea.linux.org.uk>
References: <Pine.LNX.3.96.1020911110502.12605A-100000@gatekeeper.tmr.com> 
	<1031760229.2768.54.camel@irongate.swansea.linux.org.uk>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.3 (1.0.3-6) 
Date: 11 Sep 2002 13:55:07 -0500
Message-Id: <1031770508.9726.17.camel@stout.americas.sgi.com>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2002-09-11 at 11:03, Alan Cox wrote:
> Thats never been the big concern. The problem has always been that XFS
> was very invasive code so it might break stuff for people who dont
> choose to use experimental xfs stuff. Thats slowly improving

Alan - 

The last patch Christoph posted against 2.5 is not the least bit 
invasive.  Excluding documentation and configuration files, these are
the changes:

o 1 new process flag:   +#define PF_FSTRANS 0x00100000
o 1 new CTL_VM name:    +       VM_PAGEBUF=18
o 1 new CTL_FS name:    +       FS_XFS=17
o 1 exported symbol:    +EXPORT_SYMBOL(mark_page_accessed);

and of course an addition to fs/Makefile:
+obj-$(CONFIG_XFS_FS)           += xfs/

That's it.  The rest is under fs/xfs.

(2.4 is more invasive, but this thread started out talking about XFS in
2.5).

-Eric
-- 
Eric Sandeen      XFS for Linux     http://oss.sgi.com/projects/xfs
sandeen@sgi.com   SGI, Inc.         651-683-3102

