Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932164AbWB1KaK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932164AbWB1KaK (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Feb 2006 05:30:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932160AbWB1KaK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Feb 2006 05:30:10 -0500
Received: from lucidpixels.com ([66.45.37.187]:47521 "EHLO lucidpixels.com")
	by vger.kernel.org with ESMTP id S932153AbWB1KaH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Feb 2006 05:30:07 -0500
Date: Tue, 28 Feb 2006 05:30:04 -0500 (EST)
From: Justin Piszcz <jpiszcz@lucidpixels.com>
X-X-Sender: jpiszcz@p34
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
cc: Mark Lord <liml@rtr.ca>, Tejun Heo <htejun@gmail.com>,
       David Greaves <david@dgreaves.com>, Mark Lord <lkml@rtr.ca>,
       Jeff Garzik <jgarzik@pobox.com>, linux-kernel@vger.kernel.org,
       IDE/ATA development list <linux-ide@vger.kernel.org>,
       albertcc@tw.ibm.com, axboe@suse.de, Linus Torvalds <torvalds@osdl.org>
Subject: Re: LibPATA code issues / 2.6.15.4
In-Reply-To: <1141122764.3089.52.camel@localhost.localdomain>
Message-ID: <Pine.LNX.4.64.0602280529440.6070@p34>
References: <Pine.LNX.4.64.0602140439580.3567@p34>  <43F2050B.8020006@dgreaves.com>
 <Pine.LNX.4.64.0602141211350.10793@p34>  <200602141300.37118.lkml@rtr.ca>
 <440040B4.8030808@dgreaves.com>  <440083B4.3030307@rtr.ca>
 <Pine.LNX.4.64.0602251244070.20297@p34>  <4400A1BF.7020109@rtr.ca>
 <4400B439.8050202@dgreaves.com>  <4401122A.3010908@rtr.ca>
 <44017B4B.3030900@dgreaves.com>  <4401B560.40702@rtr.ca> <4403704E.4090109@rtr.ca>
  <4403A84C.6010804@gmail.com>  <4403CEA9.4080603@rtr.ca>
 <1141122764.3089.52.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Tue, 28 Feb 2006, Alan Cox wrote:

> On Llu, 2006-02-27 at 23:16 -0500, Mark Lord wrote:
>> Or maybe a whitelist instead, since nearly all existing hardware
>> pre-dates FUA commands.
>
> For controllers just add it as a host flag and it can be handled the
> same way as LBA48 is right now. It may also be some hosts can issue FUA
> with a bit of bandaging (state machine resets/pio etc)
>
> Alan
>

While I have not yet been able to reproduce the problem with the verbose 
patch, here is the hdparm -I:

/dev/sdc:

ATA device, with non-removable media
         Model Number:       WDC WD4000KD-00NAB0
         Serial Number:      WD-WMAMY1020930
         Firmware Revision:  01.06A01
Standards:
         Supported: 7 6 5 4
         Likely used: 7
Configuration:
         Logical         max     current
         cylinders       16383   16383
         heads           16      16
         sectors/track   63      63
         --
         CHS current addressable sectors:   16514064
         LBA    user addressable sectors:  268435455
         LBA48  user addressable sectors:  781422768
         device size with M = 1024*1024:      381554 MBytes
         device size with M = 1000*1000:      400088 MBytes (400 GB)
Capabilities:
         LBA, IORDY(can be disabled)
         Queue depth: 32
         Standby timer values: spec'd by Standard, with device specific 
minimum
         R/W multiple sector transfer: Max = 16  Current = 0
         Recommended acoustic management value: 128, current value: 254
         DMA: mdma0 mdma1 mdma2 udma0 udma1 udma2 udma3 udma4 *udma5 udma6
              Cycle time: min=120ns recommended=120ns
         PIO: pio0 pio1 pio2 pio3 pio4
              Cycle time: no flow control=120ns  IORDY flow control=120ns
Commands/features:
         Enabled Supported:
            *    NOP cmd
            *    READ BUFFER cmd
            *    WRITE BUFFER cmd
            *    Host Protected Area feature set
            *    Look-ahead
            *    Write cache
            *    Power Management feature set
                 Security Mode feature set
            *    SMART feature set
            *    FLUSH CACHE EXT command
            *    Mandatory FLUSH CACHE command
            *    Device Configuration Overlay feature set
            *    48-bit Address feature set
                 Automatic Acoustic Management feature set
                 SET MAX security extension
            *    DOWNLOAD MICROCODE cmd
            *    General Purpose Logging feature set
            *    SMART self-test
            *    SMART error logging
Security:
                 supported
         not     enabled
         not     locked
         not     frozen
         not     expired: security count
         not     supported: enhanced erase
Checksum: correct

