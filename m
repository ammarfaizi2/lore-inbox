Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1945999AbWBOQAi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1945999AbWBOQAi (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Feb 2006 11:00:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1946002AbWBOQAi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Feb 2006 11:00:38 -0500
Received: from solarneutrino.net ([66.199.224.43]:16905 "EHLO
	tau.solarneutrino.net") by vger.kernel.org with ESMTP
	id S1945999AbWBOQAi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Feb 2006 11:00:38 -0500
Date: Wed, 15 Feb 2006 11:00:36 -0500
To: Jean Delvare <khali@linux-fr.org>
Cc: linux-kernel@vger.kernel.org, Erik Mouw <erik@harddisk-recovery.com>,
       Nick Warne <nick@linicks.net>
Subject: Re: Random reboots
Message-ID: <20060215160036.GB17864@tau.solarneutrino.net>
References: <20060215142809.GA17842@tau.solarneutrino.net> <6cBigqfP.1140018099.7722170.khali@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <6cBigqfP.1140018099.7722170.khali@localhost>
User-Agent: Mutt/1.5.9i
From: Ryan Richter <ryan@tau.solarneutrino.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 15, 2006 at 04:41:39PM +0100, Jean Delvare wrote:
> 
> Hi Ryan,
> 
> On 2006-02-15, Ryan Richter wrote:
> > The sensors report a bunch of obvious nonsesne as always...  I keep them
> > configured in with the hope that one day they'll report useful
> > information, but that day hasn't come yet.  I just checked, and all the
> > fans are still fine.  It's in a huge case with lots of fans and it's
> > hardly warmer than room temp.  The opteron 240s don't put out much heat.
> 
> The sensors might just need some board-specific configuration. May I ask
> which motherboard this is?
> 
> I may help you (in private) setup your sensors. If you're interested,
> send the output of "sensors-detect" and "sensors" to me and I'll
> see what can be done to improve the reported values.

It's a Tyan S2880, and I'm using their sensors.conf:

ftp://ftp.tyan.com/software/lms/lms_s2880.tgz

Here's what sensors reports:

w83627hf-isa-0290
Adapter: ISA adapter
VCore 1:   +1.54 V  (min =  +1.47 V, max =  +1.62 V)       ALARM  
VCore 2:   +1.54 V  (min =  +1.47 V, max =  +1.62 V)       ALARM  
+3.3V:     +3.33 V  (min =  +3.14 V, max =  +3.46 V)              
+5V:       +4.97 V  (min =  +4.73 V, max =  +5.24 V)              
+12V:      +4.56 V  (min = +10.82 V, max = +13.19 V)              
-12V:      -2.25 V  (min = -13.18 V, max = -10.88 V)              
-5V:       -3.94 V  (min =  -5.25 V, max =  -4.75 V)              
V5SB:      +5.51 V  (min =  +4.73 V, max =  +5.24 V)              
VBat:      +1.28 V  (min =  +2.40 V, max =  +3.60 V)              
fan1:     4354 RPM  (min =   -1 RPM, div = 2)                     
fan2:     3479 RPM  (min = 5273 RPM, div = 2)                     
fan3:        0 RPM  (min = 30681 RPM, div = 2)                     
temp1:       +77°C  (high =  -128°C, hyst =  -128°C)   sensor = thermistor           
temp2:     +77.5°C  (high =   +80°C, hyst =   +75°C)   sensor = thermistor           
temp3:     +77.5°C  (high =   +80°C, hyst =   +75°C)   sensor = thermistor           
vid:      +1.550 V  (VRM Version 2.4)

The temps and +/-12V readings are obviously wrong, and always have been
AFAIR.  I've run the machine with 6 more 10krpm old full-height drives
than it currently has.  I checked the max 5V and 12V current draw of the
drives and specced the power supply carefully when we bought it a couple
years ago, and it has lots of headroom on both of those rails.

> Two more random thoughts:
> 
> Any reason why you run 2.6.15 rather than 2.6.15.4? That's where I would
> start if I was suspecting a kernel bug.
> 
> Did you already update the BIOS to the latest version available? There
> are a few kernel complaints in your dmesg which might be solved by a
> newer BIOS (and/or parameter changes in the BIOS setup).

I'll be booting 2.6.15.4 this weekend.  The BIOS is indeed old, and I
see there's a newer one that came out a year ago.  It'll be a while
before I can try it, I need to scare up a keyboard, video card, and
monitor, not to mention a DOS disk.  You can tell why I haven't flashed
the BIOS in years...

Still, I don't see why the new kernel shouldn't be stable if 2.6.11.3
was.

Thanks,
-ryan
