Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315459AbSGFISk>; Sat, 6 Jul 2002 04:18:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315463AbSGFISk>; Sat, 6 Jul 2002 04:18:40 -0400
Received: from mta01bw.bigpond.com ([139.134.6.78]:39143 "EHLO
	mta01bw.bigpond.com") by vger.kernel.org with ESMTP
	id <S315459AbSGFISi>; Sat, 6 Jul 2002 04:18:38 -0400
From: Brad Hards <bhards@bigpond.net.au>
To: Linus Torvalds <torvalds@transmeta.com>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [patch] Typo fixes in input code
Date: Sat, 6 Jul 2002 18:17:43 +1000
User-Agent: KMail/1.4.5
References: <Pine.LNX.4.33.0207051646280.2484-100000@penguin.transmeta.com>
In-Reply-To: <Pine.LNX.4.33.0207051646280.2484-100000@penguin.transmeta.com>
Cc: vojtech@twilight.ucw.cz
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="------------Boundary-00=_J1JT9N9N81KVESGMNTDJ"
Message-Id: <200207061817.43224.bhards@bigpond.net.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--------------Boundary-00=_J1JT9N9N81KVESGMNTDJ
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 8bit
Content-Disposition: inline

On Sat, 6 Jul 2002 09:54, Linus Torvalds wrote:
> More merges all over the map - ppc, scsi, USB, kbuild, input drivers etc.
Found a few typos in the input changes. Fixup patch attached.

Brad

-- 
http://conf.linux.org.au. 22-25Jan2003. Perth, Australia. Birds in Black.
--------------Boundary-00=_J1JT9N9N81KVESGMNTDJ
Content-Type: text/x-diff;
  charset="iso-8859-1";
  name="inputtypos-2.5.25.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment; filename="inputtypos-2.5.25.patch"

diff -Naur -X dontdiff linux-2.5.25-clean/drivers/input/gameport/Config.help linux-2.5.25-twidler/drivers/input/gameport/Config.help
--- linux-2.5.25-clean/drivers/input/gameport/Config.help	Sat Jul  6 09:42:18 2002
+++ linux-2.5.25-twidler/drivers/input/gameport/Config.help	Sat Jul  6 17:54:26 2002
@@ -34,7 +34,7 @@
   The module will be called lightning.o. If you want to compile it as
   a module, say M here and read <file:Documentation/modules.txt>.
 
-CONFIG_GAMEPORT_EMU10K1
+CONFIG_INPUT_EMU10K1
   Say Y here if you have a SoundBlaster Live! or SoundBlaster
   Audigy card and want to use its gameport.
 
@@ -52,7 +52,7 @@
   The module will be called vortex.o. If you want to compile it as a
   module, say M here and read <file:Documentation/modules.txt>.
 
-CONFIG_GAMEPORT_CS461X
+CONFIG_GAMEPORT_CS461x
   Say Y here if you have a Cirrus CS461x aka "Crystal SoundFusion"
   PCI audio accelerator and want to use its gameport.
 
diff -Naur -X dontdiff linux-2.5.25-clean/drivers/input/joystick/Config.help linux-2.5.25-twidler/drivers/input/joystick/Config.help
--- linux-2.5.25-clean/drivers/input/joystick/Config.help	Sat Jul  6 09:42:03 2002
+++ linux-2.5.25-twidler/drivers/input/joystick/Config.help	Sat Jul  6 17:50:53 2002
@@ -1,4 +1,4 @@
-CONFIG_JOYSTICK
+CONFIG_INPUT_JOYSTICK
   If you have a joystick, 6dof controller, gamepad, steering wheel,
   weapon control system or something like that you can say Y here
   and the list of supported devices will be displayed. This option
diff -Naur -X dontdiff linux-2.5.25-clean/drivers/input/joystick/Config.in linux-2.5.25-twidler/drivers/input/joystick/Config.in
--- linux-2.5.25-clean/drivers/input/joystick/Config.in	Sat Jul  6 09:42:33 2002
+++ linux-2.5.25-twidler/drivers/input/joystick/Config.in	Sat Jul  6 17:49:56 2002
@@ -22,7 +22,7 @@
 dep_tristate '  SpaceTec SpaceOrb/Avenger 6dof controllers' CONFIG_JOYSTICK_SPACEORB $CONFIG_INPUT $CONFIG_INPUT_JOYSTICK $CONFIG_SERIO
 dep_tristate '  SpaceTec SpaceBall 6dof controllers' CONFIG_JOYSTICK_SPACEBALL $CONFIG_INPUT $CONFIG_INPUT_JOYSTICK $CONFIG_SERIO
 dep_tristate '  Gravis Stinger gamepad' CONFIG_JOYSTICK_STINGER $CONFIG_INPUT $CONFIG_INPUT_JOYSTICK $CONFIG_SERIO
-dep_tristate '  Twiddler as as joystick' CONFIG_JOYSTICK_TWIDDLER $CONFIG_INPUT $CONFIG_INPUT_JOYSTICK $CONFIG_SERIO
+dep_tristate '  Twiddler as a joystick' CONFIG_JOYSTICK_TWIDDLER $CONFIG_INPUT $CONFIG_INPUT_JOYSTICK $CONFIG_SERIO
 
 dep_tristate '  Multisystem, Sega Genesis, Saturn joysticks and gamepads' CONFIG_JOYSTICK_DB9 $CONFIG_INPUT $CONFIG_INPUT_JOYSTICK $CONFIG_PARPORT
 dep_tristate '  Multisystem, NES, SNES, N64, PSX joysticks and gamepads' CONFIG_JOYSTICK_GAMECON $CONFIG_INPUT $CONFIG_INPUT_JOYSTICK $CONFIG_PARPORT

--------------Boundary-00=_J1JT9N9N81KVESGMNTDJ--

