Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316623AbSGCFsN>; Wed, 3 Jul 2002 01:48:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316916AbSGCFsM>; Wed, 3 Jul 2002 01:48:12 -0400
Received: from paloma16.e0k.nbg-hannover.de ([62.181.130.16]:20695 "HELO
	paloma16.e0k.nbg-hannover.de") by vger.kernel.org with SMTP
	id <S316623AbSGCFsL>; Wed, 3 Jul 2002 01:48:11 -0400
Content-Type: text/plain;
  charset="iso-8859-15"
From: Dieter =?iso-8859-15?q?N=FCtzel?= <Dieter.Nuetzel@hamburg.de>
Organization: DN
To: Tony Lindgren <tony@atomide.com>
Subject: Re: amd-smp-idle module avail for testing max 90 W power savings
Date: Wed, 3 Jul 2002 07:50:50 +0200
User-Agent: KMail/1.4.1
Cc: Sebastian Droege <sebastian.droege@gmx.de>, nofftz@castor.uni-trier.de,
       Linux Kernel List <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Message-Id: <200207030750.50789.Dieter.Nuetzel@hamburg.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2 Jul 2002 19:41, Tony Lindgren wrote:
> * Sebastian Droege <sebastian.droege@gmx.de> [020702 12:29]:
> > On Tue, 2 Jul 2002 12:14:54 -0700
> > Tony Lindgren <tony@atomide.com> wrote:
> >
> > > Amd-smp-idle enables the power savings mode like VCool and LVCool, but
> > > amd-smp-idle uses the Linux PCI features, and supports currently SMP
> > > only. So far I've squeezed out maximum 90 Watt power savings out of my
> > > system :)
> > >
> > > http://www.muru.com/linux/amd-smp-idle/
> >
> > Is it possible to do something similar for AMD-751

Hardly, there is NO chipset dokumentation for the AMD 750 (760) available.

> > or VIA-686a (or other UP Athlon chipsets)?

See below.

> Yes, you could use LVCool program, or merge the LVCool functionality to
> amd-smp-idle. I added place holders for enabling other chips.
>
> Just add functions for enabling north and southbridge, and then fill in 
> the idle function. I kind of thought of modifying LVCool, but it was not 
> using the Linux PCI API, and was not really suitable for SMP systems.
>
> LVCool is at:
>
> http://mpet.freeservers.com/LVCool.html

Have a look here, too:

http://cip.uni-trier.de/nofftz/linux/

I'll give your code a shot on my brand new
dual Athlon MP 1900+ (MP unlocked XPs, 4th bridge of L5 is closed)
MSI K7D Master-L (MS-6501 v1.0) AMD 760MPX
1 GB DDR266-SDRAM CL2

But it doesn't go hot...;-)

/home/nuetzel> sensors
eeprom-i2c-0-50
Adapter: SMBus AMD768 adapter at 06e0
Algorithm: Non-I2C SMBus adapter

eeprom-i2c-0-51
Adapter: SMBus AMD768 adapter at 06e0
Algorithm: Non-I2C SMBus adapter

w83627hf-isa-0290
Adapter: ISA adapter
Algorithm: ISA algorithm
VCore 1:   +1.72 V  (min =  +4.08 V, max =  +4.08 V)
VCore 2:   +2.46 V  (min =  +4.08 V, max =  +4.08 V)
+3.3V:     +3.36 V  (min =  +3.13 V, max =  +3.45 V)
+5V:       +4.94 V  (min =  +4.72 V, max =  +5.24 V)
+12V:     +12.16 V  (min = +10.79 V, max = +13.19 V)
-12V:     -12.65 V  (min = -13.21 V, max = -10.90 V)
-5V:       -5.10 V  (min =  -5.26 V, max =  -4.76 V)
V5SB:      +5.39 V  (min =  +4.72 V, max =  +5.24 V)
VBat:      +3.42 V  (min =  +2.40 V, max =  +3.60 V)
U160:        0 RPM  (min = 3000 RPM, div = 2)
CPU 0:    4470 RPM  (min = 3000 RPM, div = 2)
CPU 1:    4299 RPM  (min = 3000 RPM, div = 2)
System:   +30.0°C   (limit = +60°C, hysteresis = +50°C) sensor = thermistor
CPU 1:    +34.0°C   (limit = +60°C, hysteresis = +50°C) sensor = 3904 
transistor
CPU 0:    +36.5°C   (limit = +60°C, hysteresis = +50°C) sensor = 3904 
transistor
vid:      +18.50 V
alarms:   Chassis intrusion detection
beep_enable:
          Sound alarm disabled
-- 
Dieter Nützel
Graduate Student, Computer Science

University of Hamburg
Department of Computer Science
@home: Dieter.Nuetzel@hamburg.de

