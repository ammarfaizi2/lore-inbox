Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S133041AbRDRGsR>; Wed, 18 Apr 2001 02:48:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S133040AbRDRGsI>; Wed, 18 Apr 2001 02:48:08 -0400
Received: from olsinka.site.cas.cz ([147.231.11.16]:1921 "EHLO
	twilight.suse.cz") by vger.kernel.org with ESMTP id <S133041AbRDRGr5>;
	Wed, 18 Apr 2001 02:47:57 -0400
Date: Wed, 18 Apr 2001 08:46:52 +0200
From: Vojtech Pavlik <vojtech@suse.cz>
To: monkeyiq@dingoblue.net.au
Cc: linux-kernel@vger.kernel.org
Subject: Re: idebus=xx on a ISA only 486
Message-ID: <20010418084652.A369@suse.cz>
In-Reply-To: <3ADAE8A4.87DFBF92@dingoblue.net.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <3ADAE8A4.87DFBF92@dingoblue.net.au>; from monkeyiq@dingoblue.net.au on Mon, Apr 16, 2001 at 10:42:12PM +1000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 16, 2001 at 10:42:12PM +1000, monkeyiq@dingoblue.net.au wrote:
> Hi,
>     This may be harmless but I noticed a warning msg when I went to
> 2.4.3 on a ISA only 486 mobo.
> 
> Feb 18 18:01:41 speedy kernel: ide: Assuming 50MHz system bus speed for
> PIO modes; override with idebus=xx
> 
> My first thought was to drop idebus to 8Mhz (I think this is the
> ISA speed ?),
> but using that
> Feb 18 18:01:41 speedy kernel: Kernel command line: auto BOOT_IMAGE=243
> ro root=301 BOOT_FILE=/boot/vmlinuz-2.4.3 idebus=8
> Feb 18 18:01:41 speedy kernel: ide_setup: idebus=8 -- BAD BUS SPEED!
> Expected value from 20 to 66
> 
> and then a quick grep/poke in the src gave this
> 
> ./drivers/ide/ide.c
> Version 5.50         allow values as small as 20 for idebus=
> 
> and at line 350 it seems that its pci or nothing for the bus speed.
> 
> the only deterministic problem (so far that I can directly attribute to
> that kernel) with the
> 2.4.3 booted kernel is that ssh2 locks up for random amounts of time at
> randomish intervals.
> 
> I can't seem to dig up other info on this problem, I am sorry if this is
> the wrong place
> to ask. If there are better places to be looking for this data I am
> happy to RTFM there.
> 
> Now trying 2.4.3-ac6 to see what happens there.

idebus= isn't used in case there is no VL-BUS or PCI bus in your system.

-- 
Vojtech Pavlik
SuSE Labs
