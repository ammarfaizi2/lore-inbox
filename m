Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314707AbSD2A2Q>; Sun, 28 Apr 2002 20:28:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314708AbSD2A2P>; Sun, 28 Apr 2002 20:28:15 -0400
Received: from duteinh.et.tudelft.nl ([130.161.42.1]:34314 "EHLO
	duteinh.et.tudelft.nl") by vger.kernel.org with ESMTP
	id <S314707AbSD2A2O>; Sun, 28 Apr 2002 20:28:14 -0400
Date: Mon, 29 Apr 2002 02:28:11 +0200
From: Erik Mouw <J.A.K.Mouw@its.tudelft.nl>
To: Stephan Maciej <stephan@maciej.muc.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Sony Vaio Laptop problems
Message-ID: <20020429002811.GB3108@arthur.ubicom.tudelft.nl>
In-Reply-To: <200204261728.39745.stephan@maciej.muc.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
Organization: Eric Conspiracy Secret Labs
X-Eric-Conspiracy: There is no conspiracy!
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 26, 2002 at 05:28:39PM +0200, Stephan Maciej wrote:
> I do have two problems with running Linux on my Sony Vaio PCG-FX501 Laptop.

I have a FX505, which basically is a FX501 with Athlon 1.2GHz and some
other goodies.

> 1.) When I do a reboot, the bootup logo (a nice animation from Sony :-) 
> displays, and the HD light turns on and stays on forever. Approximately 30 
> seconds later, the logo goes away, and I do see the Phoenix BIOS' startup 
> screen, saying
> 
> ERROR
> 0211: Keyboard Error
> 
> I do have the option to use <F2> to enter Setup, but due to some strange 0211 
> keyboard error it just won't work. The only proper way for restarting my 
> machine is to power it off and turn it on again.
> 
> What can I do?

1) Update the BIOS, my laptop shipped with an old version and a BIOS
   update fixed some keyboard related problems. (you need to boot into
   windows for this)
2) Apply the latest ACPI patch.

> 2.) The laptop seems to put itself to sleep when I don't do anything for a 
> longer period of time. The display becomes black (the backlight is still on, 
> though) and I can't do anything except powering off and on again to make the 
> machine work again. No messages about anything interesting are in my syslog 
> files after this has happened. The problem persists both with ACPI and APM.
> 
> The only thing that fixes this problem is loading or installing the sonypi 
> driver into the kernel. It doesn't function as expected, but it solves at 
> least *this* problem. (As documented in the driver, sonypi should be able to 
> set/get the backlight intensity of the display, but that doesn't work. There 
> are even more features that it has but that are non-operational on my 
> system.)

My FX505 doesn't need the sonypi driver. With APM I can suspend the
computer but the CPU fan won't turn off; with ACPI the CPU fan turns
off, but I can't suspend the computer. Anyway, the latest ACPI patch
makes it a lot more quiet.

> This is all okay, especially as I can now leave my laptop alone for even more 
> than 10 minutes or so without having the need to turn it off and on again 
> afterwards. OTOH, with sonypi my via82cxxx_audio driver won't work. 
> 
> When compiled into kernel, I see the follwing message:

Use the ALSA-0.9 series driver instead of the kernel driver.

> So, just for completeness, here's my system configuration:
> 
> Mobile AMD Duron Processor, 1GHz
> 256MB RAM
> IDE hard disk and CD/DVD ROM

You forgot to tell which kernel version you are currently using.
Anyway, linux-2.4.19-pre5 + acpi-20020329-2.4.18 works for me.


Erik

-- 
J.A.K. (Erik) Mouw, Information and Communication Theory Group, Faculty
of Information Technology and Systems, Delft University of Technology,
PO BOX 5031, 2600 GA Delft, The Netherlands  Phone: +31-15-2783635
Fax: +31-15-2781843  Email: J.A.K.Mouw@its.tudelft.nl
WWW: http://www-ict.its.tudelft.nl/~erik/
