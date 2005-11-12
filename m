Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751324AbVKLCYV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751324AbVKLCYV (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 11 Nov 2005 21:24:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751326AbVKLCYV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 11 Nov 2005 21:24:21 -0500
Received: from smtp.osdl.org ([65.172.181.4]:22400 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751324AbVKLCYV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 11 Nov 2005 21:24:21 -0500
Date: Fri, 11 Nov 2005 18:24:18 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Linuv 2.6.15-rc1
Message-ID: <Pine.LNX.4.64.0511111753080.3263@g5.osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Ok,
 there it is, go wild. Get the git trees, the tar-balls and the patches 
(some or all of tghe above may still be mirroring out but should show up 
shortly).

It's hard to go through in any great detail, because even the shortlog is 
actually almost five thousand lines and about 200kB in size, and would 
thus run afoul of the mailing list limits so I can't include it here.

The same is true of the diffstat, only even more so. The unidiff is about 
a million lines in size, just the diffstat is 300+kB.

The changes are really pretty much all over the place, with over four 
thousand commits merged in the two weeks since 2.6.14...

v4l, dm, networking, NFS, SCSI, sound, drm, agp, cpufreq, input, i2c, jfs, 
xfs, jffs2, ntfs, cifs, network drivers, infiniband.. You name it.

Big architecture changes: the normal flow of arm updates, but also parisc 
updates and a couple of big MIPS updates. And the powerpc architecture got 
re-jigged a lot..

The ppc32 and ppc64 trees have largely been merged (to a new generic 
"powerpc" architecture that can be compiled either 32-bit or 64-bit), and 
that moved a number of files around. Similarly, the core block-layer got 
moved to its own subdirectory.

Oh, and the inevitable qla firmware updates probably account for over 
fifty thousand of the diff lines.  So those things partly explain how you 
get a million-line diff without actually necessarily having conceptual 
changes that big.

In fact, a lot of the changes are quite small. There's just a lot of 
those too..

Those with git access can easily get the shortlog (which is still pretty 
readable) with

	git log --no-merges v2.6.14..v2.6.15-rc1 | git-shortlog

and it only takes half a second to generate on a fast machine. It's 
worth it if only because of this entry:

	Adrian Bunk:
	      I am the new monkey.

(among the four-thousand other non-simian ones).

			Linus
