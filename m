Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314378AbSEIVM7>; Thu, 9 May 2002 17:12:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314377AbSEIVM6>; Thu, 9 May 2002 17:12:58 -0400
Received: from mta03-svc.ntlworld.com ([62.253.162.43]:48261 "EHLO
	mta03-svc.ntlworld.com") by vger.kernel.org with ESMTP
	id <S314375AbSEIVM4>; Thu, 9 May 2002 17:12:56 -0400
Message-ID: <3CDAE823.5070304@notnowlewis.co.uk>
Date: Thu, 09 May 2002 22:20:35 +0100
From: mikeH <mikeH@notnowlewis.co.uk>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0rc1) Gecko/20020502
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: mikeH <mikeH@notnowlewis.co.uk>
CC: linux-kernel@vger.kernel.org
Subject: Re: PANIC , ide related (was lost interrupt hell)
In-Reply-To: <3CDADAF0.4040605@notnowlewis.co.uk>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Upgrading to 2.4.19-pre8 has fixed the below oops, however, the lost 
intrrupt problem is still there.

Details as follows :

Drives affected : Creative 5x DVD and LG CD-RW (in any 
slave/master/channel config)
I have replaced the ide cables, disabled/enabled dma, used the via82xxxx 
support, used the generic pci ide support, unmasked/masked the 
interrupt, in all possible combinations. There are no irq conflicts.
The drives work perfectly in windows.

Replicating the trouble : try to rip any audio track from a cd using 
cdparanoia, cdda2wav, or even dd

hdparm brings up the following (for both drives):
/dev/hdb:
 HDIO_GET_MULTCOUNT failed: Invalid argument
 I/O support  =  1 (32-bit)
 unmaskirq    =  1 (on)
 using_dma    =  1 (on)
 keepsettings =  0 (off)
 HDIO_GET_NOWERR failed: Invalid argument
 readonly     =  1 (on)
 readahead    =  8 (on)
 HDIO_GETGEO failed: Invalid argument
 busstate     =  1 (on)
 HDIO_GET_ACOUSTIC failed: Invalid argument


Its the HDIO_GET_ACOUSTIC that puzzles me, as both drives rip audio 
perfectly under win98, but fill up my dmesg with "lost interrupt" under 
Linux.

This problem has been recurring with VIA chipsets throughout the 2.4.x 
series and searching the kernel listr archives shows a few other people 
having the same lost interrupt problem but not getting it resolved.

This is driving me crazy... can anyone suggest a fix or is there any 
information you need to assess why this is happening?

Many thanks,

mikeH



mikeH wrote:

> Hi,
>
> On the advice of members of this list, I downloaded 2.4.18, patched to 
> 2.4.19-pre7 installed.
>
> I enabled the via82cxxx option in ide config.
>
> On bootup, just before the partitions are displayed, I get an oops at 
> address 00000040, Null pointer dereferenced. Sorry, I was unable to 
> get any of the other information it displayed :(
>
> mike
>
> -
> To unsubscribe from this list: send the line "unsubscribe 
> linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
>
>



