Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S282290AbRK2Ghr>; Thu, 29 Nov 2001 01:37:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S282305AbRK2Ghi>; Thu, 29 Nov 2001 01:37:38 -0500
Received: from host154.207-175-42.redhat.com ([207.175.42.154]:29383 "EHLO
	lacrosse.corp.redhat.com") by vger.kernel.org with ESMTP
	id <S282290AbRK2Ghd>; Thu, 29 Nov 2001 01:37:33 -0500
Message-ID: <3C05D7AC.8030803@redhat.com>
Date: Thu, 29 Nov 2001 01:37:32 -0500
From: Doug Ledford <dledford@redhat.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.6+) Gecko/20011121
X-Accept-Language: en-us
MIME-Version: 1.0
To: "Leonard N. Zubkoff" <lnz@dandelion.com>
CC: pascal.lengard@wanadoo.fr, linux-kernel@vger.kernel.org
Subject: Re: dac960 broken ?
In-Reply-To: <200111290615.fAT6Fv1l020712@dandelion.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Leonard N. Zubkoff wrote:

>   Date: Wed, 28 Nov 2001 15:19:38 +0100 (CET)
>   From: Pascal Lengard <pascal.lengard@wanadoo.fr>
> 
>   Hello,
> 
>   I have several "servers" using old mylex DAC960P scsi raid adapter.
>   So I though clever to install redhat 7.2 on them ...
> 
>   redhat 7.2 does install and run well with the 2.4.7-10 kernel from the
>   distribution, but when I try upgrading to 2.4.9-13 (via rpm) it does not boot, 
>   there is a problem with resolving ext3fs symbols ... this is more a RedHat
>   problem, but read on :-)


Sounds pretty simple to me.  If you are using lilo, then you might not 
be rerunning lilo after installing the new kernel.  Also, after 
installing a new kernel you need a new initrd image.  Your unresolved 
symbols problem is because you are trying to load the ext3 module from a 
2.4.7-10 kernel in the 2.4.9-13 errata kernel.  The general answer here 
is that there is significant documentation on what must be done to 
upgrade a Red Hat kernel.  Read it.


>   I choosed to compile a customized kernel with only what I need inside kernel
>   (ext3fs, dac960, ..) plus some modules I might need some day.
> 
>   I tried compiling 2.4.14 => my mylex card is not detected !
> 	  (driver dac960 version 2.4.11 from 11 october 2001)
>   I tried with 2.4.9-13 from redhat => same problem
> 	  (driver dac960 version 2.4.10 from 23 july 2001)
>   I tried custom 2.4.7-10 from redhat => works like a charm
> 	  (driver dac960 version 2.4.10 from 1 february 2001)
>   all these kernels were compiled with the same .config (make oldconfig)
> 
>   hardware used:
> 	  DAC960P-2,  D040351-0-IBM REV.E firmware 3.51-0-04
> 
>   detected like this by kernel 2.4.7-10:
>   DAC960: ***** DAC960 RAID Driver Version 2.4.10 of 1 February 2001 *****
>   DAC960: Copyright 1998-2001 by Leonard N. Zubkoff <lnz@dandelion.com>
>   DAC960#0: Configuring Mylex DAC960PD PCI RAID Controller
>   DAC960#0:   Firmware Version: 3.51-0-04, Channels: 2, Memory Size: 4MB
>   DAC960#0:   PCI Bus: 1, Device: 10, Function: 0, I/O Address: 0x6200
>   DAC960#0:   PCI Address: 0xBF800C00 mapped at 0xC482DC00, IRQ Channel: 11
>   DAC960#0:   Controller Queue Depth: 64, Maximum Blocks per Command: 128
>   DAC960#0:   Driver Queue Depth: 63, Scatter/Gather Limit: 17 of 17 Segments
>   DAC960#0:   Stripe Size: 64KB, Segment Size: 8KB, BIOS Geometry: 128/32
> 
> 
>   I am insterested in any clue, since I am stuck to 2.4.7 for now ...
>   linux-kernel readers, please cc me on replies since I am not subscribed
>   to the list.
> 
>   Pascal Lengard
> 
> Hmmm.  Nothing you've described makes any sense to me as I don't believe the
> driver has changed in a way that would break the basic detection of the boards.
> When you say that the card is not detected, precisely what do you mean?  Does
> the driver report anything at all?
> 
> 		Leonard
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 
> 



-- 

  Doug Ledford <dledford@redhat.com>  http://people.redhat.com/dledford
       Please check my web site for aic7xxx updates/answers before
                       e-mailing me about problems

