Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268012AbTCFLss>; Thu, 6 Mar 2003 06:48:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268013AbTCFLss>; Thu, 6 Mar 2003 06:48:48 -0500
Received: from k7g317-2.kam.afb.lu.se ([130.235.57.218]:50058 "EHLO
	cheetah.psv.nu") by vger.kernel.org with ESMTP id <S268012AbTCFLsr>;
	Thu, 6 Mar 2003 06:48:47 -0500
Date: Wed, 5 Mar 2003 07:49:23 +0100 (CET)
From: Peter Svensson <petersv@psv.nu>
To: Eric Lammerts <eric@lammerts.org>
cc: Uwe Reimann <linux-kernel@pulsar.homelinux.net>,
       <linux-kernel@vger.kernel.org>
Subject: Re: Direct access to parport
In-Reply-To: <Pine.LNX.4.52.0303042329450.18334@ally.lammerts.org>
Message-ID: <Pine.LNX.4.44.0303050746220.16313-100000@cheetah.psv.nu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 4 Mar 2003, Eric Lammerts wrote:

> On Tue, 4 Mar 2003, Uwe Reimann wrote:
> > I'd like to connect some self made hardware to the parallel port and
> > read the values of the dataline using linux. Can this be done in
> > userspace or do I have to write kernel code to do so? I'm currently
> > thinking of writing a device like lp, which in turn uses the parport
> > device. Does this sound like a good idea?
> 
> >From userspace it's quite simple:

[ioperm-based suggestion removed]

A better idea may be to use ppdev - the portable and safe way to access a 
paralell port directly. This driver is in the stock kernels. This prevents 
races between the kernel and userland over control for the paralell port.

Peter
--
Peter Svensson      ! Pgp key available by finger, fingerprint:
<petersv@psv.nu>    ! 8A E9 20 98 C1 FF 43 E3  07 FD B9 0A 80 72 70 AF
------------------------------------------------------------------------
Remember, Luke, your source will be with you... always...


