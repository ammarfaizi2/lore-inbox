Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129507AbRAAXqJ>; Mon, 1 Jan 2001 18:46:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129627AbRAAXp6>; Mon, 1 Jan 2001 18:45:58 -0500
Received: from [199.239.160.155] ([199.239.160.155]:17800 "EHLO
	tenchi.datarithm.net") by vger.kernel.org with ESMTP
	id <S129507AbRAAXpv>; Mon, 1 Jan 2001 18:45:51 -0500
Date: Mon, 1 Jan 2001 23:35:20 +0000
From: Robert Read <rread@datarithm.net>
To: linux-kernel@vger.kernel.org
Subject: Re: devices.txt inconsistency
Message-ID: <20010101233520.D8481@tenchi.datarithm.net>
Mail-Followup-To: linux-kernel@vger.kernel.org
In-Reply-To: <20010101170654.A5856@sourceware.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20010101170654.A5856@sourceware.net>; from compwiz@bigfoot.com on Mon, Jan 01, 2001 at 05:06:54PM -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

How's this?  Should char-major-15 be obsoleted, deleted or just left
in for now?

robert

--- linux/Documentation/devices.txt.bak Mon Jan  1 15:29:24 2001
+++ linux/Documentation/devices.txt     Mon Jan  1 15:33:38 2001
@@ -430,14 +430,14 @@
                  1 = /dev/dos_cd1      Second MSCDEX CD-ROM
                    ...
 
- 13 char       PC speaker (OBSOLETE)
-                 0 = /dev/pcmixer      Emulates /dev/mixer
-                 1 = /dev/pcsp         Emulates /dev/dsp (8-bit)
-                 4 = /dev/pcaudio      Emulates /dev/audio
-                 5 = /dev/pcsp16       Emulates /dev/dsp (16-bit)
+ 13 char       Generic Input Driver
+                 0  = /dev/input/js0        First joystick
+                 1  = /dev/input/js1        Second joystick
+                    ...
 
-               The current PC speaker driver uses the Open Sound
-               System interface, and these devices are obsolete.
+                 64 = /dev/input/event0     For testing/debugging
+                 65 = /dev/input/event1
+                   ...
 
     block      8-bit MFM/RLL/IDE controller
                  0 = /dev/xda          First XT disk whole disk                        

On Mon, Jan 01, 2001 at 05:06:54PM -0500, Ari Pollak wrote:
> This has not been fixed for at least a year that i can remember - in
> Documentation/devices.txt, it says /dev/js* should be char-major-15*,
> but in Documentation/joystick.txt it says it should be char-major-13.
> I'm assuming joystick.txt is the correct one, and devices.txt should be
> updated to reflect this.. before 2.4.0 would be nice.
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> Please read the FAQ at http://www.tux.org/lkml/
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
