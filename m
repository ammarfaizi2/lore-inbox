Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266341AbUJIApA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266341AbUJIApA (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 8 Oct 2004 20:45:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266344AbUJIApA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 8 Oct 2004 20:45:00 -0400
Received: from spc2-brig1-3-0-cust232.asfd.broadband.ntl.com ([82.1.142.232]:23463
	"EHLO ppgpenguin.kenmoffat.uklinux.net") by vger.kernel.org with ESMTP
	id S266341AbUJIAo6 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 8 Oct 2004 20:44:58 -0400
Date: Sat, 9 Oct 2004 01:44:57 +0100 (BST)
From: Ken Moffat <ken@kenmoffat.uklinux.net>
To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Problem with ide=nodma
In-Reply-To: <58cb370e04100817353254b8cd@mail.gmail.com>
Message-ID: <Pine.LNX.4.58.0410090140020.26639@ppg_penguin.kenmoffat.uklinux.net>
References: <Pine.LNX.4.58.0410090019150.26458@ppg_penguin.kenmoffat.uklinux.net>
 <58cb370e04100817353254b8cd@mail.gmail.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-15
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 9 Oct 2004, Bartlomiej Zolnierkiewicz wrote:

> On Sat, 9 Oct 2004 00:32:01 +0100 (BST), Ken Moffat
> <ken@kenmoffat.uklinux.net> wrote:
> > Hi,
> >
> >  I'm trying a sii 0680 disk controller at the moment, as a possible
> > workaround for some via southbridge problems (this is on a ppc which
> > isn't yet supported by the official kernels, but it has been stable here
> > since 2.6.7 and looks nearly ready for a first review).  Unfortunately,
> > DMA is a big no go at the moment so I have to pass ide=nodma in the
> > bootargs.
> >
> >  I've got the drives plugged into the sii card, and ide=reverse is doing
> > its job.  But although dmesg shows that dma has been turned off,
>
> Is it possible that you are reading it wrong?

 I don't think so, and the box is a lot more responsive.  dmesg shows

ide_setup: ide=nodmaIDE: Prevented DMA

>
> > /proc/ide/hda/settings and hdparm show that dma is in use.  This is in
> > 2.6.9-rc3.
> >
> >  Doesn't ide=nodma work for off-board chipsets ?
>
> siimage host driver doesn't respect "ide=nodma".
> You can hack siimage.c and comment out "hwif->autodma = 1".
>

Ok, thanks.  I'll give that a try later.

Ken
-- 
 das eine Mal als Tragödie, das andere Mal als Farce

