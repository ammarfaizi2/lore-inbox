Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964824AbVLFSDV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964824AbVLFSDV (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 Dec 2005 13:03:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964998AbVLFSCx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 Dec 2005 13:02:53 -0500
Received: from mail.kroah.org ([69.55.234.183]:1261 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S964824AbVLFSCZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 Dec 2005 13:02:25 -0500
Date: Tue, 6 Dec 2005 09:50:17 -0800
From: Greg KH <greg@kroah.com>
To: Adrian Bunk <bunk@stusta.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: RFC: Starting a stable kernel series off the 2.6 kernel
Message-ID: <20051206175017.GF3084@kroah.com>
References: <20051203135608.GJ31395@stusta.de> <9a8748490512030629t16d0b9ebv279064245743e001@mail.gmail.com> <20051203201945.GA4182@kroah.com> <9a8748490512031948m26b04d3ds9fbc652893ead40@mail.gmail.com> <20051204115650.GA15577@merlin.emma.line.org> <20051204232454.GG8914@kroah.com> <20051205185110.GJ9973@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051205185110.GJ9973@stusta.de>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 05, 2005 at 07:51:10PM +0100, Adrian Bunk wrote:
> On Sun, Dec 04, 2005 at 03:24:54PM -0800, Greg KH wrote:
> > On Sun, Dec 04, 2005 at 12:56:50PM +0100, Matthias Andree wrote:
> > > The problem is the upstream breaking backwards compatibility for no good
> > > reason. This can sometimes be a genuine unintended regression (aka.
> > > bug), but quite often this is deliberate breakage because someone wants
> > > to get rid of cruft. While the motivation is sound, breaking between
> > > 2.6.N and 2.6.M must stop.
> > 
> > What are we breaking that people are complaining so much about?
> > Specifics please.
> > 
> > And if you bring up udev, please see my previous comments in this thread
> > about that issue.
> > 
> > It isn't userspace stuff that is breaking, as applications built on 2.2
> > still work just fine here on 2.6 for me.
> > 
> > Yes we break in-kernel apis, all the time, that's fine.  See
> > Documentation/stable-api-nonsense.txt for details about why we do that.
> > 
> > So again, specifics please?
> 
> It's the kernel-related userspace that is the problem (besides
> regressions that are simply bugs).

Again, specifics please?

> Be it the devfs removal, the requirement for a more recent
> wpa_supplicant package or my pending removal of the obsolete raw
> driver.

devfs was documented for over a year that it would be removed.  This
after 2 year notice that it was going to be removed some time in the
future.  So for over 3 years people have known about this.

You have also notified people about the raw driver going away, what more
can we do about this?

And there will always be a need for new package upgrades for some small
subset of programs that are tightly tied to the kernel (like
wpa_supplicant or alsa-libs, or even udev).  But "normal" userspace
applicatations should not break, and if they do, we want to know about
it so we can fix it.

thanks,

greg k-h
