Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313567AbSDQLk3>; Wed, 17 Apr 2002 07:40:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313568AbSDQLk2>; Wed, 17 Apr 2002 07:40:28 -0400
Received: from mail.gmx.de ([213.165.64.20]:42779 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id <S313567AbSDQLk1>;
	Wed, 17 Apr 2002 07:40:27 -0400
Date: Wed, 17 Apr 2002 13:40:00 +0200
From: Sebastian Droege <sebastian.droege@gmx.de>
To: Martin Dalecki <dalecki@evision-ventures.com>
Cc: axboe@suse.de, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] IDE TCQ #4
Message-Id: <20020417134000.4e326dcf.sebastian.droege@gmx.de>
In-Reply-To: <3CBD4F2F.6090308@evision-ventures.com>
X-Mailer: Sylpheed version 0.7.4 (GTK+ 1.2.10; i386-debian-linux-gnu)
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
 boundary="=.46MrfHC6rOo4Sq"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--=.46MrfHC6rOo4Sq
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 17 Apr 2002 12:32:15 +0200
Martin Dalecki <dalecki@evision-ventures.com> wrote:

> Sebastian Droege wrote:
> > On Wed, 17 Apr 2002 09:48:33 +0200
> > Martin Dalecki <dalecki@evision-ventures.com> wrote:
> > 
> > 
> >>Sebastian Droege wrote:
> >>
> >>>On Tue, 16 Apr 2002 20:09:14 +0200
> >>>Jens Axboe <axboe@suse.de> wrote:
> >>>
> >>>
> >>>
> >>>>On Tue, Apr 16 2002, Sebastian Droege wrote:
> >>>>
> >>>>
> >>>>>Hi,
> >>>>>just one short question:
> >>>>>My hda supports TCQ but my hdb doesn't
> >>>>>Is it safe to enable TCQ in kernel config?
> >>>>
> >>>>yes, should be safe.
> >>>>
> >>>>-- 
> >>>>Jens Axboe
> >>>>
> >>>
> >>>Ok it really works ;)
> >>>But there's another problem in 2.5.8 with ide patches until 37 applied (they don't appear with 2.5.8 and ide patches until 35), the unexpected interrupts (look at the relevant dmesg output at the bottom). They appear with and without TCQ enabled.
> >>>If you need more informations, just ask :)
> >>
> >>They are not a problem. They are just diagnostics for us and will
> >>go away at some point in time.
> > 
> > Ok but there are actually 2 real problems then...
> > 1.
> > TCQ on hda is enabled with queue depth 32 and CONFIG_BLK_DEV_IDE_TCQ_FULL enabled
> > When I do many transfers on the hard disk I get a "ide_dma_queued_start: abort (stat=d0)" after some time and the IDE system doesn't respond anymore :(
> > 2.
> > when I cat /proc/ide/ide1/hdc/identify I get 2 unexpected interrupts
> > hdc and hdd are both cdrom drives (accessed via scsi-emulation if relevant) but the problem shows up only with hdc
> > 
> > and maybe a third problem ;)
> > in /proc/ide/ide0/hda/tcq there is written:
> > DMA status: not running
> > but DMA is explicitly enabled by hdparm and shows up in /proc/ide/ide0/hda/settings
> 
> Basically right now DMA on CD-ROM devices is "disabled" due to the
> fact that ide-cd.c is pasing struct packet_command through the rq->special
> field. This is subject to change soon becouse I'm right now adpting ide-cd
> to use the recently introduced struct ata_request stuff.
> So it doesn't make much sense if you test it - becouse the issues are just well
> known. However if you see an IDE xx which contains a "fix ide-cd blah blah" in
> the log - I would be really glad if you could have a look in to it.
> 
Yeah sure but hda is a hard disk
The both cdrom drives aren't touched by hdparm
And I don't see such message (maybe because the both cdroms are accessed via scsi emulation?!) and atapi cdrom support isn't compiled into the kernel

Bye
--=.46MrfHC6rOo4Sq
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.6 (GNU/Linux)

iD8DBQE8vV8Se9FFpVVDScsRAsGpAKCepnUdniijRmcGhKLqROh6Og2IwwCeIU1d
42bCrzrlXQdONYWK0QhtMlU=
=H3sE
-----END PGP SIGNATURE-----

--=.46MrfHC6rOo4Sq--

