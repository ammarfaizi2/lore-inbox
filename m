Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263933AbRFXJme>; Sun, 24 Jun 2001 05:42:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263948AbRFXJmZ>; Sun, 24 Jun 2001 05:42:25 -0400
Received: from iq.sch.bme.hu ([152.66.214.168]:37052 "EHLO iq.rulez.org")
	by vger.kernel.org with ESMTP id <S263933AbRFXJmQ>;
	Sun, 24 Jun 2001 05:42:16 -0400
Date: Sun, 24 Jun 2001 11:54:25 +0200 (CEST)
From: Sasi Peter <sape@iq.rulez.org>
To: <linux-kernel@vger.kernel.org>
Subject: [OT] gcc 2.95.2 vs. 3.0 (fwd)
Message-ID: <Pine.LNX.4.33.0106241143220.30968-100000@iq.rulez.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

first of all, if you are not interested in compiler comparision, just
skip.

I though posting a little demonstration of how well performing code gcc
2.95.2 generates (vs. gcc 3.0) won't hurt. Also shown, that further
optimatizations are anything but impossible (using Intel's commercial c
compiler).

I know opendivx code is not like kernel code at all, but on the other hand
it is well suited for benchmark testing.

Maybe this will cool down thoose a bit, who were to move to gcc 3.0 as
fast as possible, for the _way_ better generated code...

-- 
SaPE - Peter, Sasi - mailto:sape@sch.hu - http://sape.iq.rulez.org/

---------- Forwarded message ----------
Date: Sun, 24 Jun 2001 04:31:56 +0200 (CEST)
From: Arpi <arpi@thot.banki.hu>
Reply-To: mplayer-users@lists.sourceforge.net
To: mplayer-users@lists.sourceforge.net
Subject: [Mplayer-users] gcc 2.95.2 vs. 3.0

Hi,

Just compiled and try gcc 3.0 stable.
And the results is very big surprise! It makes *SLOWER* code!

test file:  (opendivx with postprocessing, this stuff is written in C)
# mplayer -osdlevel 0 -nosound -benchmark 1800.avi -vo null -pp 15
VIDEO:  [divx]  640x352  24bpp  23.98 fps  1865.1 kbps (227.7 kbyte/s)

hardware: celeron-2 600 @ 900MHz (100MHz FSB), 256MB RAM (PC133, at 2/2/2)
(sse,mmx,mmxext enabled)

gcc 2.95.2 result:  (flags: -O4 -march=i686 -mcpu=i686 -pipe -ffast-math)
BENCHMARKs: V:   5.087s VO:   0.001s A:   0.000s Sys:   0.013s =    5.101s
BENCHMARK%: V: 99.7160% VO:  0.0258% A:  0.0000% Sys:  0.2582% = 100.0000%

gcc 3.0 result:  (flags: -O4 -march=i686 -mcpu=i686 -pipe -ffast-math)
BENCHMARKs: V:   5.194s VO:   0.001s A:   0.000s Sys:   0.013s =    5.208s
BENCHMARK%: V: 99.7309% VO:  0.0221% A:  0.0000% Sys:  0.2471% = 100.0000%

yes, speed diff isn't big, but i was prepared for big speed boost by 3.0,
and then i got speed loss! :(

if i recompile C-only parts of decore with intel's commercial C compiler
(free beta available for linux), it's about 15% faster:

icc result:  (optim. flags: -O2 -fp -rcd -tpp6 -xiMK)
BENCHMARKs: V:   4.415s VO:   0.001s A:   0.000s Sys:   0.013s =    4.429s
BENCHMARK%: V: 99.6676% VO:  0.0290% A:  0.0000% Sys:  0.3034% = 100.0000%


A'rpi / Astral & ESP-team

--
mailto:arpi@thot.banki.hu
http://esp-team.scene.hu

_______________________________________________
Mplayer-users mailing list
Mplayer-users@lists.sourceforge.net
http://lists.sourceforge.net/lists/listinfo/mplayer-users

