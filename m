Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265334AbUBAP0C (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 1 Feb 2004 10:26:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265326AbUBAP0B
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 1 Feb 2004 10:26:01 -0500
Received: from quechua.inka.de ([193.197.184.2]:52158 "EHLO mail.inka.de")
	by vger.kernel.org with ESMTP id S265334AbUBAPZs (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 1 Feb 2004 10:25:48 -0500
From: Andreas Jellinghaus <aj@dungeon.inka.de>
Subject: Re: 2.6 input drivers FAQ
Date: Sun, 01 Feb 2004 16:25:41 +0100
User-Agent: Pan/0.14.2 (This is not a psychotic episode. It's a cleansing moment of clarity. (Debian GNU/Linux))
Message-Id: <pan.2004.02.01.15.25.39.951190@dungeon.inka.de>
References: <20040201100644.GA2201@ucw.cz>
To: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

And what about dell latitude laptops (synaptics touchpad - works fine -
plus that mouse stick - no reaction at all?

Usualy I'm fine with the touchpad, but some people prefer to use
the stick or both. Any idea?

devices: (plus pcspeaker and keyboard):
I: Bus=0011 Vendor=0002 Product=0007 Version=0000
N: Name="SynPS/2 Synaptics TouchPad"
P: Phys=isa0060/serio1/input0
H: Handlers=mouse0 event1 
B: EV=b 
B: KEY=6420 0 670000 0 0 0 0 0 0 0 0 
B: ABS=11000003 

I: Bus=0011 Vendor=0002 Product=0001 Version=0000
N: Name="PS/2 Generic Mouse"
P: Phys=synaptics-pt/serio0/input0
H: Handlers=mouse1 event2 
B: EV=7 
B: KEY=70000 0 0 0 0 0 0 0 0 
B: REL=3 

XF86Config:
Section "InputDevice"
        Identifier  "Mouse0"
        Driver      "mouse"
        Option      "Protocol" "ExplorerPS/2"
        Option      "Device" "/dev/input/mouse0"
        Option      "Emulate3Buttons" "on"
EndSection

config:
CONFIG_INPUT=y
CONFIG_INPUT_MOUSEDEV=y
CONFIG_INPUT_MOUSEDEV_PSAUX=y
CONFIG_INPUT_MOUSEDEV_SCREEN_X=1024
CONFIG_INPUT_MOUSEDEV_SCREEN_Y=768
CONFIG_INPUT_EVDEV=y
CONFIG_SOUND_GAMEPORT=y
CONFIG_SERIO=y
CONFIG_SERIO_I8042=y
CONFIG_SERIO_SERPORT=y
CONFIG_INPUT_KEYBOARD=y
CONFIG_KEYBOARD_ATKBD=y
CONFIG_INPUT_MOUSE=y
CONFIG_MOUSE_PS2=y
CONFIG_INPUT_MISC=y
CONFIG_INPUT_PCSPKR=y
CONFIG_INPUT_UINPUT=y

Andreas

