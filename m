Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319463AbSH3HJM>; Fri, 30 Aug 2002 03:09:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319466AbSH3HJL>; Fri, 30 Aug 2002 03:09:11 -0400
Received: from mx7.sac.fedex.com ([199.81.194.38]:15634 "EHLO
	mx7.sac.fedex.com") by vger.kernel.org with ESMTP
	id <S319463AbSH3HJK>; Fri, 30 Aug 2002 03:09:10 -0400
Date: Fri, 30 Aug 2002 15:12:40 +0800 (SGT)
From: Jeff Chua <jchua@fedex.com>
X-X-Sender: root@boston.corp.fedex.com
To: rmk@arm.linux.org.uk, Alan Cox <alan@lxorguk.ukuu.org.uk>
cc: Erik Andersen <andersen@codepoet.org>,
       Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [BUG] initrd >24MB corruption (fwd)
In-Reply-To: <Pine.LNX.4.44.0208281345120.9089-100000@boston.corp.fedex.com>
Message-ID: <Pine.LNX.4.44.0208301509001.1666-100000@boston.corp.fedex.com>
MIME-Version: 1.0
X-MIMETrack: Itemize by SMTP Server on ENTPM11/FEDEX(Release 5.0.8 |June 18, 2001) at 08/30/2002
 03:13:16 PM,
	Serialize by Router on ENTPM11/FEDEX(Release 5.0.8 |June 18, 2001) at 08/30/2002
 03:13:33 PM,
	Serialize complete at 08/30/2002 03:13:33 PM
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Wed, 28 Aug 2002, Jeff Chua wrote:

from linux/arch/i386/mm/init.c

/*
 * paging_init() sets up the page tables - note that the first 8MB are
 * already mapped by head.S.
 *
 * This routines also unmaps the page at virtual kernel address 0, so
 * that we can trap those pesky NULL-reference errors in the kernel.
 */

#if CONFIG_X86_PAE
        /*
         * We will bail out later - printk doesnt work right now so
         * the user would just see a hanging kernel.
         */
        if (cpu_has_pae)
                set_in_cr4(X86_CR4_PAE);
#endif



... does that mean the gzipped fs can only be <8MB? That could explain why
the ram6MB.gz worked and ram8MB.gz doesn't.


Jeff


