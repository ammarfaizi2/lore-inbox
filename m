Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267437AbTAVLzq>; Wed, 22 Jan 2003 06:55:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267438AbTAVLzq>; Wed, 22 Jan 2003 06:55:46 -0500
Received: from astound-64-85-224-253.ca.astound.net ([64.85.224.253]:52741
	"EHLO master.linux-ide.org") by vger.kernel.org with ESMTP
	id <S267437AbTAVLzp> convert rfc822-to-8bit; Wed, 22 Jan 2003 06:55:45 -0500
Date: Wed, 22 Jan 2003 04:00:22 -0800 (PST)
From: Andre Hedrick <andre@linux-ide.org>
To: Joerg Schilling <schilling@fokus.fraunhofer.de>
cc: axboe@suse.de, cdwrite@other.debian.org, greg@ulima.unil.ch,
       linux-kernel@vger.kernel.org
Subject: Re: Can't burn DVD under 2.5.59 with ide-cd
In-Reply-To: <200301220823.h0M8NG2o022692@burner.fokus.gmd.de>
Message-ID: <Pine.LNX.4.10.10301220355440.20139-100000@master.linux-ide.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Joerg,

Then you are aware of the push/pull by one bit as linux does not set a
reserved place holder for bit0 in the status byte.  I have to agree with
you that it stinks and make decoding status codes messy when supporting
N-interfaces of the protocol.

Cheers,

Andre Hedrick
LAD Storage Consulting Group


On Wed, 22 Jan 2003, Joerg Schilling wrote:

> >From axboe@suse.de Wed Jan 22 09:06:12 2003
> 
> >> >BURN-Free is ON.
> >> >Starting new track at sector: 0
> >> >Track 01:    4 of 4001 MB written (fifo  96%)  16.1x.cdrecord-prodvd: Success. write_g1: scsi sendcmd: no error
> >> >CDB:  2A 00 00 00 08 B8 00 00 1F 00
> >> >status: 0x1 (GOOD STATUS)
> >> >resid: 63488
> >> >cmd finished after 0.008s timeout 100s
> >> 
> >> I can't tell you what happened because the kernel is broken :-(
> >> 
> >> If you fix the kernel, you will get a readble error message,
> 
> >How helpful. How about saying what's broken instead and I'd be happy to
> >fix it.
> 
> I thought it's obvious: It is most likely a problem caused by the broken 
> bit #defines in the Linux kernel for the SCSI status byte. I assume that
> status should be 0x02 instead of 0x01. In addition, I would guess that
> for the same reason, a kernel instance did not fetch the sense data as
> libscg should try to work around these Linux bugs if at least the first 
> sense byte is != 0.
> 
> Jörg
> 
>  EMail:joerg@schily.isdn.cs.tu-berlin.de (home) Jörg Schilling D-13353 Berlin
>        js@cs.tu-berlin.de		(uni)  If you don't have iso-8859-1
>        schilling@fokus.fhg.de		(work) chars I am J"org Schilling
>  URL:  http://www.fokus.fhg.de/usr/schilling   ftp://ftp.berlios.de/pub/schily
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 

