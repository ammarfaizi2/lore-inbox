Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264861AbSKALbU>; Fri, 1 Nov 2002 06:31:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264984AbSKALbU>; Fri, 1 Nov 2002 06:31:20 -0500
Received: from ulima.unil.ch ([130.223.144.143]:13446 "HELO ulima.unil.ch")
	by vger.kernel.org with SMTP id <S264861AbSKALbT>;
	Fri, 1 Nov 2002 06:31:19 -0500
Date: Fri, 1 Nov 2002 12:37:42 +0100
From: Gregoire Favre <greg@ulima.unil.ch>
To: Thomas Molina <tmolina@cox.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Logitech wheel and 2.5? (PS/2)
Message-ID: <20021101113742.GB8050@ulima.unil.ch>
References: <20021031223401.GB25356@ulima.unil.ch> <Pine.LNX.4.44.0211010438550.22868-100000@dad.molina>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Pine.LNX.4.44.0211010438550.22868-100000@dad.molina>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 01, 2002 at 04:41:30AM -0600, Thomas Molina wrote:

> How is your mouse configured/detected?  If your boot up sequence specifies 
> to gpm that you have a Logitech Wheel Mouse try redoing it for an MS 
> Intellimouse.  I have several Logitech mice which work as imps/2 and don't 
> when configured as a logitech.

Well in console mode:
MOUSETYPE=ps2
XMOUSETYPE=MouseManPlusPS/2
FULLNAME="PS/2|Logitech MouseMan+"
XEMU3=no
WHEEL=yes
device=psaux

And in Xfree4:
    Identifier "Mouse1"
    Driver      "mouse"
    Option "Protocol"    "MouseManPlusPS/2"
    Option "Device"      "/dev/mouse"
    Option "ZAxisMapping" "4 5"

Under 2.4 every thing works great so, but under 2.5 not, from dmesg:
...
matroxfb_crtc2: secondary head of fb0 was registered as fb1
register interface 'mouse' with class 'input
mice: PS/2 mouse device common for all mice
input: PC Speaker
input: PS2++ Logitech Wheel Mouse on isa0060/serio1
serio: i8042 AUX port at 0x60,0x64 irq 12
input: AT Set 2 keyboard on isa0060/serio0
serio: i8042 KBD port at 0x60,0x64 irq 1
ISDN subsystem initialized
PPP BSD Compression module registered
psmouse.c: Received PS2++ packet #0, but don't know how to handle.
HiSax: Linux Driver for passive ISDN cards
...
Advanced Linux Sound Architecture Driver Version 0.9.0rc5 (Tue Oct 29 09:19:27 2002 UTC).
psmouse.c: Received PS2++ packet #0, but don't know how to handle.
request_module[snd-card-0]: not ready
...
request_module[snd-card-6]: not ready
psmouse.c: Received PS2++ packet #0, but don't know how to handle.
request_module[snd-card-7]: not ready
...

In console (with gpm, it seems to works, but I don't use the wheel)
But under X: no wheel any more... 

Thank you very much,

	Grégoire
________________________________________________________________
http://ulima.unil.ch/greg ICQ:16624071 mailto:greg@ulima.unil.ch
