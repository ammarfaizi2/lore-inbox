Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262187AbTJFTIe (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Oct 2003 15:08:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262156AbTJFTId
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Oct 2003 15:08:33 -0400
Received: from mion.elka.pw.edu.pl ([194.29.160.35]:11147 "EHLO
	mion.elka.pw.edu.pl") by vger.kernel.org with ESMTP id S262187AbTJFTH4
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Oct 2003 15:07:56 -0400
From: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
To: "Daniel B." <dsb@smart.net>
Subject: Re: IDE DMA errors, massive disk corruption:  Why?  Fixed Yet?  Why not  re-do failed op?
Date: Mon, 6 Oct 2003 21:11:17 +0200
User-Agent: KMail/1.5.4
References: <3F81B790.B8AF7136@smart.net>
In-Reply-To: <3F81B790.B8AF7136@smart.net>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200310062111.17006.bzolnier@elka.pw.edu.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


There are different IDE DMA errors.
Please post error, dmesg and .config.

On Monday 06 of October 2003 20:42, Daniel B. wrote:
> I just got bitten _again_ by IDE DMA timeout errors and massive
> filesystem corruption in kernel 2.4.22 (on an Asus A7M266-D dual-Athlon
> XP motherboard (AMD 768 chip / amd7441 IDE controller)).
>
> (I had turned DMA off in my init scripts, but apparently Debian
> unstable's k7-smp configuration enables DMA by default before my init
> scripts get control.  Ext3 journal "recovery" trashed my system
> partition.)
>
> What's going on with the IDE DMA bugs?  They have existed since 2.2
> (right?), and even at .22 in the 2.4 series they still exist.  Why
> have they been around so long?  Is it that few kernel developers use
> the combinations of hardware or configuration options that expose
> the bugs (like my dual-CPU box with IDE, not SCSI, disks)?

Well, yes, I have no problems for example :-).

> Are the DMA bugs believed to be fixed (for real) yet?  IF so, in which
> version?
>
> Is there any consolidated documentation of the combinations of factors
> that cause corruption, or of how to reliably avoid corruption (like
> all the things to check to make sure your kernel never even tries to
> enable DMA)?
>
>
> Also, why does a DMA timeout cause such corruption?  Doesn't the kernel
> keep track of uncompleted operations, retain the information needed to
> try again, and try again if there's a failure?  If not, why not?
>
> If it can't try again, shouldn't the kernel at least abort after one
> disk-write failure instead of performing additional writes, which
> frequently depend on the previous writes?  (E.g., if I try to read
> block 1's data and write it to block 2, and then write something new
> to block 1, if the first write fails but continue and do the second
> write, data gets destroyed.  If the first write fails and I stop right
> away, less is destroyed.)

Are you sure you don't have faulty drive?

--bartlomiej

