Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280600AbRKBIpX>; Fri, 2 Nov 2001 03:45:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280602AbRKBIpD>; Fri, 2 Nov 2001 03:45:03 -0500
Received: from spiral.extreme.ro ([212.93.159.205]:3456 "HELO
	spiral.extreme.ro") by vger.kernel.org with SMTP id <S280600AbRKBIoy>;
	Fri, 2 Nov 2001 03:44:54 -0500
Date: Fri, 2 Nov 2001 12:48:50 +0200 (EET)
From: Dan Podeanu <pdan@spiral.extreme.ro>
To: Jens Axboe <axboe@suse.de>
cc: <linux-kernel@vger.kernel.org>
Subject: Re: ide-scsi bug, or..?
In-Reply-To: <20011102082314.E607@suse.de>
Message-ID: <Pine.LNX.4.33L2.0111021246490.1987-100000@spiral.extreme.ro>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2 Nov 2001, Jens Axboe wrote:

> On Fri, Nov 02 2001, Dan Podeanu wrote:
> >
> > Hello,
> >
> > Upon trying to mount a CD-RW I get the following error:
> >
> > ide-scsi: hdc: unsupported command in request queue (0)
> > end_request: I/O error, dev 16:01 (hdc), sector 64
> > isofs_read_super: bread failed, dev=16:01, iso_blknum=16, block=32
> > mount: wrong fs type, bad option, bad superblock on /dev/hdc1,
> >
> > Note that I use the hdd=ide-scsi parameter and that the CD is detected as
> > SCSI:
> >
> > hdc: CD-W54E, ATAPI CD/DVD-ROM drive
> >
> > SCSI subsystem driver Revision: 1.00
> > scsi0 : SCSI host adapter emulation for IDE ATAPI devices
> >   Vendor: TEAC      Model: CD-W54E           Rev: 1.1B
> >   Type:   CD-ROM                             ANSI SCSI revision: 02
>
> You are trying to mount /dev/hdc and that is handled by ide-scsi. Mount
> /dev/sr0 instead. For that you must also remember to configure SCSI
> CD-ROM support, which you haven't done:
>
> # CONFIG_BLK_DEV_SR is not set
>

That config was after several attempts of getting a functional kernel in
that aspect.

With CONFIG_BLK_DEV_SR=y, the same result. Also note that mount/cat/etc.
on hdc _should_ work, but it fails both there and on /dev/sg0, etc.

