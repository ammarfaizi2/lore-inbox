Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262355AbTJGOjl (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Oct 2003 10:39:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262332AbTJGOjl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Oct 2003 10:39:41 -0400
Received: from mion.elka.pw.edu.pl ([194.29.160.35]:17069 "EHLO
	mion.elka.pw.edu.pl") by vger.kernel.org with ESMTP id S262412AbTJGOji
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Oct 2003 10:39:38 -0400
From: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
To: tigran@aivazian.fsnet.co.uk, Thomas Horsten <thomas@horsten.com>
Subject: Re: [PATCH] [2.4.XX] Silicon Image/CMD Medley Software RAID
Date: Tue, 7 Oct 2003 16:42:59 +0200
User-Agent: KMail/1.5.4
Cc: linux-kernel@vger.kernel.org
References: <8393446.1065535371042.JavaMail.www@wwinf3002>
In-Reply-To: <8393446.1065535371042.JavaMail.www@wwinf3002>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200310071642.59676.bzolnier@elka.pw.edu.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi Tigran,

IMO Silicon Image is a good hardware.

On Tuesday 07 of October 2003 16:02, tigran@aivazian.fsnet.co.uk wrote:
> Hi Thomas,
>
> While we are on the subject of Silicon Image hardware, I wanted to ask ---
> is this normal that this hardware (boxed as "EIO AP-1680 IDE RAID card"),
> see this URL for more info):
>
> http://www.ivmm.com/eio/products_ap1680.html
>
> so horrendously slow, without even using any of its RAID functions (which
> would be slow understandably as they are software RAID)?
>
> Numbers. My IDE drives perform 22-25M/sec (hdparm -t) when connected
> to the onboard IDE controller (6BXD SMP motherboard, old, 2xPIII550, 1G
> RAM) but when  connected to this RAID card and used as plain physical disks
> (no RAID sets configured) they give 2M/sec using DMA and 4M/sec when I
> disable DMA.

What kernel version?
dmesg please.

> I see many people mentioning Silicon Image hardware here, so I assumed
> it is a useable hardware, but if everyone is getting 2M/sec (or 4M/sec and
> hog the whole system performance with PIO!) then am I the first one who
> noticed that the king is, in fact, naked? Shouldn't I expect a decent
> 20-25M/sec hdparm -t from the drives connected to the additional IDE card
> (be it RAID or no RAID, just extra IDE slots)?

There is a rqsize limit problem with SiI SATA controllers
(please search archive for discussion), but ATA shouldn't be affected.

--bartlomiej

