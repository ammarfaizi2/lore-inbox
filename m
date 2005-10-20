Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751665AbVJTAdn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751665AbVJTAdn (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 19 Oct 2005 20:33:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751667AbVJTAdn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 19 Oct 2005 20:33:43 -0400
Received: from mail.kroah.org ([69.55.234.183]:48579 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S1751663AbVJTAdn (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 19 Oct 2005 20:33:43 -0400
Date: Wed, 19 Oct 2005 17:06:14 -0700
From: Greg KH <greg@kroah.com>
To: Jesse Barnes <jbarnes@plato.virtuousgeek.org>
Cc: Jesse Barnes <jbarnes@virtuousgeek.org>,
       Stefan Richter <stefanr@s5r6.in-berlin.de>,
       linux1394-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org,
       linux-pci@atrey.karlin.mff.cuni.cz, gregkh@suse.de
Subject: Re: new PCI quirk for Toshiba Satellite?
Message-ID: <20051020000614.GI18295@kroah.com>
References: <20051015185502.GA9940@plato.virtuousgeek.org> <43515ADA.6050102@s5r6.in-berlin.de> <20051015202944.GA10463@plato.virtuousgeek.org> <20051015204040.GA10537@plato.virtuousgeek.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051015204040.GA10537@plato.virtuousgeek.org>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Oct 15, 2005 at 01:40:40PM -0700, Jesse Barnes wrote:
> On Sat, Oct 15, 2005 at 01:29:44PM -0700, Jesse Barnes wrote:
> > On Sat, Oct 15, 2005 at 09:39:06PM +0200, Stefan Richter wrote:
> > > Somebody mentioned this Linux-on-Toshiba-Satellite page recently on 
> > > linux1394-user: http://www.janerob.com/rob/ts5100/index.shtml
> > > The patch available from there was briefly discussed in February:
> > > http://marc.theaimsgroup.com/?l=linux1394-devel&t=110786507900006
> > > 
> > > Does this patch correct the problem on your machine?
> > 
> > Yes, it seems to help.  If I boot up and modprobe the driver with
> > toshiba=1, everything looks fine (I have no firewire devices to test
> > with).  If I modprobe it with toshiba=0, the system gets sluggish for a
> > second then IRQ 11 is disabled.  I had to update the patch though, as
> > shown below.
> > 
> > I'm not sure if the fix is proper though, maybe this should be handled
> > as a PCI quirk of this Toshiba board instead?  Either way, some kind of
> > fix should make it in soon, ideally to 2.6.14 or 2.6.14.1.
> 
> [Forwarding on to the PCI maintainers.]
> 
> It seems that the PCI config space isn't programmed correctly on these
> machines for some reason, so the fix below allows my OHCI device to work
> if I pass 'toshiba=1'.  This seems like something that belongs in the
> PCI layer instead though, doesn't it?

Yes, looks like it should be a pci quirk instead.

thanks,

greg k-h
