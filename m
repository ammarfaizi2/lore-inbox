Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932320AbWAQIT7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932320AbWAQIT7 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 Jan 2006 03:19:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932323AbWAQIT7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 Jan 2006 03:19:59 -0500
Received: from smtp.osdl.org ([65.172.181.4]:19656 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932320AbWAQIT6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 Jan 2006 03:19:58 -0500
Date: Tue, 17 Jan 2006 00:19:56 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Linux 2.6.16-rc1
Message-ID: <Pine.LNX.4.64.0601170001530.13339@g5.osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Ok, it's two weeks since 2.6.15, and the merge window is closed.

In fact, it already closed yesterday when I was planning on doing the 
release, but we had people over for dinner, and things devolved. "The 
best-laid plans of mice and kernel-developers.."

Anyway, it's out there now. The ShortLog is pretty readable - if you are 
into that kind of stuff - but as usual for an -rc1 release (which has all 
the frantic merging going on), it's actually too big to post on the kernel 
list due to the size limits. It's weighs in at 4000+ lines and 169kB.

Anyway, if you're a git user, here's what generated the shortlog:

	git-rev-list --no-merges --pretty=short v2.6.15..v2.6.16-rc1 | 
		git-shortlog > ../ShortLog

and you can find the _full_ log on kernel.org as ChangeLog-2.6.16-rc1 if 
you want to.

The diffstat is also too big to post. It's also all over the map: there's 
actually a fair number of cleanups in there that have affected a lot of 
files, as did the new mutexes, for example. 

There's also updates for various architectures: powerpc continues the long 
slog to a merged tree - now ppc32 is mostly done too, but there's updates 
to arm, x86[-64], m68k, frv, ia64, pa-risc, m32r, s390, etc..

And usb, i2c, pcmcia, fbdev, v4l, drm, scsi, alsa, input layer, network 
drivers, infiniband.. The tty layer got some clean-ups too (wonder of 
wonders).

OCFS2 was merged, fuse updates, fat fixes, and p9fs, XFS and NFS updates.

And largish networking updates: there's a "common netfilter" setup now, 
which you'll notice when you do "make config" or equivalent, since a lot 
of the netfilter rules now work on ipv4 and/or ipv6 rather than having 
separate (and duplicate) versions for each.

			Linus
