Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280652AbRKBLEy>; Fri, 2 Nov 2001 06:04:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280651AbRKBLEo>; Fri, 2 Nov 2001 06:04:44 -0500
Received: from mail.chs.ru ([194.154.71.136]:51984 "EHLO mail.unix.ru")
	by vger.kernel.org with ESMTP id <S280650AbRKBLE2>;
	Fri, 2 Nov 2001 06:04:28 -0500
Content-Type: text/plain; charset=US-ASCII
From: "Sergey S. Kostyliov" <rathamahata@php4.ru>
To: Dan Podeanu <pdan@spiral.extreme.ro>
Subject: Re: ide-scsi bug, or..?
Date: Fri, 2 Nov 2001 14:03:54 +0300
X-Mailer: KMail [version 1.2]
Cc: <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.33L2.0111021246490.1987-100000@spiral.extreme.ro>
In-Reply-To: <Pine.LNX.4.33L2.0111021246490.1987-100000@spiral.extreme.ro>
MIME-Version: 1.0
Message-Id: <01110214035401.05496@arise.lamport.msk.ru>
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> On Fri, 2 Nov 2001, Jens Axboe wrote:
> > On Fri, Nov 02 2001, Dan Podeanu wrote:
> > > Hello,
> > >
> > > Upon trying to mount a CD-RW I get the following error:
> > >
> > > ide-scsi: hdc: unsupported command in request queue (0)
> > > end_request: I/O error, dev 16:01 (hdc), sector 64
> > > isofs_read_super: bread failed, dev=16:01, iso_blknum=16, block=32
> > > mount: wrong fs type, bad option, bad superblock on /dev/hdc1,
> > >
> > > Note that I use the hdd=ide-scsi parameter and that the CD is detected
> > > as SCSI:
> > >
> > > hdc: CD-W54E, ATAPI CD/DVD-ROM drive
> > >
> > > SCSI subsystem driver Revision: 1.00
> > > scsi0 : SCSI host adapter emulation for IDE ATAPI devices
> > >   Vendor: TEAC      Model: CD-W54E           Rev: 1.1B
> > >   Type:   CD-ROM                             ANSI SCSI revision: 02
> >
> > You are trying to mount /dev/hdc and that is handled by ide-scsi. Mount
> > /dev/sr0 instead. For that you must also remember to configure SCSI
> > CD-ROM support, which you haven't done:
> >
> > # CONFIG_BLK_DEV_SR is not set
>
> That config was after several attempts of getting a functional kernel in
> that aspect.
>
> With CONFIG_BLK_DEV_SR=y, the same result. Also note that mount/cat/etc.
> on hdc _should_ work, but it fails both there and on /dev/sg0, etc.
>
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/

try mount /dev/scd0 (not /dev/sg0)  It works for me

				Best regards,
				Sergey S. Kostyliov

