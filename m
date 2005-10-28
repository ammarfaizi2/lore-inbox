Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030218AbVJ1Pv0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030218AbVJ1Pv0 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 28 Oct 2005 11:51:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030221AbVJ1Pv0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 28 Oct 2005 11:51:26 -0400
Received: from mail.kroah.org ([69.55.234.183]:4315 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S1030218AbVJ1PvZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 28 Oct 2005 11:51:25 -0400
Date: Fri, 28 Oct 2005 08:50:44 -0700
From: Greg KH <greg@kroah.com>
To: Andrew Morton <akpm@osdl.org>
Cc: gregkh@suse.de, linux-kernel@vger.kernel.org, david-b@pacbell.net,
       Linus Torvalds <torvalds@osdl.org>
Subject: Re: [PATCH] pci device wakeup flags
Message-ID: <20051028155044.GA11924@kroah.com>
References: <11304810221338@kroah.com> <11304810223093@kroah.com> <20051028035116.112ba2ca.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051028035116.112ba2ca.akpm@osdl.org>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 28, 2005 at 03:51:16AM -0700, Andrew Morton wrote:
> Greg KH <gregkh@suse.de> wrote:
> >
> >  [PATCH] pci device wakeup flags
> > 
> >  This patch teaches "pci_dev" about the new driver model wakeup support:
> > 
> >   - It marks devices as supporting wakeup when "can issue PME#" is
> >     listed in its PCI PM capability.
> > 
> >   - pci_enable_wake() refuses to enable wake if that's been disabled
> >     (e.g. through sysfs).
> > 
> >  NOTE that a recent patch changed PCI probing, and this reverts part
> >  of that change ... so that driver model initialization is again done
> >  before the PCI setup.
> > 
> >  (One issue is that the driver model "init + add == register" pattern isn't
> >  being used inside PCI ...  and that probe change worsened the problem by
> >  making "add" do some "init" too.  Maybe PCI should match the driver model
> >  more closely, and just grow a new "pci_dev_init" function.)
> 
> This is the patch which I've been religiously dropping from -mm because it
> kills my Mac G5.  What are we doing merging this?

Crap, sorry about that.  I've deleted my tree and will rebuild it.  I
thought that it was one of the usb patches in my tree that was causing
you problems.  I'll not include this one until we get to the bottom of
it (and with David gone, that might take a while.)

Again, very sorry about this.

Oh, and I'll also drop the one from Randy with the gfp flags, and
properly attribute Russell's patch.

thanks,

greg k-h
