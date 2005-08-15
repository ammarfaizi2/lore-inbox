Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964993AbVHOVud@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964993AbVHOVud (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 15 Aug 2005 17:50:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964996AbVHOVud
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 Aug 2005 17:50:33 -0400
Received: from mail.suse.de ([195.135.220.2]:15073 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S964993AbVHOVuc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 Aug 2005 17:50:32 -0400
Date: Mon, 15 Aug 2005 23:50:18 +0200
From: Olaf Hering <olh@suse.de>
To: Jeff Dike <jdike@addtoit.com>
Cc: Linus Torvalds <torvalds@osdl.org>, Arjan van de Ven <arjan@infradead.org>,
       Steven Rostedt <rostedt@goodmis.org>,
       LKML <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@osdl.org>
Subject: Re: [PATCH] Fix mmap_kmem (was: [question] What's the difference between /dev/kmem and /dev/mem)
Message-ID: <20050815215018.GA14747@suse.de>
References: <1123796188.17269.127.camel@localhost.localdomain> <1123809302.17269.139.camel@localhost.localdomain> <Pine.LNX.4.58.0508120930150.3295@g5.osdl.org> <1123951810.3187.20.camel@laptopd505.fenrus.org> <Pine.LNX.4.58.0508130955010.19049@g5.osdl.org> <1123953924.3187.22.camel@laptopd505.fenrus.org> <Pine.LNX.4.58.0508131034350.19049@g5.osdl.org> <20050815193307.GA11025@aepfle.de> <20050815211419.GA7348@ccure.user-mode-linux.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20050815211419.GA7348@ccure.user-mode-linux.org>
X-DOS: I got your 640K Real Mode Right Here Buddy!
X-Homeland-Security: You are not supposed to read this line! You are a terrorist!
User-Agent: Mutt und vi sind doch schneller als Notes (und GroupWise)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 On Mon, Aug 15, Jeff Dike wrote:

> On Mon, Aug 15, 2005 at 09:33:07PM +0200, Olaf Hering wrote:
> > ARCH=um doesnt like your version, but mine.
> > 
> > drivers/char/mem.c:267: error: invalid operands to binary <<
> > 
> >         pfn = (__pa((u64)vma->vm_pgoff) << PAGE_SHIFT) >> PAGE_SHIFT;
> 
> My page.h was missing some parens.  Try the patch below.

compiles ok now, I hope it works.
