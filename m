Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261627AbUDCITY (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 3 Apr 2004 03:19:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261628AbUDCITY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 3 Apr 2004 03:19:24 -0500
Received: from postfix4-1.free.fr ([213.228.0.62]:34788 "EHLO
	postfix4-1.free.fr") by vger.kernel.org with ESMTP id S261627AbUDCITV
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 3 Apr 2004 03:19:21 -0500
To: linux-kernel@vger.kernel.org
Subject: Re: Drivers *dropped* between releases? (sis5513.c)
Mail-Copies-To: never
X-Face: ,MPrV]g0IX5D7rgJol{*%.pQltD?!TFg(`c8(2pkt-F0SLh(g3mIFYU1GYf]C/GuUTbr;cZ5y;3ALK%.OL8A.^.PW14e/,X-B?Nv}2a9\u-j0sSa
References: <1GDM3-6G3-5@gated-at.bofh.it> <1GFEd-8b8-15@gated-at.bofh.it>
From: Roland Mas <roland.mas@free.fr>
Date: Sat, 03 Apr 2004 10:19:17 +0200
In-Reply-To: <1GFEd-8b8-15@gated-at.bofh.it> (Lionel Bouton's message of
 "Sat, 03 Apr 2004 00:50:09 +0200")
Message-ID: <87zn9t1nju.fsf@mirexpress.internal.placard.fr.eu.org>
User-Agent: Gnus/5.1006 (Gnus v5.10.6) Emacs/21.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Lionel Bouton, 2004-04-03 00:50:09 +0200 :

[...]

> The driver uses 2 ways of finding SiS Ide chips :
> - by northbridge PCI ids, which is what was always used historically
> (and so you had to manually add each known SiS northbridge to a table),
> - by probing the controller directly (avoids depending on a lazy coder
> to add entries in a table to make your chip work).
>
> When the last was added, some PCI ids were removed from the table
> (being superfluous).
>
> The very fact that the sis5513.c outputs something in your log means
> that it has found something to handle, so the detection routine
> (whichever it is) works.

  Indeed.  The logs do show the type and brand of both the hard disk
drive and the CD-ROM drive.  It's just that, uh, well, the kernel
doesn't want to do anything with them afterwards...

> I think there's a common problem with SiS chips : interrupt
> handling. I believe it is the source of your problem. I may find
> time to hack on this.

  Thanks already :-)

> You could try to remove PCI cards and/or disable VGA IRQ in the
> bios. On one of my SiS-based systems for example adding a PCI card
> can make it unbootable.

  Hm.  There's only one PCI card (Radeon 7000), and I'm not sure I can
boot without it, as there's no on-board VGA controller.  I'll try the
BIOS hack though.

  More relevant info (maybe): I got an old version of the Debian
installer, which uses an older kernel, and the process goes on
normally (well, it halts later because the built-in NIC has a stupid
MAC address, but that's another problem).

  Thanks for the tips, I'll see how it goes.

Roland.
-- 
Roland Mas

Food, shelter, source code.
  -- Cyclic Software
