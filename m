Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S284352AbRLCIvv>; Mon, 3 Dec 2001 03:51:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281821AbRLCItZ>; Mon, 3 Dec 2001 03:49:25 -0500
Received: from ugw.utcc.utoronto.ca ([128.100.100.3]:7401 "HELO
	ugw.utcc.utoronto.ca") by vger.kernel.org with SMTP
	id <S284867AbRLCHwk>; Mon, 3 Dec 2001 02:52:40 -0500
To: linux-kernel@vger.kernel.org
Subject: Re: Deadlock on kernels > 2.4.13-pre6
In-Reply-To: <20011130164031.A8741@wolverine.lohacker.net> from "Emmanuele
	Bassi" at Nov 30, 2001 04:40:31 PM
Date: Mon, 3 Dec 2001 02:52:34 -0500
From: Chris Siebenmann <cks@utcc.utoronto.ca>
Message-Id: <01Dec3.025238est.230202@ugw.utcc.utoronto.ca>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

| I've recently compiled and tested each kernel since 2.4.13-pre6[0],
| and I've noticed a recurrent (and reproducible[1]) deadlock on my
| system when I try to play an mp3[2].

 I have now seen two lockups under 2.4.16 that may be the same problem.
Points of similarity:
- playing mp3s (both times have been streaming mp3 audio over my PPP link)
- Creative Soundblaster AWE (AWE32 for me, though); mine is configured
  entirely through the kernel's PnP mechanisms.

 I believe my lockups are irregular and infrequent, but it may just feel
that way to me because I haven't listened to mp3's on this machine very
much.

 When the hang happens, the first symptom is that my mouse cursor in
X locks and stops tracking; music continues playing for a bit longer
before stopping. As far as I can tell nothing really happens after that
point; if I forcefully disconnect the PPP link it does not redial, for
example. SysRq-B will reboot the machine but SysRq-S to sync it will
produce no audible results, and SysRq-U doesn't seem to have any effect.
(This is an isolated home machine, which makes more precise diagnostics
hard to get when it hangs in X.)

 2.4.13-ac5 is, as far as I can tell, completely stable. I don't have
experience with intermediate kernel versions; I jumped straight from
2.4.13-ac5 to 2.4.16.

 My environment is UP Pentium II, ext2, aic7880 SCSI with a single disk,
Matrox G400 AGP graphics, XFree86 4.1.0 (using the fully free drivers).
Both lockups have happened while X was running.

 I will see if I can reproduce a lockup in the console and capture
SysRq output that's got some useful information.

	- cks
