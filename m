Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262789AbTAJEqP>; Thu, 9 Jan 2003 23:46:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262796AbTAJEqP>; Thu, 9 Jan 2003 23:46:15 -0500
Received: from main.gmane.org ([80.91.224.249]:60072 "EHLO main.gmane.org")
	by vger.kernel.org with ESMTP id <S262789AbTAJEqL>;
	Thu, 9 Jan 2003 23:46:11 -0500
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
Path: not-for-mail
From: "Andres Salomon" <dilinger@voxel.net>
Subject: Re: 2.5.x inspiron touchpad breakage
Date: Thu, 09 Jan 2003 23:54:55 -0500
Message-ID: <pan.2003.01.10.04.54.54.329172@voxel.net>
References: <pan.2003.01.09.08.27.53.688647@voxel.net> <39260000.1042119837@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-Complaints-To: usenet@main.gmane.org
User-Agent: Pan/0.13.3 (That cat's something I can't explain)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The appropriate config section from my kernel:


#
# Input device support
#
CONFIG_INPUT=y

#
# Userland interfaces
#
CONFIG_INPUT_MOUSEDEV=y
CONFIG_INPUT_MOUSEDEV_PSAUX=y
CONFIG_INPUT_MOUSEDEV_SCREEN_X=1024

#
# Input Device Drivers
#
CONFIG_INPUT_KEYBOARD=y
CONFIG_KEYBOARD_ATKBD=y
# CONFIG_KEYBOARD_SUNKBD is not set
# CONFIG_KEYBOARD_XTKBD is not set
# CONFIG_KEYBOARD_NEWTON is not set
CONFIG_INPUT_MOUSE=y
CONFIG_MOUSE_PS2=y
CONFIG_MOUSE_SERIAL=m
# CONFIG_INPUT_JOYSTICK is not set
# CONFIG_INPUT_TOUCHSCREEN is not set
# CONFIG_INPUT_MISC is not set

CONFIG_INPUT_MOUSEDEV_SCREEN_Y=768
# CONFIG_INPUT_JOYDEV is not set
# CONFIG_INPUT_TSDEV is not set
# CONFIG_INPUT_EVDEV is not set
# CONFIG_INPUT_EVBUG is not set

#
# Input I/O drivers
#
# CONFIG_GAMEPORT is not set
CONFIG_SOUND_GAMEPORT=y
CONFIG_SERIO=y
CONFIG_SERIO_I8042=y
CONFIG_SERIO_SERPORT=y
CONFIG_SERIO_CT82C710=m



The inspiron uses an i8042 for the keyboard and the external ps/2
mouse/keyboard port.  I'm not sure what it uses for the touchpad.


On Fri, 10 Jan 2003 02:43:57 +1300, Andrew McGregor wrote:

> Works for me on an Inspiron 8000.  The trackpoint does not, which is a 
> known bug.  Of course, the 3800 might be different...
> 
> Have you been bitten by the input layer configuration issue?  Here's what I 
> have:
> 
> #
> # Input device support
> #
> CONFIG_INPUT=y
> 
> #
> # Userland interfaces
> #
> CONFIG_INPUT_MOUSEDEV=y
> CONFIG_INPUT_MOUSEDEV_PSAUX=y
> 
> #
> # Input Device Drivers
> #
> CONFIG_INPUT_KEYBOARD=y
> CONFIG_KEYBOARD_ATKBD=y
> CONFIG_INPUT_MOUSE=y
> CONFIG_MOUSE_PS2=y
> 
> Andrew
> 
> --On Thursday, January 09, 2003 03:27:54 -0500 Andres Salomon 
> <dilinger@voxel.net> wrote:
> 
>> 2.5.54 and 2.5.55 do not appear to initialize the touchpad on my Dell
>> Inspiron 3800.  No mouse device is detected until I plug a normal ps/2
>> mouse into the laptop.  I assume this is some weird bios thing.  2.4.x
>> works fine with it.  Does anyone have suggestions about where to look for
>> any changed in the 2.5 series that might've broken it, or any patches that
>> fix it?
>>
>> -
>> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>> Please read the FAQ at  http://www.tux.org/lkml/
>>
>>


