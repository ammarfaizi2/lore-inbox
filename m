Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268463AbRGXVX6>; Tue, 24 Jul 2001 17:23:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268462AbRGXVXs>; Tue, 24 Jul 2001 17:23:48 -0400
Received: from willow.seitz.com ([207.106.55.140]:4100 "EHLO willow.seitz.com")
	by vger.kernel.org with ESMTP id <S268466AbRGXVXf>;
	Tue, 24 Jul 2001 17:23:35 -0400
From: Ross Vandegrift <ross@willow.seitz.com>
Date: Tue, 24 Jul 2001 17:23:40 -0400
To: linux-kernel@vger.kernel.org
Subject: FPU emulation problems in 2.4
Message-ID: <20010724172340.A476@willow.seitz.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org
Original-Recipient: rfc822;linux-kernel-outgoing

Hello everyone,

	In my quest to get 2.4 and netfilter running on my machines
I have been having tons of problems on some [34]86sx machines that 
we use.  On all of them the kernel freezes hard right after saying

VFS: Mounted root (ext2 filesystem) readonly.
Freeing unused kernel memory: 196k freed

No keyboard, no SysRq, need a hard reset.  I also tried this on an
AMD K6-2.  With hardware FPU it works fine, but loading with no387
gives an error:

FPU Emulator: Unknown prefix byte 0x00, probably due to
FPU Emulator: self-modifying code! (emulation impossible)
FPU Emulator: Internet error type 0x0126
At 00000023:0286
	SW: b=1  st=0  es=1  sf=1  cc=0010 ef=111111
	CW: ic=0 rc=00 pc=11 iem=0         ef=111111

Searching the archives showed a bug report against 2.1.5 that said
basically the same thing.  Unfortunately there were no more messages
in the thread.

Ross Vandegrift
coolio@tmbg.org
ross@willow.seitz.com
