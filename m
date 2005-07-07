Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261461AbVGGNm3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261461AbVGGNm3 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Jul 2005 09:42:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261523AbVGGNkW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Jul 2005 09:40:22 -0400
Received: from nproxy.gmail.com ([64.233.182.192]:53891 "EHLO nproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261495AbVGGNiI convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Jul 2005 09:38:08 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=ha/krOXShKa3lqiwFw79j5kR+5xXiXj27W+1oXYyH0mLUnnF93E4QmeFyHypV3VInVT//N24PLoBpdkF2DhiN1fhCzXXpbhmKHaycWTdwdvcSjmTh9SNXOJQlziEKMm/EFqaAs/F6EO8RvUl3+Z0kh7XiOy5pg/WMYEFL73JotE=
Message-ID: <84144f020507070638393f68d6@mail.gmail.com>
Date: Thu, 7 Jul 2005 16:38:07 +0300
From: Pekka Enberg <penberg@gmail.com>
Reply-To: Pekka Enberg <penberg@gmail.com>
To: knobi@knobisoft.de
Subject: Re: Head parking (was: IBM HDAPS things are looking up)
Cc: linux-kernel@vger.kernel.org, axboe@suse.de,
       Pekka Enberg <penberg@cs.helsinki.fi>
In-Reply-To: <20050707131331.12406.qmail@web32602.mail.mud.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <20050707131331.12406.qmail@web32602.mail.mud.yahoo.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/7/05, Martin Knoblauch <knobi@knobisoft.de> wrote:
>  Interesting. Same Notebook, same drive. The program say "not parked"
> :-( This is on FC2 with a pretty much vanilla 2.6.9 kernel.
> 
> [root@l15833 tmp]# uname -a
> Linux l15833 2.6.9-noagp #1 Wed May 4 16:09:14 CEST 2005 i686 i686 i386
> GNU/Linux
> [root@l15833 tmp]# hdparm -i /dev/hda
> 
> /dev/hda:
> 
>  Model=HTS726060M9AT00, FwRev=MH4OA6BA, SerialNo=MRH403M4GS88XB
>  Config={ HardSect NotMFM HdSw>15uSec Fixed DTR>10Mbs }
>  RawCHS=16383/16/63, TrkSize=0, SectSize=0, ECCbytes=4
>  BuffType=DualPortCache, BuffSize=7877kB, MaxMultSect=16, MultSect=16
>  CurCHS=16383/16/63, CurSects=16514064, LBA=yes, LBAsects=117210240
>  IORDY=on/off, tPIO={min:240,w/IORDY:120}, tDMA={min:120,rec:120}
>  PIO modes:  pio0 pio1 pio2 pio3 pio4
>  DMA modes:  mdma0 mdma1 mdma2
>  UDMA modes: udma0 udma1 udma2 udma3 udma4 *udma5
>  AdvancedPM=yes: mode=0x80 (128) WriteCache=enabled
>  Drive conforms to: ATA/ATAPI-6 T13 1410D revision 3a:
> 
>  * signifies the current active mode
> 
> [root@l15833 tmp]# ./park /dev/hda
> head not parked 4c
> [root@l15833 tmp]#

Martin, don't trim the cc!

haji ~ # uname -a
Linux haji 2.6.12 #12 Mon Jun 20 09:39:37 EEST 2005 i686 Intel(R)
Pentium(R) M processor 2.00GHz GenuineIntel GNU/Linux

haji ~ # hdparm -i /dev/hda

/dev/hda:

 Model=HTS726060M9AT00, FwRev=MH4OA6DA, SerialNo=MRH453M4H2A6PB
 Config={ HardSect NotMFM HdSw>15uSec Fixed DTR>10Mbs }
 RawCHS=16383/16/63, TrkSize=0, SectSize=0, ECCbytes=4
 BuffType=DualPortCache, BuffSize=7877kB, MaxMultSect=16, MultSect=16
 CurCHS=16383/16/63, CurSects=16514064, LBA=yes, LBAsects=117210240
 IORDY=on/off, tPIO={min:240,w/IORDY:120}, tDMA={min:120,rec:120}
 PIO modes:  pio0 pio1 pio2 pio3 pio4
 DMA modes:  mdma0 mdma1 mdma2
 UDMA modes: udma0 udma1 udma2 udma3 udma4 *udma5
 AdvancedPM=yes: mode=0x80 (128) WriteCache=enabled
 Drive conforms to: ATA/ATAPI-6 T13 1410D revision 3a:

 * signifies the current active mode
