Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S311871AbSEHIGS>; Wed, 8 May 2002 04:06:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S311884AbSEHIGR>; Wed, 8 May 2002 04:06:17 -0400
Received: from mta05-svc.ntlworld.com ([62.253.162.45]:6357 "EHLO
	mta05-svc.ntlworld.com") by vger.kernel.org with ESMTP
	id <S311871AbSEHIGQ>; Wed, 8 May 2002 04:06:16 -0400
Message-ID: <3CD8DE44.3090700@notnowlewis.co.uk>
Date: Wed, 08 May 2002 09:13:56 +0100
From: mikeH <mikeH@notnowlewis.co.uk>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0rc1) Gecko/20020502
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Tomasz Rola <rtomek@cis.com.pl>
CC: linux-kernel@vger.kernel.org
Subject: Re: lost interrupt
In-Reply-To: <Pine.LNX.3.96.1020508042330.2702K-100000@pioneer>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Tomasz Rola wrote:

>hdparm -u0 /dev/hdX  for every X in existing disks you have problems with.
>  
>
>
>hdparm -d0a0u0 /dev/ide/host0/bus0/target0/lun0/disc (or /dev/hda).
>
>bye
>T.
>
>  
>
Thanks, I tried that but to no avail :(

To expand on the problem :

I have a creative DVD 5x drive and some unbranded CD-RW drive. The 
problem occurs on both when I try to rip audio.

I know for a fact they both have the capability to rip audio nicely, I 
have seen them do it under a 2.2.X kernel, but now I'm running 2.4.18 (I 
need 2.4 for my nvidia card)

However, hdparm returns this (on both drives, no matter what 
slave/master dma/irq combo I use)...

 HDIO_GET_MULTCOUNT failed: Invalid argument
 I/O support  =  0 (default 16-bit)
 unmaskirq    =  0 (off)
 using_dma    =  0 (off)
 keepsettings =  0 (off)
 HDIO_GET_NOWERR failed: Invalid argument
 readonly     =  1 (on)
 readahead    =  0 (off)
 HDIO_GETGEO failed: Invalid argument
 busstate     =  1 (on)
 HDIO_GET_ACOUSTIC failed: Invalid argument

See the worrying "HDIO_GET_ACOUSTIC failed: Invalid argument" ?

I'm not sure who is maintaining that part of the kernel though.

Thanks for any help,

mikeH


