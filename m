Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264644AbTBNSNa>; Fri, 14 Feb 2003 13:13:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264681AbTBNSN3>; Fri, 14 Feb 2003 13:13:29 -0500
Received: from [195.223.140.107] ([195.223.140.107]:64644 "EHLO athlon.random")
	by vger.kernel.org with ESMTP id <S264644AbTBNSN3>;
	Fri, 14 Feb 2003 13:13:29 -0500
Date: Fri, 14 Feb 2003 19:24:34 +0100
From: Andrea Arcangeli <andrea@suse.de>
To: linux-kernel@vger.kernel.org
Subject: 2.4.21pre4aa2
Message-ID: <20030214182434.GY1499@dualathlon.random>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
X-GPG-Key: 1024D/68B9CB43
X-PGP-Key: 1024R/CB4660B9
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I released a 2.4.21pre4aa2 but I hadn't time to write a changelog or to
test it yet, so be careful. I'll write the changelog but not today.

this should fix a race in ll_rw_block that could explain hanging
machines, I believe this race wasn't new and that it affects mainline
too, but just made visible by the elevator-lowlatency for a few reasons.

Jeff, uml is way overcomplex to maintain these days, you must drop the
non skas mode, there's no value at all in using uml w/o having memory
protection for the kernel, it's as secure as running msdos, when it
crashes you don't know if it was a buggy app or a kernel bug.  So please
drop the overdesign and also please make patches that can compile on all
architectures, I had to put horrible #ifdefs around the do_mmap_pgoff
breakages to avoid breaking everything. I'd appreciate if you could look
at the incremental patches that I'm maintaining to make it compile so
you see things like cpu() breakages etc.. If you could also verify that
it works that would be great thanks, it linked but I can't say it works.

Andrea
