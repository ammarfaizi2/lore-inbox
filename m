Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S270042AbRHSGHi>; Sun, 19 Aug 2001 02:07:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S270075AbRHSGH1>; Sun, 19 Aug 2001 02:07:27 -0400
Received: from penguin.e-mind.com ([195.223.140.120]:47223 "EHLO
	penguin.e-mind.com") by vger.kernel.org with ESMTP
	id <S270042AbRHSGHP>; Sun, 19 Aug 2001 02:07:15 -0400
Date: Sun, 19 Aug 2001 08:07:42 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: linux-kernel@vger.kernel.org
Subject: 2.4.9aa3
Message-ID: <20010819080742.A725@athlon.random>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-GnuPG-Key-URL: http://e-mind.com/~andrea/aa.gnupg.asc
X-PGP-Key-URL: http://e-mind.com/~andrea/aa.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Only in 2.4.9aa2: 00_silent-stack-overflow-5
Only in 2.4.9aa3: 00_silent-stack-overflow-6

	Updated to run expand_stack always with the mm write semaphore acquired
	to fix the race conditions. Upgrading the semaphore during
	map_user_kiobuf was quite painful so I just disallowed to do direct I/O
	on a growsdown VMA (you can still do that as far as it doesn't need to
	be live extended on the fly).

Only in 2.4.9aa3: 00_vm_raend-race-1

	Sanitize the vm_raend field before trusting it, such field is racy.

Only in 2.4.9aa2: 10_expand-stack-smp-1

	Dropped (it wasn't needed).

Only in 2.4.9aa2: 70_mmap-rb-4
Only in 2.4.9aa3: 70_mmap-rb-5

	Backed out a few unnecessary minor changes.

Andrea
