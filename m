Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316792AbSHXVjY>; Sat, 24 Aug 2002 17:39:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316795AbSHXVjY>; Sat, 24 Aug 2002 17:39:24 -0400
Received: from astound-64-85-224-253.ca.astound.net ([64.85.224.253]:34826
	"EHLO master.linux-ide.org") by vger.kernel.org with ESMTP
	id <S316792AbSHXVjW>; Sat, 24 Aug 2002 17:39:22 -0400
Date: Sat, 24 Aug 2002 14:42:18 -0700 (PDT)
From: Andre Hedrick <andre@linux-ide.org>
To: Luca Giuzzi <giuzzi@dmf.unicatt.it>
cc: linux-kernel@vger.kernel.org, Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: ide-scsi (or ide-via?) with 2.4.20-pre*-ac*
In-Reply-To: <20020824233311.A6181@dmf.unicatt.it>
Message-ID: <Pine.LNX.4.10.10208241441250.20423-100000@master.linux-ide.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


verified self introduced bug and have unwound the change w/ stubs.
sending patches soon with other changes


On Sat, 24 Aug 2002, Luca Giuzzi wrote:

> I have some weird problems when trying to write
> a CD under a 2.4.20-pre*-ac* kernel [everything
> works fine on the same computer with a
> 2.4.19-rc-ac1]. The CD writer is an LG-8080B
> connected as slave to the secondary channel of a VIA
> vt82c586b (rev. 47) controller.
> 
> Cdrecord, when I try to write an image at full speed
> (that is, speed=8), aborts after the first 4 Mb with
> the following error:
> 
> cdrecord: Input/output error. write_g1: scsi sendcmd: no error
> CDB:  2A 00 00 00 08 99 00 00 1F 00
> status: 0x2 (CHECK CONDITION)
> Sense Bytes: 70 00 05 00 00 00 00 0A 00 00 00 00 24 00 00 00
> Sense Key: 0x5 Illegal Request, Segment 0
> Sense Code: 0x24 Qual 0x00 (invalid field in cdb) Fru 0x0
> Sense flags: Blk 0 (not valid)
> 
> The weird thing is that, according to the "current writing
> speed indication" (I have tried several versions of cdrecord
> as well, and right now I'm doing my tests with 1.11a30 which
> should print the actual transfer rate --- it was just the same
> error with 1.10, though), the computer claims it
> was recording at "20.3x" at the time of the failure: something
> seems to be very wrong indeed. 
> If I re-run cdrecord forcing the speed to be "4x", then it
> succeeds, even if the actual reported (and timed) speed is
> "7.5x".
> 
> Further information:
>  dma is turned off for the drive and toggling unmask-irq
>  does not seem to change anything. The host adapter emulation
>  is seen as the second SCSI controller, the first being an
>  aic7850.
> 
> Is there any further test I can do?
> 
> kind regards,
>  lg
> 
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 

Andre Hedrick
LAD Storage Consulting Group

