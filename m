Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264405AbUFCWOI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264405AbUFCWOI (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Jun 2004 18:14:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264409AbUFCWOI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Jun 2004 18:14:08 -0400
Received: from smtp3.libero.it ([193.70.192.127]:23463 "EHLO smtp3.libero.it")
	by vger.kernel.org with ESMTP id S264405AbUFCWOC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Jun 2004 18:14:02 -0400
From: "Mario ''Jorge'' Di Nitto" <jorge78@inwind.it>
To: linux-kernel@vger.kernel.org
Subject: Re: 2.6.7-rc2-mm2
Date: Fri, 4 Jun 2004 00:15:00 +0200
User-Agent: KMail/1.6.2
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Message-Id: <200406040015.01248.jorge78@inwind.it>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi to all.

Today I've tried latest mm2 patch on my system and after reboot, X server 
can't start (blinking screen for 4 or 5 times, then a simple black screen and 
machine hangs).
After a new reboot with init 1, I found this in the Xfree86.0.log:

----------------------------------
[cut]
(II) Initializing built-in extension XINERAMA
(II) Initializing built-in extension XFree86-Bigfont
(II) Initializing built-in extension RENDER
(II) Initializing built-in extension RANDR
(II) Keyboard "Generic Keyboard" handled by legacy driver
(II) Synaptics touchpad driver version 0.13.2
Configured Mouse no synaptics event device found (checked 5 nodes)
(**) Option "Device" "/dev/psaux"
(**) Option "SHMConfig" "on"
(**) Option "LeftEdge" "1700"
(**) Option "RightEdge" "5300"
(**) Option "TopEdge" "1700"
(**) Option "BottomEdge" "4200"
(**) Option "FingerLow" "25"
(**) Option "FingerHigh" "30"
(**) Option "MaxTapTime" "180"
(**) Option "MaxTapMove" "220"
(**) Option "EmulateMidButtonTime" "100"
(**) Option "VertScrollDelta" "100"
Query no Synaptics: 6003C8
(EE) Configured Mouse no synaptics touchpad detected and no repeater device
(EE) Configured Mouse Unable to query/initialize Synaptics hardware.
(EE) PreInit failed for input device "Configured Mouse"
(II) UnloadModule: "synaptics"
(**) Option "Protocol" "ImPS/2"
(**) Generic Mouse: Protocol: "ImPS/2"
(**) Option "SendCoreEvents" "true"
(**) Generic Mouse: always reports core events
(**) Option "Device" "/dev/input/mice"
(**) Option "Emulate3Buttons" "true"
(**) Generic Mouse: Emulate3Buttons, Emulate3Timeout: 50
(**) Option "ZAxisMapping" "4 5"
(**) Generic Mouse: ZAxisMapping: buttons 4 and 5
(**) Generic Mouse: Buttons: 5
(WW) No core pointer registered
(II) XINPUT: Adding extended input device "Generic Mouse" (type: MOUSE)
(II) Generic Mouse: ps2EnableDataReporting: succeeded
No core pointer

Fatal server error:
failed to initialize core devices

------------------------------------

However, using the old 2.6.6-mm4 there's no problem.
The synaptic driver is the latest 0.13.2 and my .config shows:

CONFIG_INPUT_MOUSEDEV_PSAUX=y
CONFIG_SERIO_PCIPS2=m
CONFIG_MOUSE_PS2=y


TIA,
					Mario

PS: Just a little report for Sis framebuffer driver: it works fine on my 
sis650 and sis302LV.
PPS: Sorry for all mistakes I made !!!

-- 
Il reggiseno e' uno strumento democratico perche' separa la destra dalla
sinistra, solleva le masse e attira i popoli.
