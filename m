Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314504AbSEFPPy>; Mon, 6 May 2002 11:15:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314499AbSEFPPx>; Mon, 6 May 2002 11:15:53 -0400
Received: from pop.gmx.de ([213.165.64.20]:31316 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id <S314504AbSEFPPu>;
	Mon, 6 May 2002 11:15:50 -0400
Date: Mon, 6 May 2002 17:14:35 +0200
From: Sebastian Droege <sebastian.droege@gmx.de>
To: Jens Axboe <axboe@suse.de>
Cc: aia21@cantab.net, wstinsonfr@yahoo.fr, linux-kernel@vger.kernel.org
Subject: Re: vanilla 2.5.13 severe file system corruption experienced follozing e2fsck ...
Message-Id: <20020506171435.29fb592d.sebastian.droege@gmx.de>
In-Reply-To: <20020506134803.GF18817@suse.de>
X-Mailer: Sylpheed version 0.7.4 (GTK+ 1.2.10; i386-debian-linux-gnu)
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
 boundary="=.OovVoeB6iiCPJ'"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--=.OovVoeB6iiCPJ'
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 6 May 2002 15:48:03 +0200
Jens Axboe <axboe@suse.de> wrote:

> On Mon, May 06 2002, Sebastian Droege wrote:
> > On Mon, 6 May 2002 10:50:33 +0200
> > Jens Axboe <axboe@suse.de> wrote:
> > 
> > > On Mon, May 06 2002, Anton Altaparmakov wrote:
> > > > At 06:55 06/05/02, Jens Axboe wrote:
> > > > >On Sun, May 05 2002, Anton Altaparmakov wrote:
> > > > >> Note even with that fix IDE (at least TCQ) is really easy to crash when 
> > > > >you
> > > > >> put the system under heavier I/O (at least on my via box)...
> > > > >
> > > > >If you have stumpled upon a tcq bug, I'd like to know more about it.
> > > > 
> > > > Back trace (sorry didn't have ckermit running so didn't catch the whole 
> > > > output and was too lazy to write it all down): blk_queue_invalidate_tags, 
> > > > tcq_invalidate_queue, ide_dmaq_complete, ide_dmaq_intr, ata_irq_request, 
> > > > ide_dmaq_intr, handle_IRQ_event, do_IRQ, ideprobe_init.
> > > 
> > > Same problem as Sebastian I'm sure, in which case the backtrace holds no
> > > info for me, the IDE messages printed _before_ the panic would be
> > > helpful though :-)
> > Ok here they are (or do you mean the ide initialisation?):
> > 
> > [normal stuff]
> > 
> > ide_tcq_intr_timeout: timeout waiting for service interrupt...
> > ide_tcq_intr_timeout: hwgroup not busy
> > hda: invalidating pending queue (10)
> > kernel BUG at ll_rw_blk.c:407!
> 
> Thanks, yes these were the messages I meant. Could you try 2.4.19-pre8
> plus patches just posted?
Ok... tested
it panics with a NULL pointer dereference at 00000004 after

hda: IBM-DTTA-351010, ATA DISK drive
hdb: WDC WD800BB-00BSA0, ATA DISK drive
hdc: CD-W512EB, ATAPI CD/DVD-ROM drive
hdd: CD-532E-B, ATAPI CD/DVD-ROM drive
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
ide1 at 0x170-0x177,0x376 on irq 15
[panic]

Sorry but I have no more time for testing and oops handcopying today
I'll do that tomorrow
Bye
--=.OovVoeB6iiCPJ'
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.6 (GNU/Linux)

iD8DBQE81p3ee9FFpVVDScsRAmHRAJsEPHvI1frNJHlxat6/zypLE5L9RQCfcgB1
8PiuNjVYmTBdK55MXfq52gM=
=/4xg
-----END PGP SIGNATURE-----

--=.OovVoeB6iiCPJ'--

