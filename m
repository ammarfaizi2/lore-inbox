Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129747AbQKOVgw>; Wed, 15 Nov 2000 16:36:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130140AbQKOVgq>; Wed, 15 Nov 2000 16:36:46 -0500
Received: from [194.213.32.137] ([194.213.32.137]:7172 "EHLO bug.ucw.cz")
	by vger.kernel.org with ESMTP id <S130150AbQKOVgc>;
	Wed, 15 Nov 2000 16:36:32 -0500
From: pavel-velo@bug.ucw.cz
Message-Id: <200011142012.VAA00150@bug.ucw.cz>
To: Szabolcs Szakacsits <szaka@f-secure.com>,
        Rik van Riel <riel@conectiva.com.br>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Linus Torvalds <torvalds@transmeta.com>, Ingo Molnar <mingo@elte.hu>
Subject: RE: KPATCH] Reserve VM for root (was: Re: Looking for better VM)
Date: Wed, 1 Jan 1997 22:21 -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

   >I've also never said OOM killer should be disabled. In theory the
   >non-overcommitting systems deadlock, Linux survives. Ironically
   >usually it's just the opposite in practice. Any user can
   >deadlock/crash Linux [default install, no quotas] but not an
   >non-overcommitting system [root can clean up]. Here is an example code
   >"simulating" a leaking daemon that will "deadlock" Linux even with
   >your OOM killer patch [that is anyway *MUCH* better than the actually
   >non-existing one in 2.2.x kernels]:
   >
   >main() { while(1) if (fork()) malloc(1); }
   >
   >With the patch below I could ssh to the host and killall the offending
   >processes. To enable reserving VM space for root do 

what about main() { while(1) system("ftp localhost &"); }

This. or so,ething similar should allow you to kill your machine even with your
patch from normal user account

														Pavel

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
