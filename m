Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261529AbSKGSzR>; Thu, 7 Nov 2002 13:55:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261540AbSKGSzR>; Thu, 7 Nov 2002 13:55:17 -0500
Received: from [64.76.155.18] ([64.76.155.18]:46244 "EHLO alumno.inacap.cl")
	by vger.kernel.org with ESMTP id <S261529AbSKGSzP>;
	Thu, 7 Nov 2002 13:55:15 -0500
Date: Thu, 7 Nov 2002 16:01:42 -0300 (CLST)
From: Robinson Maureira Castillo <rmaureira@alumno.inacap.cl>
To: Jens Axboe <axboe@suse.de>
cc: linux-kernel@vger.kernel.org
Subject: Re: 2.5.46: ide-cd cdrecord success report
In-Reply-To: <20021107180347.GI32005@suse.de>
Message-ID: <Pine.LNX.4.44.0211071545450.12033-100000@alumno.inacap.cl>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 7 Nov 2002, Jens Axboe wrote:

> Thanks for the raport. I'd also like raports such as this one (which I
> really do appreciate) to contain an oppinion of how well cd recording
> works on your system now as compared to before. Anything from "didn't
> notice any difference" to "it's much faster, I noticed that because" and
> "bah it sucks right now, ..." would be fine :)
> 

OK, this is what I've done. 
for i in `seq 100`; do tar jxf linux-2.5.41.tar.bz2 ; rm -fr linux-2.5.41 
; done 

and started copying a 571MB ISO image at 10x, then I've started mozilla, 
opened some pages with flash and java, xmms came next, I'm listening to 
mp3 (not a single skip, it used to skip in the "Fixating" part with 
ide-scsi)... ah, and I'm reading email using Evolution. Everything under 
Gnome 2.0 (RH 8.0)

Track 01:  571 of  571 MB written (fifo 100%) [buf  99%]  10.6x.
Track 01: Total bytes read/written: 599654400/599654400 (292800 sectors).
Writing  time:  400.083s
Average write speed   9.9x.
Min drive buffer fill was 73%
Fixating...
Fixating time:   27.454s
cdrecord: fifo had 9446 puts and 9446 gets.
cdrecord: fifo was 0 times empty and 8430 times full, min fill was 76%.

This is a lot better than with ide-scsi, system felt smoother also.

Specs:
Celeron 600Mhz
256MB RAM
cheap mobo, cheap disks UDMA66 and UDMA33 
hdb: Hewlett-Packard CD-Writer Plus 9300, ATAPI CD/DVD-ROM drive

tar was done in the same disk in which ISO image is. I'm using ext3 
data=ordered

The only annoying thing is that if I left the drive without a disc my 
syslog get flooded with end_request: I/O error, dev hdb, sector 0 
messages, but I guess this is somewhat related to nautilus.


Best regards
-- 
Robinson Maureira Castillo
Asesor DAI
INACAP

