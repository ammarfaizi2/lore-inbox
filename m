Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262026AbUDJNxb (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 10 Apr 2004 09:53:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262029AbUDJNxb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 10 Apr 2004 09:53:31 -0400
Received: from swszl.szkp.uni-miskolc.hu ([193.6.2.24]:55183 "EHLO
	swszl.szkp.uni-miskolc.hu") by vger.kernel.org with ESMTP
	id S262026AbUDJNx2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 10 Apr 2004 09:53:28 -0400
Date: Sat, 10 Apr 2004 15:53:27 +0200
From: Vitez Gabor <gabor@swszl.szkp.uni-miskolc.hu>
To: linux-kernel@vger.kernel.org
Subject: 2.6.5 : problem with MS Intellimouse Explorer buttons when using X
Message-ID: <20040410135327.GA12573@swszl.szkp.uni-miskolc.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I recently ugraded from 2.4.23 to 2.6.5. Everything works fine, except for
my mouse: when I press the buttons on the left side of the mouse, the system
generates button press/release events for the proper buttons and for the
buttons on the top of the mouse. The mouse worked well with 2.4.23.

I use a mixed Debian woody/sarge system.

Example output from xev (I pressed and released one of the buttons on the
side):

ButtonPress event, serial 23, synthetic NO, window 0x1800001,
    root 0x46, subw 0x0, time 3567154224, (56,106), root:(793,193),
    state 0x0, button 5, same_screen YES

ButtonPress event, serial 23, synthetic NO, window 0x1800001,
    root 0x46, subw 0x0, time 3567154224, (56,106), root:(793,193),
    state 0x0, button 3, same_screen YES

ButtonRelease event, serial 23, synthetic NO, window 0x1800001,
    root 0x46, subw 0x0, time 3567154393, (56,106), root:(793,193),
    state 0x400, button 5, same_screen YES

ButtonRelease event, serial 23, synthetic NO, window 0x1800001,
    root 0x46, subw 0x0, time 3567154393, (56,106), root:(793,193),
    state 0x400, button 3, same_screen YES


The events for button 3 should not be there..

Mouse related lines from dmesg:

mice: PS/2 mouse device common for all mice
input: ImExPS/2 Generic Explorer Mouse on isa0060/serio1


X11 version, configuration:

4.2.1-3

Mouse configuration:

Section "InputDevice"
        Identifier      "Configured Mouse"
        Driver          "mouse"
        Option          "CorePointer"
        Option          "Device"                "/dev/psaux"
        Option          "Protocol"              "ExplorerPS/2"
#       Option          "Protocol"              "ImPS/2"
        Option          "SampleRate"            "150"
        Option          "Resolution"            "200"
        Option          "Buttons"               "7"
        Option          "ZAxisMapping"          "6 7"
EndSection


Various stuff I tried to make the mouse work properly:

Plugging it in the USB port of my machine: no change.
Loading the psmouse module with the "proto=exps" parameter: no change.
Changing the mouse protocol to ImPS/2: no change/got worse.

Any help would be appreciated..


	Gabor
