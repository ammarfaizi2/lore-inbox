Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161142AbWASLfm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161142AbWASLfm (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 Jan 2006 06:35:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161147AbWASLfm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 Jan 2006 06:35:42 -0500
Received: from uproxy.gmail.com ([66.249.92.200]:16281 "EHLO uproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1161142AbWASLfm convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 Jan 2006 06:35:42 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=pRvmFYijSQF7lzkeLkST4QEFgV9qzI7hdmSK1o91Yp5dhDOhhbNqmzrDHl9cj7CuM2BFk1LJBBIMC3897SlA35INNFLKggsgpXnAs+SBgjFkPPo/kzoUAPQqZwiy8LIf+DB7dWD0wnpQ2n7ryKHY0pKs5iAB6YR9tqvD6XV2UkY=
Message-ID: <58cb370e0601190335w51bb1d25pb5ae575632cedbad@mail.gmail.com>
Date: Thu, 19 Jan 2006 12:35:40 +0100
From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
To: Sebastian Kuzminsky <seb@highlab.com>
Subject: Re: sata_mv important note
Cc: Arkadiusz Miskiewicz <arekm@pld-linux.org>,
       Linux Kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <E1EyxRD-0007Nd-U5@highlab.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <43CD07D5.30302@pobox.com> <E1EytdC-0006DE-IS@highlab.com>
	 <200601171734.25598.arekm@pld-linux.org>
	 <E1EyxRD-0007Nd-U5@highlab.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/17/06, Sebastian Kuzminsky <seb@highlab.com> wrote:
> Arkadiusz Miskiewicz <arekm@pld-linux.org> wrote:
> > On Tuesday 17 January 2006 17:24, Sebastian Kuzminsky wrote:
> > > Jeff Garzik <jgarzik@pobox.com> wrote:
> > > > For sata_mv users, you should be aware of three things:
> > > >
> > > > 1) The Marvell driver is experimental, and not yet considered ready for
> > > > production use.  As Kconfig notes: HIGHLY EXPERIMENTAL.
> > >
> > > Right, understood.
> >
> > I'm using:
> >
> > 03:03.0 SCSI storage controller: Marvell Technology Group Ltd. MV88SX6041=20
> > 4-port SATA II PCI-X Controller (rev 07)
> >
> > but with http://www.keffective.com/mvsata/FC3/mvSata-3.4.2a-patched.tbz driver
> > and it works nicely (+ 2.8GHz Xeon HT, smp kernel). I was quite suprised to
> > see that there are no problems with it in typical usage (while I'm sure that
> > this driver is far away from kernel standards).
>
> I'm using:
>
> 0000:02:01.0 IDE interface: Marvell Technology Group Ltd. MV88SX6081 8-port SATA II PCI-X Controller (rev 09)
>
> I'm running the stock 2.6.15 kernel & the in-kernel driver.  I have four
> disks on this controller.  The controller and disks seem perfectly stable,
> I've been running four parallel "badblocks -n" processes (one on each
> disk) for almost 5 days now.  Using the disks as PVs in LVM works fine,
> and building a RAID-6 out of them also works fine.
>
> But when I build a RAID-6 out of them, and use the array as a PV
> for LVM, the system locks up within seconds (no errors, no sysrq,
> no CapsLock-blinky, no network-pingy).  This behavior is perfectly
> repeatable.

Have you tried using "nmi_watchdog=1" kernel parameter?

> The problem goes away and everything works if I turn on all the debugging
> options in the kernel config (but I dont get any debug output from
> the kernel).

Could you find the specific option which makes the hang go away?

Bartlomiej
