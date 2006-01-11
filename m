Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751458AbWAKLYc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751458AbWAKLYc (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 Jan 2006 06:24:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751455AbWAKLYb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 Jan 2006 06:24:31 -0500
Received: from picard.linux.it ([213.254.12.146]:54225 "EHLO picard.linux.it")
	by vger.kernel.org with ESMTP id S1751450AbWAKLYa (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 Jan 2006 06:24:30 -0500
Message-ID: <15429.83.103.117.254.1136978669.squirrel@picard.linux.it>
In-Reply-To: <20060111100016.GC2574@elf.ucw.cz>
References: <20060110235554.GA3527@inferi.kami.home>
    <20060110170037.4a614245.akpm@osdl.org>
    <20060111100016.GC2574@elf.ucw.cz>
Date: Wed, 11 Jan 2006 12:24:29 +0100 (CET)
Subject: Re: 2.6.15-mm2: reiser3 oops on suspend and more (bonus oops shot!)
From: "Mattia Dongili" <malattia@linux.it>
To: "Pavel Machek" <pavel@ucw.cz>
Cc: "Andrew Morton" <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       reiserfs-dev@namesys.com, linux-acpi@vger.kernel.org
User-Agent: SquirrelMail/1.4.4
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-Priority: 3 (Normal)
Importance: Normal
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, January 11, 2006 11:00 am, Pavel Machek said:
> Hi!
>
>> Thanks for testing and reporting - it really helps.
>>
>> > 1- reiser3 oopsed[1] twice while suspending to ram. It seems
>> >    reproducible (have some activity on the fs and suspend)
>>
>> No significant reiser3 changes in there, so I'd be suspecting something
>> else has gone haywire.
>
> Suspend to *RAM*? That really does not do anything that should kill
> the filesystems. Has it ever worked before? When? Any SATA?

yes, s2ram! it's a somewhat old laptop (ICH3 chipset), no SATA and it's
been working since quite a long time (don't know exactely I stopped
testing s2ram long time ago  and retried only on 2.6.14), lspci follows:
0000:00:00.0 Host bridge: Intel Corporation 82830 830 Chipset Host Bridge
(rev 02)
0000:00:01.0 PCI bridge: Intel Corporation 82830 830 Chipset AGP Bridge
(rev 02)
0000:00:1d.0 USB Controller: Intel Corporation 82801CA/CAM USB (Hub #1)
(rev 01)
0000:00:1d.1 USB Controller: Intel Corporation 82801CA/CAM USB (Hub #2)
(rev 01)
0000:00:1d.2 USB Controller: Intel Corporation 82801CA/CAM USB (Hub #3)
(rev 01)
0000:00:1e.0 PCI bridge: Intel Corporation 82801 Mobile PCI Bridge (rev 41)
0000:00:1f.0 ISA bridge: Intel Corporation 82801CAM ISA Bridge (LPC) (rev 01)
0000:00:1f.1 IDE interface: Intel Corporation 82801CAM IDE U100 (rev 01)
0000:00:1f.3 SMBus: Intel Corporation 82801CA/CAM SMBus Controller (rev 01)
0000:00:1f.5 Multimedia audio controller: Intel Corporation 82801CA/CAM
AC'97 Audio Controller (rev 01)
0000:00:1f.6 Modem: Intel Corporation 82801CA/CAM AC'97 Modem Controller
(rev 01)
0000:01:00.0 VGA compatible controller: ATI Technologies Inc Radeon
Mobility M6 LY
0000:02:02.0 FireWire (IEEE 1394): Texas Instruments TSB43AA22 IEEE-1394
Controller (PHY/Link Integrated) (rev 02)
0000:02:05.0 CardBus bridge: Ricoh Co Ltd RL5c476 II (rev 80)
0000:02:05.1 CardBus bridge: Ricoh Co Ltd RL5c476 II (rev 80)
0000:02:08.0 Ethernet controller: Intel Corporation 82801CAM (ICH3)
PRO/100 VE (LOM) Ethernet Controller (rev 41)

It's one of the sony PCG-GR214EP/GR214MP/GR215MP/GR314MP/GR315MP/7K/9K
(I'm sorry for line wraps or amenities, I only have a webmail client
available at work...)
Pavel, soon you'll receive a successful s2ram report for
Documentation/power :)

-- 
mattia
:wq!


