Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269653AbRHICef>; Wed, 8 Aug 2001 22:34:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269668AbRHICeZ>; Wed, 8 Aug 2001 22:34:25 -0400
Received: from islay.mach.uni-karlsruhe.de ([129.13.162.92]:35249 "EHLO
	mailout.plan9.de") by vger.kernel.org with ESMTP id <S269653AbRHICeW>;
	Wed, 8 Aug 2001 22:34:22 -0400
Date: Thu, 9 Aug 2001 04:34:31 +0200
From: <pcg@goof.com ( Marc) (A.) (Lehmann )>
To: linux-kernel@vger.kernel.org
Subject: Re: I/O very slow under 2.4 (device reading)
Message-ID: <20010809043431.C2456@cerebro.laendle>
Mail-Followup-To: linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
X-Operating-System: Linux version 2.4.8-pre7 (root@cerebro) (gcc version 3.0.1 20010716 (prerelease)) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 08, 2001 at 11:12:45AM -0700, Linus Torvalds <torvalds@transmeta.com> wrote:
> and the VM disagree about how/when to allocate memory. It's fixed by the patch
> I'll make a real pre-patch (2.4.8-pre7) with the full changeset, can you

after 10 gigs of reading:

   procs                      memory    swap          io     system         cpu
 r  b  w   swpd   free   buff  cache  si  so    bi    bo   in    cs  us  sy  id
 0  1  0      0   6828 372696  36340   0   0 48292     6  726  2188   0  25  75
 0  1  0      0   6880 370536  39352   0   0 33792     0  726  3725   1  37  62
 1  0  1      0   6880 370160  36340   0   0 25652    48  411  3374   1  82  17
 0  1  0      0   6628 370780  36288   0   0 44788     0  690  2071   1  31  68
 1  0  1      0   6832 372972  36264   0   0 41988     0  674  2933   0  42  57

the system still feels a bit sluggishly, but otherwise NO SIGN of that
problem (no io slowdown, no short freezes). just the usual "disks are
in-use" contentions.

cool ,)

> at a nice stable 21MB/s which is all my disk can deliver. 

you _should_ know that raw speed doesn't mean too much.

> [ Damn, maybe I should get one of those nice big 7200 rpm IBM drives ]

maybe noisier. and for some reason (I swear for ibm drives usually), they
keep getting uncorrectable media errors on all of my machines.. ;) still
they are the best ones available ;)

-- 
      -----==-                                             |
      ----==-- _                                           |
      ---==---(_)__  __ ____  __       Marc Lehmann      +--
      --==---/ / _ \/ // /\ \/ /       pcg@goof.com      |e|
      -=====/_/_//_/\_,_/ /_/\_\       XX11-RIPE         --+
    The choice of a GNU generation                       |
                                                         |
