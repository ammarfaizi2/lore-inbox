Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129344AbRCUAw7>; Tue, 20 Mar 2001 19:52:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129359AbRCUAws>; Tue, 20 Mar 2001 19:52:48 -0500
Received: from 24.68.61.66.on.wave.home.com ([24.68.61.66]:15876 "HELO
	sh0n.net") by vger.kernel.org with SMTP id <S129344AbRCUAwh>;
	Tue, 20 Mar 2001 19:52:37 -0500
Date: Tue, 20 Mar 2001 19:52:08 -0500 (EST)
From: Shawn Starr <spstarr@sh0n.net>
To: Wouter Verhelst <wouter.verhelst@advalvas.be>
cc: <linux-kernel@vger.kernel.org>
Subject: Re: CDROM and harddisk fighting over DMA
In-Reply-To: <Pine.LNX.4.21.0103201018080.370-100000@rock.dezevensprong.local>
Message-ID: <Pine.LNX.4.30.0103201950530.1354-100000@coredump.sh0n.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Some CDROMS can do this, My old Acer 12x cdrom was fighting with DMA with
my new Fujitsu drive, I disabled the cd-rom and no more DMA errors ;-)

You might also be able to fix this by rearranging the CD-ROM and drives:
move the CD-ROM off the HD's IDE chain and put it separate (if its not
already).

Shawn.

On Tue, 20 Mar 2001, Wouter Verhelst wrote:

> (I'm not subscribed to linux-kernel, so please CC any answers. TIA)
>
> Hello
>
> Since I bought my new harddisk (a Maxtor 40GB of about a half year old
> now), I've had errors over my console like this:
>
> hda: timeout waiting for DMA
> ide_dmaproc: chipset supported ide_dma_timeout func only: 14
> hda: irq timeout: status=0x58 { DriveReady SeekComplete DataRequest }
>
> hda is my harddisk. The CDROM was first connected to hdb, but I changed
> that to hdc, trying to get rid of these errors. This did not resolve the
> issue.
> After playing around a bit, I found out that these errors occur when both
> the CDROM and the harddisk are being accessed at the same time (well,
> almost; it's not an SMP system ;-). I managed to fix it by disabling DMA
> on the harddisk, using hdparm. Disabling DMA on the CDROM, by contrast,
> did not resolve the issue.
>
> However, as this slows down my data throughput speed quite drastically,
> I'd like to do this differently.
>
> I first posted this to comp.os.linux.setup, but did not get any useful
> information. I believe it's not some misconfiguration from my side, so I
> sent this here since this mailinglist is listed as relevant mailinglist
> for the IDE subsystem; however, if this is the wrong place to ask, please
> redirect.
>
> --
> wouter dot verhelst at advalvas in belgium
>
> Real men don't take backups.
> They put their source on a public FTP-server and let the world mirror it.
> 					-- Linus Torvalds
>
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
>
>

