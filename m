Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268501AbUIPQ7v@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268501AbUIPQ7v (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Sep 2004 12:59:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268368AbUIPQzk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Sep 2004 12:55:40 -0400
Received: from atlrel7.hp.com ([156.153.255.213]:13761 "EHLO atlrel7.hp.com")
	by vger.kernel.org with ESMTP id S268490AbUIPQzG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Sep 2004 12:55:06 -0400
From: Bjorn Helgaas <bjorn.helgaas@hp.com>
To: Christoph Lameter <clameter@sgi.com>
Subject: Re: device driver for the SGI system clock, mmtimer
Date: Thu, 16 Sep 2004 10:54:51 -0600
User-Agent: KMail/1.6.2
Cc: linux-kernel@vger.kernel.org, Jesse Barnes <jbarnes@engr.sgi.com>,
       Bob Picco <Robert.Picco@hp.com>, venkatesh.pallipadi@intel.com
References: <200409161003.39258.bjorn.helgaas@hp.com> <Pine.LNX.4.58.0409160930300.6765@schroedinger.engr.sgi.com>
In-Reply-To: <Pine.LNX.4.58.0409160930300.6765@schroedinger.engr.sgi.com>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200409161054.51467.bjorn.helgaas@hp.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 16 September 2004 10:32 am, Christoph Lameter wrote:
> On Thu, 16 Sep 2004, Bjorn Helgaas wrote:
> > Christoph Lameter wrote:
> > > The timer hardware was designed around the multimedia timer specification by Intel
> > > but to my knowledge only SGI has implemented that standard. The driver was written
> > > by Jesse Barnes.
> >
> > As far as I can see, drivers/char/hpet.c talks to the same hardware.
> > HP sx1000 machines (and probably others) also implement the HPET.
> 
> The Intel Multimedia Standard is a earlier and different timer spec.

I have a spec that's labelled "IA-PC Multimedia Timers", preliminary
draft of June 2000, revision 0.97, which looks like the one mentioned
in your patch.

I also have something labelled "IA-PC HPET (High Precision Event
Timers) Specification", draft of February 2002, revision 0.98,
which is what drivers/char/hpet.c supports.

I admit I haven't compared them in great detail, but they certainly
*look* like they're close enough that the same driver could support
both, and the 0.98 revision history only mentions fairly cosmetic
changes (like the name :)).

Is there something specific that drivers/char/hpet.c expects that
your hardware doesn't implement?
