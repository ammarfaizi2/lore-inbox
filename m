Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280938AbRLUMNZ>; Fri, 21 Dec 2001 07:13:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280836AbRLUMNQ>; Fri, 21 Dec 2001 07:13:16 -0500
Received: from garrincha.netbank.com.br ([200.203.199.88]:24841 "HELO
	netbank.com.br") by vger.kernel.org with SMTP id <S280825AbRLUMNE>;
	Fri, 21 Dec 2001 07:13:04 -0500
Date: Fri, 21 Dec 2001 04:39:46 -0200 (BRST)
From: Rik van Riel <riel@conectiva.com.br>
X-X-Sender: <riel@imladris.surriel.com>
To: <linux-mm@kvack.org>
Cc: <linux-kernel@vger.kernel.org>
Subject: [PATCH *] reverse mapping VM 7
Message-ID: <Pine.LNX.4.33L.0112210437530.15741-100000@imladris.surriel.com>
X-spambait: aardvark@kernelnewbies.org
X-spammeplease: aardvark@nl.linux.org
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

NOTE: this patch is completely untested, except for verifying that
      it compiles ... but what do you want at 04:30 ?  ;)

The 7th version of the reverse mapping based VM is now available.
This is an attempt at making a more robust and flexible VM
subsystem, while cleaning up a lot of code at the time. The patch
is available from:

           http://surriel.com/patches/2.4/2.4.16-rmap-7
and        http://linuxvm.bkbits.net/


The big TODO items for the _next_ release are:
  - fix page_launder() so it doesn't submit the whole
    inactive_dirty list for writeout in one go
  - tune the balancing, under some strange loads I seem
    to be able to trigger a livelock


rmap 7:
  - clean up and document vmscan.c                        (me)
  - reduce size of page struct, part one                  (William Lee Irwin)
  - add rmap.h for other archs (untested, not for ARM)    (me)
rmap 6:
  - make the active and inactive_dirty list per zone,
    this is finally possible because we can free pages
    based on their physical address                       (William Lee Irwin)
  - cleaned up William's code a bit                       (me)
  - turn some defines into inlines and move those to
    mm_inline.h (the includes are a mess ...)             (me)
  - improve the VM balancing a bit                        (me)
  - add back inactive_target to /proc/meminfo             (me)
rmap 5:
  - fixed recursive buglet, introduced by directly
    editing the patch for making rmap 4 ;)))              (me)
rmap 4:
  - look at the referenced bits in page tables            (me)
rmap 3:
  - forgot one FASTCALL definition                        (me)
rmap 2:
  - teach try_to_unmap_one() about mremap()               (me)
  - don't assign swap space to pages with buffers         (me)
  - make the rmap.c functions FASTCALL / inline           (me)
rmap 1:
  - fix the swap leak in rmap 0                           (Dave McCracken)
rmap 0:
  - port of reverse mapping VM to 2.4.16                  (me)

cheers,

Rik
-- 
Shortwave goes a long way:  irc.starchat.net  #swl

http://www.surriel.com/		http://distro.conectiva.com/


