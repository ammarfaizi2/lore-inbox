Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266741AbUJIMRc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266741AbUJIMRc (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 9 Oct 2004 08:17:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266748AbUJIMRc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 9 Oct 2004 08:17:32 -0400
Received: from spc2-brig1-3-0-cust232.asfd.broadband.ntl.com ([82.1.142.232]:34474
	"EHLO ppgpenguin.kenmoffat.uklinux.net") by vger.kernel.org with ESMTP
	id S266741AbUJIMRa convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 9 Oct 2004 08:17:30 -0400
Date: Sat, 9 Oct 2004 13:17:24 +0100 (BST)
From: Ken Moffat <ken@kenmoffat.uklinux.net>
To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Problem with ide=nodma
In-Reply-To: <58cb370e04100817508fe62d0@mail.gmail.com>
Message-ID: <Pine.LNX.4.58.0410091307550.29011@ppg_penguin.kenmoffat.uklinux.net>
References: <Pine.LNX.4.58.0410090019150.26458@ppg_penguin.kenmoffat.uklinux.net>
  <58cb370e04100817353254b8cd@mail.gmail.com> 
 <Pine.LNX.4.58.0410090140020.26639@ppg_penguin.kenmoffat.uklinux.net>
 <58cb370e04100817508fe62d0@mail.gmail.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-15
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 9 Oct 2004, Bartlomiej Zolnierkiewicz wrote:

> > > Is it possible that you are reading it wrong?
> >
> >  I don't think so, and the box is a lot more responsive.  dmesg shows
> >
> > ide_setup: ide=nodmaIDE: Prevented DMA
>
> This is misleading as drivers are free to override this setting.
>

 Bart, thanks for putting me straight.  Indeed, siimage.c doesn't have
'if (!autodma)' to wrap 'hwif->autodma = 1;' like some of the others
(e.g. hpt366).  Easy enough for me to add it, but for reasons I'm too
dumb to understand that turns off dma even without ide=nodma in the
bootargs, and it then does a series of time out / resets if I try to
enable dma with hdparm :-(

 Obviously, the sensible thing for me to do is to not touch siimage.c
and to turn dma off with hdparm until I'm ready to do extended dma
tests.  It's not as if any sane platforms really want to add extra ide
controllers and then cripple them.

 Thanks anyway.

Ken
-- 
 das eine Mal als Tragödie, das andere Mal als Farce

