Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261506AbSK0AGU>; Tue, 26 Nov 2002 19:06:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261854AbSK0AGU>; Tue, 26 Nov 2002 19:06:20 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:3082 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S261506AbSK0AGT>; Tue, 26 Nov 2002 19:06:19 -0500
Message-ID: <3DE40E29.4040408@zytor.com>
Date: Tue, 26 Nov 2002 16:13:29 -0800
From: "H. Peter Anvin" <hpa@zytor.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.1) Gecko/20020827
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
CC: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: 2.5.49: Severe PIIX4/ATA filesystem corruption
References: <as0nq9$vnu$1@cesium.transmeta.com> <1038357146.2658.105.camel@irongate.swansea.linux.org.uk>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox wrote:
> On Tue, 2002-11-26 at 21:07, H. Peter Anvin wrote:
> 
>>So, I finally braved it and tried running 2.5.49 on my workstation to
>>test out my RAID-6 patches.  There were no patches outside the md
>>area, and the ordinary filesystems aren't on md drives.
>>
>>The two SCSI drives (SymBIOS controller) work just fine, but I have
>>gotten repeated, severe data corruption on the one ATA drive in the
>>system after only a few hours of operation.
> 
> 
> If you mash the innards of the page cache you'll get corruption
> everywhere, its one of the charms of testing out that area of the code
> on Linux. You might want to debug using 2.5.49 user mode linux rather
> than on raw disks. Its so much easier to use "cp" to generate a
> replacement root_fs 8)
> 

Yes, that's true.  However, the heavily used two SCSI disks saw no 
corruption whatsoever, whereas the single, lightly used ATA disk saw 
heavy corruption; if it was due to experimental unrelated code one would 
have expected corruption everywhere.  This does not mean that it is not 
my fault (as far as UML is concerned, I tried building it quite a few 
times before giving up), but given the severity of the corruption I was 
seeing I thought I'd raise a red flag.

	-hpa


