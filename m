Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313114AbSDIJY2>; Tue, 9 Apr 2002 05:24:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313117AbSDIJY1>; Tue, 9 Apr 2002 05:24:27 -0400
Received: from celebris.bdk.pl ([212.182.99.100]:27402 "EHLO celebris.bdk.pl")
	by vger.kernel.org with ESMTP id <S313114AbSDIJY0>;
	Tue, 9 Apr 2002 05:24:26 -0400
Date: Tue, 9 Apr 2002 11:32:06 +0200 (CEST)
From: Wojtek Pilorz <wpilorz@bdk.pl>
To: Anssi Saari <as@sci.fi>
cc: Mark Mielke <mark@mark.mielke.cc>, linux-kernel@vger.kernel.org
Subject: Re: PROMBLEM: CD burning at 16x uses excessive CPU, although DMA is
 enabled
In-Reply-To: <20020409083243.GB23043@sci.fi>
Message-ID: <Pine.LNX.4.21.0204091121480.28666-100000@celebris.bdk.pl>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 9 Apr 2002, Anssi Saari wrote:

> Date: Tue, 9 Apr 2002 11:32:43 +0300
> From: Anssi Saari <as@sci.fi>
> To: Mark Mielke <mark@mark.mielke.cc>
> Cc: linux-kernel@vger.kernel.org
> Subject: Re: PROMBLEM: CD burning at 16x uses excessive CPU,
>      although DMA is enabled
> 
> On Mon, Apr 08, 2002 at 05:45:29PM -0400, Mark Mielke wrote:
>  
> > The question is, how is CD burning of raw data different from
> > CD burning of ISO images, in respect to Linux drivers for the
> > hardware
> 
> As far as I know, when burning an ISO image, the image has 2048 byte
> sectors to which the CD writer adds error correction data so that the
> individual sector becomes 2352 bytes. A raw data image includes 2352 byte
> sectors. The obvious difference would be a higher data rate (2352/2048
> or 1.15x more) from computer to writer. 
> 
I have seen something similar when reading CD-Rs (with ISO image burnt);
After I burn a CD I run readcd -c2scan to see if I get any C2 errors;
I am using ASUS 50x CD drive, usually setting the speed to 45x before the
operation (my TEAC CD-RW drive always run at 4x when doing readcd
-c2scan, which is too slow for my patience).

The interesting thing is that while reading ISO image with dd the system
works fine, readcd -c2scan makes it often very unresponsible (just
switching between virtual desktops in KDE may take up to several seconds).

The system is Pentium III running at 720 MHz, ABIT RAID-133 motherboard,
hard disk connected to HPT-370A, CD and CD-RW drived on separate channels,
kernel 2.2.19 + IDE patches, 768 MB RAM.

I am wondering if you could possibly compare the system behaviour with
Linux and FreeBSD when using readcd -c2scan (assuming readcd -c2scan
works with your drives at some reasonable speeds).

Best regards,

Wojtek

