Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262468AbTJIVWc (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Oct 2003 17:22:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262564AbTJIVWc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Oct 2003 17:22:32 -0400
Received: from mion.elka.pw.edu.pl ([194.29.160.35]:17662 "EHLO
	mion.elka.pw.edu.pl") by vger.kernel.org with ESMTP id S262468AbTJIVW3
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Oct 2003 17:22:29 -0400
From: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
To: "Howard Duck" <h.t.d@gmx.net>
Subject: Re: kernel 2.6.0betaX: ich5 sata enhanced mode hangs during init
Date: Thu, 9 Oct 2003 23:26:08 +0200
User-Agent: KMail/1.5.4
References: <22605.1065733565@www40.gmx.net>
In-Reply-To: <22605.1065733565@www40.gmx.net>
Cc: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200310092326.08362.bzolnier@elka.pw.edu.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


You are using drivers/ide, right?
Please also test 2.5.75 and snapshot kernels
http://www.kernel.org/pub/linux/kernel/v2.5/snapshots/old/

thanks,
--bartlomiej

On Thursday 09 of October 2003 23:06, Howard Duck wrote:
> Hi
>
> I have a Mainboard with a intel 865PE chipset. I tested many kernels to get
> my
> Serial-ATA (sata) disk to work in enhanced mode and so far only one kernel
> works - 2.5.74. I need the enhanced mode because I lose all secondary ide
> ports if i switch to legacy/compatible mode in the mainboards bios (which
> disables some of my drives).
>
> Since the first beta of kernel 2.6.0 i had no luck in successfully booting
> the
> machine unless i switched to SATA legacy mode. All 2.6.0beta-kernels make
> it
>
> to the init sequence and detect the sata disk, but the system hangs at
> random
> postions during init (starting devfsd, mounting swap or setting the
> machines
>
> hostname, well - somewhere during startup).
>
> I tried removing swap from /etc/fstab and disabling some init-scripts but
> it
>
> doesn't help. Booting in "single" mode does not work too. The only thing
> that
> works is using legacy sata support, so i guess it is related to some new
> code for
> handling serial ata controllers/disks (the machine boots off a sata disk)
> in the
> 2.6.0beta kernels. 2.5.74 boots and works w/o problems, but i'd feel better
> if i
> run a kernel marked "stable" ;)
>
> Is there something i can do to trace the problem of the hang during boot,
> maybe
> some special kernel options, new user-space tools,...? Is this maybe
> related to
> SMP support or hyperthreading cpus?
>
> I am open for any hints or test-procedures that may help to fix or find the
> problem.
> thanks in advance
>  Michael Kefeder
>
> p.s.: i'm not subscribed to the lkml, please put me on CC when answering

