Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262174AbTI0FHm (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 27 Sep 2003 01:07:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262183AbTI0FHl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 27 Sep 2003 01:07:41 -0400
Received: from c-66-177-165-41.se.client2.attbi.com ([66.177.165.41]:53143
	"EHLO grammarian.homelinux.net") by vger.kernel.org with ESMTP
	id S262174AbTI0FHi convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 27 Sep 2003 01:07:38 -0400
From: Michael Pyne <pynm0001@unf.edu>
To: linux-kernel@vger.kernel.org
Subject: Bug report: intel8x0 sound
Date: Sat, 27 Sep 2003 01:06:40 -0400
User-Agent: KMail/1.5.9
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: Text/Plain;
  charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Message-Id: <200309270107.19516.pynm0001@unf.edu>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

There is a problem with sound using the ALSA intel8x0 driver, which causes the 
rate of audio playback to fluctuate in speed.  This SEEMS to be trigged every 
time by using alsamixer to unmute the "Digital Audio Mode" setting, but I've 
also had it happen all of a sudden.

The sound rate fluctuation occurs in all audio programs, both those using 
ALSA, and those using ALSA's OSS emulation mode.  It also occurs whether or 
not the sound is compiled as a module.  Compiling as a module is handy in 
this case, because the problem goes away after unloading and reloading the 
module.

I first noticed the problem in 2.6.0-test4, and it still appears in 2.6.0-
test5, and also in 2.6.0-test5-mm4.  The problem doesn't seem to affect 2.4.x 
with ALSA 0.9.2, but I haven't had a chance to try switching Digital Audio 
Mode there yet.  2.4.x with ALSA >0.9.5 is definitely affected, however.

I tried reporting this bug on kernel.org's Bugzilla (It is bug #1195),
access from http://bugzilla.kernel.org/show_bug.cgi?id=1195
but nothing has come from that.  I've also tried e-mail Jaroslav Kysela, the 
maintainer of the file at perez@suse.cz, but I got some error message back 
from that try.  I'm a very competent C programmer, and I'm very willing to 
assist in fixing this bug, but the code in intel8x0.c has me rather 
mystified. :D

Helpful information:
Kernel version (current): 2.6.0-test5-mm4
Bootloader: GRUB
CPU: Intel Pentium IV
Sound card: On-board sound, Analog Devices AD1885.  ALSA reports the card as 
Intel 82801BA-ICH2.
Motherboard: I believe it is Intel i815-based, but I can't be certain.  It's a 
custom-assembled Compaq Presario 5000.

If there's anything else someone needs to know, please ask.  Also, PLEASE CC: 
me on any replies, as I'm not currently subscribed to this list (although I 
love the weekly Kernel Traffic reports :D)

Thanks in advance!
 - Michael Pyne
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.3 (GNU/Linux)

iD8DBQE/dRrnqjQYp5Omm0oRAptYAKDOjthlzn5TlbmbzMWQ8JGPX7XnOgCgnVby
Y9VUtMF7KeLRmfOhouirdQM=
=XeXy
-----END PGP SIGNATURE-----
