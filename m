Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271515AbRHZU0P>; Sun, 26 Aug 2001 16:26:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271560AbRHZU0F>; Sun, 26 Aug 2001 16:26:05 -0400
Received: from paloma17.e0k.nbg-hannover.de ([62.159.219.17]:38056 "HELO
	paloma17.e0k.nbg-hannover.de") by vger.kernel.org with SMTP
	id <S271515AbRHZUZy>; Sun, 26 Aug 2001 16:25:54 -0400
Content-Type: text/plain; charset=US-ASCII
From: Dieter =?iso-8859-1?q?N=FCtzel?= <Dieter.Nuetzel@hamburg.de>
Organization: DN
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: VCool - cool your Athlon/Duron during idle
Date: Sun, 26 Aug 2001 22:25:56 +0200
X-Mailer: KMail [version 1.3]
Cc: Linux Kernel List <linux-kernel@vger.kernel.org>,
        Marc Lehmann <pcg@goof.com>
In-Reply-To: <E15b5W8-0002cC-00@the-village.bc.nu>
In-Reply-To: <E15b5W8-0002cC-00@the-village.bc.nu>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <20010826202554Z271515-760+6207@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Am Sonntag, 26. August 2001 21:24 schrieb Alan Cox:
> > Have you read something about this Athlon/Duron cooling problem?
> > Can this code included into your (and/or the official) tree?
> > Maybe it is needed for the AMD 750/760/760MP/760MPX, too?
>
> Well my German isnt that good, but it appears to be just another variant
> on CPU idling. We do hlt or APM already, and APM should be doing other
> work if appropriate.

OK, sorry. There is an English version, already...;-)
http://www.naggelgames.de/vcool/

The site deals with the Athlon/Duron and chipset (VIA) short comings and 
current bugs (power saving related). I think it is one of the best (put all 
info together and provide a solution) for the AMD Athlon/Duron hardware 
throttling.

[-]
VCool 1.6

This little utility will cool your Athlon/Duron processor on Via KT133 or 
KX133(A) (VT8363 or VT8371/VT82C686x) chipsets during idle


Features

Controls the "Northbridge Bus Disconnect Bit" to lower your CPUs power level 
during idle

An idle loop that puts your CPU into STPGNT state if your OS won't

Displays the current CPU temperature in your system tray (optional)

Optional hardware throttling of the CPU when it gets too hot (50%, 10%, 
shutdown)

Lightweight: 30K


Requirements

Chipset with a VT8371 or VT8363 Northbridge and a VT82C686x Southbridge (VIA 
KT133x or KX133) - limited support for AMD 761

A Win32 OS (Windows 98 or better - no that does not include LINUX *g*)

For Windows 2000 and NT you'll need the "GiveIO" driver 


How it works

The Athlon (or Duron) enters a lower power state only when its system bus is 
disconnected. However the (VIA-)Northbridge will only disconnect the bus if 
its "Bus Disconnect Enable" bit is set and the CPU is in STPGNT state.
 VCool allows you to enable this bit so your CPU can relax when there's 
nothing to do.

Setting this bit might not be enough on some systems as the idle loop 
provided with the OS will not put the CPU into the STPGNT state recognized by 
the Northbridge.
 For those cases VCool includes an internal idle loop that forces the CPU 
into the STPGNT mode required by the Northbridge to initiate a bus 
disconnect. 

If you want to read more about how this works follow this link.

Note that the system monitor will report 100% utilization when the idle loop 
is active.
 That's because it takes away all idle time from the OS idle loop and the OS 
calculates the utilization like:
 Utilization = 100 % - %age of time spent in OS idle loop.

Also note that disconnecting the system bus to save power might interfere 
with "realtime" applications like TV or sound capturing - causing dropouts or 
other oddities.


What's new in VCool 1.6

The temperature readout on 686 chips was a bit low at high temperatures - now 
VCool uses a new formula based on inofficial data. The "TempDiv" and 
"TempSub" registry keys have been removed.

Added and Apply button in the options dialog

The status of the SBMus is now restored after readout to solve problems with 
ASUS probe. There's also a busy wait option to prevent asus probe from 
interfering with VCools reading - however so far this seems to work only on 
W9x and ME as the preemptive scheduling of W2K and NT requires a driver to 
achieve this - maybe in a later version *g*.

The status of the cool bit and the idle loop are now indicated by small dots 
on the lower left and right of the icon.

<shift>+LClick (<crtl>+LClick) on the icon toggles the Cool bit (idle loop)

The idle loop is turned off now when the temperature drops below T50 (if it 
was off before T50 was exceeded).

There's now a custom shutdown option that will execute a user definable 
program when Tshutdown is exceeded.
[-]

Source is available (even for Linux).

-Dieter

