Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261382AbTCJRRx>; Mon, 10 Mar 2003 12:17:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261384AbTCJRRx>; Mon, 10 Mar 2003 12:17:53 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:58248 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S261382AbTCJRRw>;
	Mon, 10 Mar 2003 12:17:52 -0500
Date: Mon, 10 Mar 2003 17:28:32 +0000
From: Matthew Wilcox <willy@debian.org>
To: Pavel Machek <pavel@ucw.cz>
Cc: linux-kernel@vger.kernel.org, parisc-linux@parisc-linux.org
Subject: Re: ioctl32 cleanup -- rest of architectures
Message-ID: <20030310172832.GG5278@parcelfarce.linux.theplanet.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Could you cc myself or parisc-linux@parisc-linux.org in future please?

first, you've called it `compact_sys_ioctl' -- it should be `compat_sys_ioctl'.
it's compatible, not really small ;-)

second, you've not changed the definition in arch/parisc/kernel/syscall.S:

-	ENTRY_DIFF(ioctl)
+	ENTRY_COMP(ioctl)

-- 
"It's not Hollywood.  War is real, war is primarily not about defeat or
victory, it is about death.  I've seen thousands and thousands of dead bodies.
Do you think I want to have an academic debate on this subject?" -- Robert Fisk
