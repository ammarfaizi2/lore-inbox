Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932264AbWCaUDH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932264AbWCaUDH (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 31 Mar 2006 15:03:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932265AbWCaUDH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 31 Mar 2006 15:03:07 -0500
Received: from 66.239.25.20.ptr.us.xo.net ([66.239.25.20]:22939 "EHLO
	zoot.lnxi.com") by vger.kernel.org with ESMTP id S932264AbWCaUDG convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 31 Mar 2006 15:03:06 -0500
Message-Id: <442D264A0200003600003289@zoot.lnxi.com>
X-Mailer: Novell GroupWise Internet Agent 7.0.1 Beta 
Date: Fri, 31 Mar 2006 12:53:30 -0700
From: "Doug Thompson" <dthompson@lnxi.com>
To: <dsp@llnl.gov>
Cc: <gtm.kramer@inter.nl.net>, <bluesmoke-devel@lists.sourceforge.net>,
       <linux-kernel@vger.kernel.org>
Subject: Re: Non-Fatal Error PCI Express messages
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2006-03-31 at 18:22 +0000, Dave Peterson  wrote:
> On Friday 31 March 2006 00:25, Jurgen Kramer wrote:
> > With 2.6.16 (from FC5s 2.6.16-1.2080_FC5smp) I am getting a lot of
> >
> > Mar 31 09:35:16 paragon kernel: Non-Fatal Error PCI Express B
> > Mar 31 09:35:17 paragon kernel: Non-Fatal Error PCI Express B
> > Mar 31 09:35:17 paragon kernel: Non-Fatal Error PCI Express B
> > Mar 31 09:35:18 paragon kernel: Non-Fatal Error PCI Express B
> > Mar 31 09:35:18 paragon kernel: Non-Fatal Error PCI Express B
> > Mar 31 09:35:20 paragon kernel: Non-Fatal Error PCI Express B
> > Mar 31 09:35:20 paragon kernel: Non-Fatal Error PCI Express B
> > Mar 31 09:35:39 paragon kernel: Non-Fatal Error PCI Express B
> >
> > messages which presumably come from
> >
> > Mar 31 09:17:15 paragon kernel: MC: drivers/edac/edac_mc.c version
> > edac_mc  Ver: 2.0.0 Mar 28 2006
> > Mar 31 09:17:15 paragon kernel: EDAC MC0: Giving out device to
> > "e752x_edac" E7525: PCI 0000:00:00.0
> >
> > Is there really something broken here of just a noisy driver?
> >
> > BTW this is on a Asus NCT-D mobo with Intel E7525 chipset.
> >
> > Jurgen
> 
> Hi Jurgen,
> 
> I haven't seen this particular error before, and I can't say for sure
> whether it's a genuine problem that should be dealt with or just a
> minor annoyance that can be safely ignored.  EDAC is a relatively new
> piece of code, and still very much a work in progress.  If this is in
> fact a benign type of error, EDAC should provide a mechanism by which
> a sysadmin can silence it.  This is an area of future work.
> 
> I'm forwarding your message to the bluesmoke mailing list just in
> case anyone who reads that list has seen instances of this error in
> the past and can provide more info on it.
> 
> Dave

It is benign, just too verbose. It needs to be silenced.

The code takes the error status from the chip. That status can contain
true BAD errors and non-fatal status. The code is generic in nature and
does not special case the non-fatal error status.

this does need looking into.

doug t


