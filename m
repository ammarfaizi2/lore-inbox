Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264446AbUAaAZb (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 30 Jan 2004 19:25:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264449AbUAaAZb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 30 Jan 2004 19:25:31 -0500
Received: from h00a0cca1a6cf.ne.client2.attbi.com ([65.96.182.167]:23189 "EHLO
	h00a0cca1a6cf.ne.client2.attbi.com") by vger.kernel.org with ESMTP
	id S264446AbUAaAZN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 30 Jan 2004 19:25:13 -0500
Date: Fri, 30 Jan 2004 19:24:12 -0500
From: timothy parkinson <t@timothyparkinson.com>
To: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
Cc: markus reichelt <mr@lists.notified.de>,
       Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: 2.6.1 "clock preempt"?
Message-ID: <20040131002412.GA2293@h00a0cca1a6cf.ne.client2.attbi.com>
Mail-Followup-To: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>,
	markus reichelt <mr@lists.notified.de>,
	Linux Kernel <linux-kernel@vger.kernel.org>
References: <1074800554.21658.68.camel@cog.beaverton.ibm.com> <20040123203835.GA518@h00a0cca1a6cf.ne.client2.attbi.com> <20040127213026.GA1315@lists.notified.de> <200401310032.23285.bzolnier@elka.pw.edu.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200401310032.23285.bzolnier@elka.pw.edu.pl>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jan 31, 2004 at 12:32:23AM +0100, Bartlomiej Zolnierkiewicz wrote:
> On Tuesday 27 of January 2004 22:30, markus reichelt wrote:
> > -----BEGIN PGP SIGNED MESSAGE-----
> > Hash: SHA1
> >
> > timothy parkinson <t@timothyparkinson.com> wrote:
> > > * Running with SpeedStep (this is a cpu thing i assume?) could cause
> > > this. * Not having DMA enabled on your hard disk(s) could cause this. 
> > > See the hdparm utility to enable it.
> > > * Incorrect TSC synchronization on SMP systems could cause this.
> > > * Anything else?
> >
> > Yepp:
> >
> > Jan 27 20:12:12 tatooine kernel: Losing too many ticks!
> >
> > I had to set "CONFIG_IDE_TASK_IOCTL=y" in my .config in order to get
> > it working.
> 
> How's that possible?
> This config option only exports HDIO_DRIVE_TASKFILE ioctl to user-space.
> 
> --bart
> 

without that, "hdparm -d1 /dev/hda" would claim that dma wasn't supported on my
harddrive.

i'm positive it's the only variable, i didn't change anything else!

timothy
