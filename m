Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750724AbVIMDeY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750724AbVIMDeY (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 Sep 2005 23:34:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750774AbVIMDeY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 Sep 2005 23:34:24 -0400
Received: from smtp.osdl.org ([65.172.181.4]:11749 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1750724AbVIMDeX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 Sep 2005 23:34:23 -0400
Date: Mon, 12 Sep 2005 20:34:17 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: "Read my lips: no more merges" - aka Linux 2.6.14-rc1
Message-ID: <Pine.LNX.4.58.0509122019560.3351@g5.osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Ok, it's been two weeks (actually, two weeks and one day) since 2.6.13, 
and that means that the merge window is closed. I've released a 
2.6.14-rc1, and we're now all supposed to help just clean up and fix 
everything, and aim for a really solid 2.6.14 release.

Both the diffstat and the shortlog are so big that I can't post them on 
the kernel mailing list without getting the email killed by the size 
restrictions, so there's not a lot to say. 

alpha, arm, x86, x86-64, ppc, ia64, mips, sparc, um.. Pretty much every
architecture got some updates. And an absolutely _huge_ ACPI diff, largely 
because of some re-indentation.

drm, watchdog, hwmon, i2c, infiniband, input layer, md, dvb, v4l, network,
pci, pcmcia, scsi, usb and sound driver updates. People may appreciate
that the most common wireless network drivers got merged - centrino
support is now in the standard kernel.

On the filesystem level, FUSE got merged, and ntfs and xfs got updated. In 
the core VFS layer, the "struct files" thing is now handled with RCU and 
has less expensive locking.

And networking changes.

In other words, a lot of stuff all over the place. Be nice now, and follow 
the rules: put away the new toys, and instead work on making sure the 
stuff that got merged is all solid. Ok?

Anybody with git can do the shortlog with

	git-rev-list --no-merges --pretty=short v2.6.14-rc1 ^v2.6.13 |
		git-shortlog | less -S

which is actually pretty informative.

			Linus
