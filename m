Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964910AbVLFB4j@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964910AbVLFB4j (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 5 Dec 2005 20:56:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964912AbVLFB4j
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 Dec 2005 20:56:39 -0500
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:10973 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S964910AbVLFB4i (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 Dec 2005 20:56:38 -0500
Date: Tue, 6 Dec 2005 02:56:16 +0100
From: Pavel Machek <pavel@suse.cz>
To: Andy Isaacson <adi@hexapodia.org>
Cc: Nigel Cunningham <ncunningham@cyclades.com>,
       "Rafael J. Wysocki" <rjw@sisk.pl>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: IDE performance on notebooks [was Re: swsusp performance problems in 2.6.15-rc3-mm1]
Message-ID: <20051206015616.GK1770@elf.ucw.cz>
References: <20051205081935.GI22168@hexapodia.org> <20051205121728.GF5509@elf.ucw.cz> <1133791084.3872.53.camel@laptop.cunninghams> <200512052328.01999.rjw@sisk.pl> <1133831242.6360.15.camel@localhost> <20051206013759.GI1770@elf.ucw.cz> <20051206014720.GN22168@hexapodia.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051206014720.GN22168@hexapodia.org>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > Andy reported 20MB/sec on hdparm. I do not think it is possible to
> > write faster than that. And that seems about ok for notebooks, X32
> > (pretty new) has:
> > 
> > root@amd:~# hdparm -t /dev/hda
> 
> You named your X32 "amd"?  How ... confusing ... (assuming it, like all
> other Thinkpad X series I know, has a Pentium M.)

Historical reasons, sorry. I had athlon64 machine as my main
workstation, then just cp -a'ed it to new system. It is also called
Arima when connected to network, while it is IBM system...

> > /dev/hda:
> >  Timing buffered disk reads:  108 MB in  3.01 seconds =  35.85 MB/sec
> 
> That's quite a bit better than mine, and I am pretty sure I am the same
> vintage or newer (purchased this summer), but I'm getting barely half
> that speed:
>  Timing buffered disk reads:   58 MB in  3.10 seconds =  18.70
> MB/sec

Below are data from my machine... but that should be moved to
linux-ide or something. This thinkpad is from this summer, too, BTW.

								Pavel

root@amd:~# hdparm /dev/hda

/dev/hda:
 multcount    =  0 (off)
 IO_support   =  1 (32-bit)
 unmaskirq    =  0 (off)
 using_dma    =  1 (on)
 keepsettings =  0 (off)
 readonly     =  0 (off)
 readahead    = 256 (on)
 geometry     = 65535/16/63, sectors = 78140160, start = 0
root@amd:~# hdparm -i /dev/hda

/dev/hda:

 Model=HTS541040G9AT00, FwRev=MB2IA5BJ, SerialNo=MPB2L0X2GLMG5M
 Config={ HardSect NotMFM HdSw>15uSec Fixed DTR>10Mbs }
 RawCHS=16383/16/63, TrkSize=0, SectSize=0, ECCbytes=4
 BuffType=DualPortCache, BuffSize=7539kB, MaxMultSect=16, MultSect=off
 CurCHS=16383/16/63, CurSects=16514064, LBA=yes, LBAsects=78140160
 IORDY=on/off, tPIO={min:240,w/IORDY:120}, tDMA={min:120,rec:120}
 PIO modes:  pio0 pio1 pio2 pio3 pio4
 DMA modes:  mdma0 mdma1 mdma2
 UDMA modes: udma0 udma1 udma2 udma3 udma4 *udma5
 AdvancedPM=yes: mode=0x80 (128) WriteCache=enabled
 Drive conforms to: ATA/ATAPI-6 T13 1410D revision 3a:

 * signifies the current active mode

								Pavel

-- 
Thanks, Sharp!
