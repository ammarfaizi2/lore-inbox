Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932500AbVHNMA5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932500AbVHNMA5 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 14 Aug 2005 08:00:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932501AbVHNMA5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 14 Aug 2005 08:00:57 -0400
Received: from mta07-winn.ispmail.ntl.com ([81.103.221.47]:23970 "EHLO
	mta07-winn.ispmail.ntl.com") by vger.kernel.org with ESMTP
	id S932500AbVHNMA5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 14 Aug 2005 08:00:57 -0400
Message-ID: <42FF3CBA.1030900@gentoo.org>
Date: Sun, 14 Aug 2005 13:44:42 +0100
From: Daniel Drake <dsd@gentoo.org>
User-Agent: Mozilla Thunderbird 1.0.6 (X11/20050723)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: CaT <cat@zip.com.au>
Cc: linux-kernel@vger.kernel.org, alan@lxorguk.ukuu.org.uk
Subject: Re: IT8212/ITE RAID
References: <20050814053017.GA27824@zip.com.au> <42FF263A.8080009@gentoo.org> <20050814114733.GB27824@zip.com.au>
In-Reply-To: <20050814114733.GB27824@zip.com.au>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

CaT wrote:
>>>1. Alan Cox's IDE driver that was included in his ac patchset, which
>>>  seems to have died at 2.6.11ac7.
>>
>>Alan's driver has been merged into 2.6.13. You can get the up-to-date 
> 
> 
> Wooooooooooooooooooooooooooo!
> 
> 
>>patches here:
>>
>>http://dev.gentoo.org/~dsd/genpatches/trunk/2.6.12/2315_ide-no-lba.patch
>>http://dev.gentoo.org/~dsd/genpatches/trunk/2.6.12/4345_it8212.patch
> 
> 
> Didn't use these patches. Just went to 13-rc6 for now to test. All works
> as before with the following errors on bootup:

Alan Cox might be interested in these, adding to CC.

> 
> [227523.229512] hda: max request size: 128KiB
> [227523.229557] hda: 390721968 sectors (200049 MB) w/8192KiB Cache, CHS=24321/255/63, BUG
> [227523.229631] hda: cache flushes not supported
> [227523.229932]  hda:hda: recal_intr: status=0x51 { DriveReady SeekComplete Error }
> [227523.230905] hda: recal_intr: error=0x04 { DriveStatusError }
> [227523.230952] ide: failed opcode was: unknown
> [227524.379085]  hda1
> [227524.379710] hdc: max request size: 128KiB
> [227524.379752] hdc: 120103200 sectors (61492 MB) w/1821KiB Cache, CHS=16383/255/63, BUG
> [227524.379825] hdc: cache flushes not supported
> [227524.379991]  hdc:hdc: recal_intr: status=0x51 { DriveReady SeekComplete Error }
> [227524.380702] hdc: recal_intr: error=0x04 { DriveStatusError }
> [227524.380748] ide: failed opcode was: unknown
> [227525.536757]  hdc1 hdc2
> 
> 
> /dev/hda:
> 
>  Model=ST3200822A, FwRev=3.01, SerialNo=3LJ22Y8F
>  Config={ HardSect NotMFM HdSw>15uSec Fixed DTR>10Mbs RotSpdTol>.5% }
>  RawCHS=16383/16/63, TrkSize=0, SectSize=0, ECCbytes=4
>  BuffType=unknown, BuffSize=8192kB, MaxMultSect=16, MultSect=16
>  CurCHS=65535/1/63, CurSects=4128705, LBA=yes, LBAsects=268435455
>  IORDY=on/off
>  PIO modes:  pio0 pio1 pio2 
>  DMA modes:  mdma0 mdma1 mdma2 
>  AdvancedPM=no
>  Drive conforms to: ATA/ATAPI-6 T13 1410D revision 2: 
> 
>  * signifies the current active mode
> 
> 
> /dev/hdc:
> 
>  Model=IC35L060AVV207-0, FwRev=V22OA63A, SerialNo=VNVB01G2RAK8XH
>  Config={ HardSect NotMFM HdSw>15uSec Fixed DTR>10Mbs }
>  RawCHS=16383/16/63, TrkSize=0, SectSize=0, ECCbytes=52
>  BuffType=DualPortCache, BuffSize=1821kB, MaxMultSect=16, MultSect=16
>  CurCHS=16383/16/63, CurSects=16514064, LBA=yes, LBAsects=120103200
>  IORDY=on/off
>  PIO modes:  pio0 pio1 pio2 
>  DMA modes:  mdma0 mdma1 mdma2 
>  AdvancedPM=no
>  Drive conforms to: ATA/ATAPI-6 T13 1410D revision 3a: 
> 
>  * signifies the current active mode
> 

