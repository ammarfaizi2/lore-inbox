Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265506AbUBAVyJ (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 1 Feb 2004 16:54:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265507AbUBAVyJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 1 Feb 2004 16:54:09 -0500
Received: from twilight.ucw.cz ([81.30.235.3]:11648 "EHLO midnight.ucw.cz")
	by vger.kernel.org with ESMTP id S265506AbUBAVxm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 1 Feb 2004 16:53:42 -0500
Date: Sun, 1 Feb 2004 22:54:00 +0100
From: Vojtech Pavlik <vojtech@suse.cz>
To: Andreas Jellinghaus <aj@dungeon.inka.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6 input drivers FAQ
Message-ID: <20040201215400.GA16155@ucw.cz>
References: <20040201100644.GA2201@ucw.cz> <pan.2004.02.01.15.25.39.951190@dungeon.inka.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <pan.2004.02.01.15.25.39.951190@dungeon.inka.de>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Feb 01, 2004 at 04:25:41PM +0100, Andreas Jellinghaus wrote:
> And what about dell latitude laptops (synaptics touchpad - works fine -
> plus that mouse stick - no reaction at all?
> 
> Usualy I'm fine with the touchpad, but some people prefer to use
> the stick or both. Any idea?
> 
> devices: (plus pcspeaker and keyboard):
> I: Bus=0011 Vendor=0002 Product=0007 Version=0000
> N: Name="SynPS/2 Synaptics TouchPad"
> P: Phys=isa0060/serio1/input0
> H: Handlers=mouse0 event1 
> B: EV=b 
> B: KEY=6420 0 670000 0 0 0 0 0 0 0 0 
> B: ABS=11000003 
> 
> I: Bus=0011 Vendor=0002 Product=0001 Version=0000
> N: Name="PS/2 Generic Mouse"
> P: Phys=synaptics-pt/serio0/input0
> H: Handlers=mouse1 event2 
> B: EV=7 
> B: KEY=70000 0 0 0 0 0 0 0 0 
> B: REL=3 

This means both the touchpad and the touchpoint were found correctly.
Can you supply your 'dmesg'? Best contact Dmitry Torokhov about this -
he's the Synaptics expert.

> 
> XF86Config:
> Section "InputDevice"
>         Identifier  "Mouse0"
>         Driver      "mouse"
>         Option      "Protocol" "ExplorerPS/2"
>         Option      "Device" "/dev/input/mouse0"
>         Option      "Emulate3Buttons" "on"
> EndSection
> 
> config:
> CONFIG_INPUT=y
> CONFIG_INPUT_MOUSEDEV=y
> CONFIG_INPUT_MOUSEDEV_PSAUX=y
> CONFIG_INPUT_MOUSEDEV_SCREEN_X=1024
> CONFIG_INPUT_MOUSEDEV_SCREEN_Y=768
> CONFIG_INPUT_EVDEV=y
> CONFIG_SOUND_GAMEPORT=y
> CONFIG_SERIO=y
> CONFIG_SERIO_I8042=y
> CONFIG_SERIO_SERPORT=y
> CONFIG_INPUT_KEYBOARD=y
> CONFIG_KEYBOARD_ATKBD=y
> CONFIG_INPUT_MOUSE=y
> CONFIG_MOUSE_PS2=y
> CONFIG_INPUT_MISC=y
> CONFIG_INPUT_PCSPKR=y
> CONFIG_INPUT_UINPUT=y
> 
> Andreas
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 

-- 
Vojtech Pavlik
SuSE Labs, SuSE CR
