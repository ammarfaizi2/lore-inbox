Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268236AbUIPUgi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268236AbUIPUgi (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Sep 2004 16:36:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268257AbUIPUgh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Sep 2004 16:36:37 -0400
Received: from twilight.ucw.cz ([81.30.235.3]:35732 "EHLO ucw.cz")
	by vger.kernel.org with ESMTP id S268236AbUIPUfL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Sep 2004 16:35:11 -0400
Date: Thu, 16 Sep 2004 22:34:51 +0200
From: Vojtech Pavlik <vojtech@suse.cz>
To: Jesse Barnes <jbarnes@engr.sgi.com>
Cc: Bjorn Helgaas <bjorn.helgaas@hp.com>, Christoph Lameter <clameter@sgi.com>,
       linux-kernel@vger.kernel.org, Bob Picco <Robert.Picco@hp.com>,
       venkatesh.pallipadi@intel.com
Subject: Re: device driver for the SGI system clock, mmtimer
Message-ID: <20040916203451.GA5260@ucw.cz>
References: <200409161003.39258.bjorn.helgaas@hp.com> <200409160909.12840.jbarnes@engr.sgi.com> <20040916181426.GA5052@ucw.cz> <200409161135.52987.jbarnes@engr.sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200409161135.52987.jbarnes@engr.sgi.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 16, 2004 at 11:35:52AM -0700, Jesse Barnes wrote:
> On Thursday, September 16, 2004 11:14 am, Vojtech Pavlik wrote:
> > On Thu, Sep 16, 2004 at 09:09:12AM -0700, Jesse Barnes wrote:
> > > On Thursday, September 16, 2004 9:03 am, Bjorn Helgaas wrote:
> > > > Christoph Lameter wrote:
> > > > > The timer hardware was designed around the multimedia timer
> > > > > specification by Intel but to my knowledge only SGI has implemented
> > > > > that standard. The driver was written by Jesse Barnes.
> > > >
> > > > As far as I can see, drivers/char/hpet.c talks to the same hardware.
> > > > HP sx1000 machines (and probably others) also implement the HPET.
> > >
> > > No, it's different hardware.
> >
> > mmtimer and hpet are the same hardware actually, just a different
> > specification revision, hpet being the newer one.
> 
> Well, the SHub RTC hardware (which mmtimer accesses) isn't really HPET or 
> mmtimer hardware, but I tried to make the mmtimer *API* useful for HPET style 
> hardware.  The idea was to have several drivers supporting the mmtimer API 
> with different hardware underneath.

Sorry, I got confused by the driver name.

> > HPET registers are MMIO so it's in theory possible, while not really
> > useful if you're using it as your system timer as well.
> 
> I don't think anyone does this.

x86-64 does if SMP is enabled and HPET is present.

-- 
Vojtech Pavlik
SuSE Labs, SuSE CR
