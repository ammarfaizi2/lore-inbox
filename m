Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267552AbTBRC3a>; Mon, 17 Feb 2003 21:29:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267560AbTBRC3a>; Mon, 17 Feb 2003 21:29:30 -0500
Received: from [66.246.35.106] ([66.246.35.106]:34716 "EHLO
	ofelia.farciert.com") by vger.kernel.org with ESMTP
	id <S267552AbTBRC33>; Mon, 17 Feb 2003 21:29:29 -0500
Subject: sis7012 and no sound
From: Jake Roersma <jake@copiosus.net>
To: Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.7 
Date: 17 Feb 2003 21:45:15 -0500
Message-Id: <1045536323.389.17.camel@phobos>
Mime-Version: 1.0
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - ofelia.farciert.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [0 0] / [0 0]
X-AntiAbuse: Sender Address Domain - copiosus.net
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I just got a new laptop and it has the sis7012 audio chipset in it.  I
am having a problem getting the sound work with the stock 2.4.18, and
2.4.20 kernels.  I did some googling on it and found that having ACPI
enabled in the kernel might help, but it didn't.  As of right now the
kernel finds the sis7012 chip fine with the i810_audio module and gives
the following output:

Feb 17 20:49:06 phobos kernel: Intel 810 + AC97 Audio, version 0.21,
20:35:29 Feb 17 2003
Feb 17 20:49:06 phobos kernel: i810: SiS 7012 found at IO 0xd800 and
0xdc00, IRQ 10
Feb 17 20:49:06 phobos kernel: ac97_codec: AC97 Audio codec, id:
0x414c:0x4710 (ALC200/200P)
Feb 17 20:49:06 phobos kernel: ac97_codec: AC97 Modem codec, id:
0x5349:0x4c22 (Silicon Laboratory Si3036)

I have also read that ACPI could be the problem in this case and
disabling it in the BIOS might resolve the problem. But my BIOS doesn't
have the option to disable ACPI, so there is no luck there.  The
permissions on /dev/dsp0 and /dev/mixer0 are both 666(just incase) and
dsp and mixer and symlinked respectfully:

ls -al /dev/dsp0
crw-rw-rw-    1 root     root      14,   3 Feb 16 02:41 /dev/dsp0
ls -al /dev/mixer 
crw-rw-rw-    1 root     root      14,   0 Feb 16 02:41 /dev/mixer0

ls -la /dev/dsp
lrwxrwxrwx    1 root     root            9 Feb 16 02:41 /dev/dsp ->
/dev/dsp0
ls -la /dev/mixer
lrwxrwxrwx    1 root     root           11 Feb 16 02:41 /dev/mixer ->
/dev/mixer0


If its an consolation CD sound does work, but I have a feeling its
unralated because I don't think that the CD sound is going through the
audio module, but i could be wrong.  I have checked the mixer settings
and made sure nothing is muted and volume is up. When I try to do the
following it hangs:

cat Explosion.wav > /dev/dsp

If someone could give me some direction it would be greatly apreciated.
Thanks in advance.

- Jake

