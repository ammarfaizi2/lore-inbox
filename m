Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268132AbUIPSV7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268132AbUIPSV7 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Sep 2004 14:21:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268113AbUIPSTQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Sep 2004 14:19:16 -0400
Received: from twilight.ucw.cz ([81.30.235.3]:16276 "EHLO ucw.cz")
	by vger.kernel.org with ESMTP id S268161AbUIPSRb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Sep 2004 14:17:31 -0400
Date: Thu, 16 Sep 2004 20:17:08 +0200
From: Vojtech Pavlik <vojtech@suse.cz>
To: Bjorn Helgaas <bjorn.helgaas@hp.com>
Cc: Christoph Lameter <clameter@sgi.com>, linux-kernel@vger.kernel.org,
       Jesse Barnes <jbarnes@engr.sgi.com>, Bob Picco <Robert.Picco@hp.com>,
       venkatesh.pallipadi@intel.com
Subject: Re: device driver for the SGI system clock, mmtimer
Message-ID: <20040916181708.GB5052@ucw.cz>
References: <200409161003.39258.bjorn.helgaas@hp.com> <Pine.LNX.4.58.0409160930300.6765@schroedinger.engr.sgi.com> <200409161054.51467.bjorn.helgaas@hp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200409161054.51467.bjorn.helgaas@hp.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 16, 2004 at 10:54:51AM -0600, Bjorn Helgaas wrote:
> On Thursday 16 September 2004 10:32 am, Christoph Lameter wrote:
> > On Thu, 16 Sep 2004, Bjorn Helgaas wrote:
> > > Christoph Lameter wrote:
> > > > The timer hardware was designed around the multimedia timer specification by Intel
> > > > but to my knowledge only SGI has implemented that standard. The driver was written
> > > > by Jesse Barnes.
> > >
> > > As far as I can see, drivers/char/hpet.c talks to the same hardware.
> > > HP sx1000 machines (and probably others) also implement the HPET.
> > 
> > The Intel Multimedia Standard is a earlier and different timer spec.
> 
> I have a spec that's labelled "IA-PC Multimedia Timers", preliminary
> draft of June 2000, revision 0.97, which looks like the one mentioned
> in your patch.
> 
> I also have something labelled "IA-PC HPET (High Precision Event
> Timers) Specification", draft of February 2002, revision 0.98,
> which is what drivers/char/hpet.c supports.
> 
> I admit I haven't compared them in great detail, but they certainly
> *look* like they're close enough that the same driver could support
> both, and the 0.98 revision history only mentions fairly cosmetic
> changes (like the name :)).

Indeed, I coded the x86-64 HPET support using the 0.97 spec, and then
only did a few minor fixups when I got the 0.98 spec.

> Is there something specific that drivers/char/hpet.c expects that
> your hardware doesn't implement?

> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/

-- 
Vojtech Pavlik
SuSE Labs, SuSE CR
