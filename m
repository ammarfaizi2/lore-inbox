Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262806AbTCVQOJ>; Sat, 22 Mar 2003 11:14:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262834AbTCVQOJ>; Sat, 22 Mar 2003 11:14:09 -0500
Received: from natsmtp01.webmailer.de ([192.67.198.81]:9170 "EHLO
	post.webmailer.de") by vger.kernel.org with ESMTP
	id <S262806AbTCVQOI>; Sat, 22 Mar 2003 11:14:08 -0500
Date: Sat, 22 Mar 2003 17:25:02 +0100
From: Dominik Brodowski <linux@brodo.de>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: 2.5.65-ac2 -- hda/ide trouble on ICH4
Message-ID: <20030322162502.GA870@brodo.de>
References: <20030322140337.GA1193@brodo.de> <1048350905.9219.1.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1048350905.9219.1.camel@irongate.swansea.linux.org.uk>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Mar 22, 2003 at 04:35:05PM +0000, Alan Cox wrote:
> On Sat, 2003-03-22 at 14:03, Dominik Brodowski wrote:
> > hda: host protected area => 1
> > hda: 160836480 sectors (82348 MB) w/1863KiB Cache, CHS=159560/16/63, UDMA(100)
> >  hda: [PTBL] [10011/255/63] hda1 hda2 hda3 hda4 < hda5 hda6 hda7 hda8 hda9 >
> > 
> > and *deadlock*...
> 
> Where is the lock, what does the NMI oopser show ?

The lock is directly "below" that line -- and the NMI oopser isn't
triggered, AFAICT

> > in plain 2.5.65 I was seeing strange error messages like:
> > 
> > Mar 19 20:29:55 mondschein kernel: hda: dma_timer_expiry: dma status == 0x24
> > Mar 19 20:29:55 mondschein kernel: hda: lost interrupt
> > Mar 19 20:29:55 mondschein kernel: hda: dma_intr: bad DMA status (dma_stat=30)
> > Mar 19 20:29:55 mondschein kernel: hda: dma_intr: status=0x52 { DriveReady SeekComplete Index }
> > Mar 19 20:29:55 mondschein kernel:
> 
> I've seen 3 or 4 reports of this, none of them duplicatable with the same IDE
> code on 2.4 so far. Which is odd but I don't yet understand what is going on.
/me neither, unfortunately :-(

	Dominik
