Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131497AbRDPORR>; Mon, 16 Apr 2001 10:17:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131498AbRDPORI>; Mon, 16 Apr 2001 10:17:08 -0400
Received: from se1.cogenit.fr ([195.68.53.173]:42245 "EHLO se1.cogenit.fr")
	by vger.kernel.org with ESMTP id <S131497AbRDPOQ6>;
	Mon, 16 Apr 2001 10:16:58 -0400
Date: Mon, 16 Apr 2001 16:16:49 +0200
From: Francois Romieu <romieu@cogenit.fr>
To: Linas Vepstas <linas@backlot.linas.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: fsck, raid reconstruction & bad bad 2.4.3 + some numbers
Message-ID: <20010416161649.A19273@se1.cogenit.fr>
In-Reply-To: <20010415181825.40FBB1BA03@backlot.linas.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=unknown-8bit
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.2.5i
In-Reply-To: <20010415181825.40FBB1BA03@backlot.linas.org>; from linas@backlot.linas.org on Sun, Apr 15, 2001 at 01:18:25PM -0500
X-Organisation: Marie's fan club - I
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linas Vepstas <linas@backlot.linas.org> écrit :
[...]
> I want to report a trio of raid-related problems.  The third one is 
> very serious, and effectively prevents 2.4.3 from being usable (by me).
> 
[...]
> The problem:  this dramatically slows fsck after an unclean shut-down.
> You can hear the drives machine-gunning.  I haven't stop-watch timed it,
> but its on the order of 5x slower to fsck a raid partition when there's
> reconstruction going on, then when the raid thinks its clean.  This
> makes unclean reboots quite painful.

Here 2.4.3 takes 15-20 minutes to fsck a 45 Go RAID1 fs after an
unclean shutdown (init=/bin/sh + raid1 autodetect = *boom*). The whole
reconstruction takes an hour (but system is in use).
The disks are IBM-DTLA-307045 on two differents ports of a PIIX4.
The machines includes two 9Go on a 53c875 that perform equally well
(tough a bit noisy during normal startup).

[2.4.3 experience]
> Whatever it is that changed in 2.4.3, it makes unclean reboots
> impossible ...

What does the swap says during the fsck ?

-- 
Ueimor
