Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313560AbSDQL3U>; Wed, 17 Apr 2002 07:29:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313565AbSDQL3U>; Wed, 17 Apr 2002 07:29:20 -0400
Received: from sproxy.gmx.net ([213.165.64.20]:56561 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id <S313560AbSDQL3T>;
	Wed, 17 Apr 2002 07:29:19 -0400
Date: Wed, 17 Apr 2002 13:28:52 +0200
From: Sebastian Droege <sebastian.droege@gmx.de>
To: Martin Dalecki <dalecki@evision-ventures.com>
Cc: axboe@suse.de, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] IDE TCQ #4
Message-Id: <20020417132852.4cf20276.sebastian.droege@gmx.de>
In-Reply-To: <3CBD28D1.6070702@evision-ventures.com>
X-Mailer: Sylpheed version 0.7.4 (GTK+ 1.2.10; i386-debian-linux-gnu)
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
 boundary="=.TsqYka/1nnHVG6"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--=.TsqYka/1nnHVG6
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 17 Apr 2002 09:48:33 +0200
Martin Dalecki <dalecki@evision-ventures.com> wrote:

> Sebastian Droege wrote:
> > On Tue, 16 Apr 2002 20:09:14 +0200
> > Jens Axboe <axboe@suse.de> wrote:
> > 
> > 
> >>On Tue, Apr 16 2002, Sebastian Droege wrote:
> >>
> >>>Hi,
> >>>just one short question:
> >>>My hda supports TCQ but my hdb doesn't
> >>>Is it safe to enable TCQ in kernel config?
> >>
> >>yes, should be safe.
> >>
> >>-- 
> >>Jens Axboe
> >>
> > 
> > Ok it really works ;)
> > But there's another problem in 2.5.8 with ide patches until 37 applied (they don't appear with 2.5.8 and ide patches until 35), the unexpected interrupts (look at the relevant dmesg output at the bottom). They appear with and without TCQ enabled.
> > If you need more informations, just ask :)
> 
> They are not a problem. They are just diagnostics for us and will
> go away at some point in time.
Ok but there are actually 2 real problems then...
1.
TCQ on hda is enabled with queue depth 32 and CONFIG_BLK_DEV_IDE_TCQ_FULL enabled
When I do many transfers on the hard disk I get a "ide_dma_queued_start: abort (stat=d0)" after some time and the IDE system doesn't respond anymore :(
2.
when I cat /proc/ide/ide1/hdc/identify I get 2 unexpected interrupts
hdc and hdd are both cdrom drives (accessed via scsi-emulation if relevant) but the problem shows up only with hdc

and maybe a third problem ;)
in /proc/ide/ide0/hda/tcq there is written:
DMA status: not running
but DMA is explicitly enabled by hdparm and shows up in /proc/ide/ide0/hda/settings

I'll do some more testings later the day

Bye
--=.TsqYka/1nnHVG6
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.6 (GNU/Linux)

iD8DBQE8vVx3e9FFpVVDScsRAnZGAJ9JA4sUP1AU3Xm2bnxQdiUllIt/UQCgpD51
AqW3Glk0/dvug++9MCv/A7s=
=5px5
-----END PGP SIGNATURE-----

--=.TsqYka/1nnHVG6--

