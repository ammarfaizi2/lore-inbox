Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263539AbUBNXDa (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 14 Feb 2004 18:03:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263544AbUBNXDa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 14 Feb 2004 18:03:30 -0500
Received: from sccrmhc13.comcast.net ([204.127.202.64]:18425 "EHLO
	sccrmhc13.comcast.net") by vger.kernel.org with ESMTP
	id S263539AbUBNXD1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 14 Feb 2004 18:03:27 -0500
Date: Sat, 14 Feb 2004 18:03:26 -0500
From: Willem Riede <wrlk@riede.org>
To: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
Cc: Patrick Mansfield <patmans@us.ibm.com>,
       Mikael Pettersson <mikpe@csd.uu.se>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Selective attach for ide-scsi
Message-ID: <20040214230326.GK4957@serve.riede.org>
Reply-To: wrlk@riede.org
References: <20040208224248.GA28026@serve.riede.org> <20040211121120.A24289@beaverton.ibm.com> <20040214220647.GE4957@serve.riede.org> <200402142354.41169.bzolnier@elka.pw.edu.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: 7BIT
In-Reply-To: <200402142354.41169.bzolnier@elka.pw.edu.pl> (from B.Zolnierkiewicz@elka.pw.edu.pl on Sat, Feb 14, 2004 at 17:54:41 -0500)
X-Mailer: Balsa 2.0.16
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 2004.02.14 17:54, Bartlomiej Zolnierkiewicz wrote:
> >
> > The main reason I see for sticking with the hdX= construct is that I think
> > that introducing competing mechanisms that achieve much the same objective
> > is a bad thing.
> 
> $ echo ide-scsi>/proc/ide/hdX/driver
> or
> $ echo "ide-scsi:1">/proc/ide/hdX/settings
> or
> use HDIO_SET_IDE_SCSI ioctl
> 
> and you can change driver from ide-{cd,floppy,tape} to ide-scsi in-fly.
> You can also use it in reverse direction (ie. from ide-scsi to ide-cd).
> 
> What more crap do you need?  There is already one /proc setting too much.

Nothing.

I was actually arguing that we _don't_ need a new mechanism. And, given
that there is a /proc entry to change it (which I didn't realize), there
is no downside to the current mechanism.

Thanks, Willem Riede.
