Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289108AbSA1EgD>; Sun, 27 Jan 2002 23:36:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287881AbSA1Efz>; Sun, 27 Jan 2002 23:35:55 -0500
Received: from gw.lowendale.com.au ([203.26.242.120]:12040 "EHLO
	marina.lowendale.com.au") by vger.kernel.org with ESMTP
	id <S285516AbSA1Efm>; Sun, 27 Jan 2002 23:35:42 -0500
Date: Mon, 28 Jan 2002 16:02:09 +1100 (EST)
From: Neale Banks <neale@lowendale.com.au>
To: linux-kernel@vger.kernel.org
cc: linux-sound@vger.kernel.org, alan@redhat.com
Subject: [PATCHLET 2.2]Doc/sound/VIBRA16
Message-ID: <Pine.LNX.4.05.10201281554170.29762-100000@marina.lowendale.com.au>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Appended patch has corrections and minor update for
Documentation/sound/VIBRA16

These changes are based on my experience with VIBRA16 and 2.2.21-pre2 on
Debian Potato on a Compaq Deskpro (which seems to manage all the ISApnp
itself :-).

Regards,
Neale.

--- linux-2.2.21-pre2-pristine/Documentation/sound/VIBRA16	Mon Mar 26 02:31:59 2001
+++ linux-2.2.21-pre2-ntb/Documentation/sound/VIBRA16	Mon Jan 28 14:50:40 2002
@@ -15,6 +15,8 @@
 (tried it with a 2.2.2-ac7), nor in the commercial OSS package (it reports
 it as half-duplex soundcard). Oh, I almost forgot, the RedHat sndconfig
 failed detecting it ;)
+	Kernel 2.2.21pre2 also works with this card.  /proc/sound
+reports "OSS/Free:3.8s2++-971130" and "Sound Blaster 16 (4.13) (DUPLEX)"
 	So, the big problem still remains, because the sb module wants a
 8-bit and a 16-bit dma, which we could not allocate for vibra... it supports
 only two 8-bit dma channels, the second one will be passed to the module
@@ -59,6 +61,8 @@
 you may want to:
 
 modprobe sb io=0x220 irq=5 dma=1 dma16=3
+# do you need MIDI?
+modprobe opl3 io=0x388
 
 	Or, take the hard way:
 
@@ -67,14 +71,18 @@
 insmod uart401
 insmod sb io=0x220 irq=5 dma=1 dma16=3
 # do you need MIDI?
-insmod opl3=0x388
+insmod opl3 io=0x388
 
 	Just in case, the kernel sound support should be:
 
 CONFIG_SOUND=m
 CONFIG_SOUND_OSS=m
 CONFIG_SOUND_SB=m
+# do you need MIDI? YM3812 gets you opl3.o...
+CONFIG_SOUND_YM3812=m
 	
 	Enjoy your new noisy Linux box! ;)
 	
 
+Minor corrections and updates
+	Neale Banks <neale@lowendale.com.au> Mon, 28 Jan 2002 15:06:35 +1100

