Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261552AbVFMWW5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261552AbVFMWW5 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Jun 2005 18:22:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261533AbVFMWTA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Jun 2005 18:19:00 -0400
Received: from lyle.provo.novell.com ([137.65.81.174]:19225 "EHLO
	lyle.provo.novell.com") by vger.kernel.org with ESMTP
	id S261530AbVFMWRo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Jun 2005 18:17:44 -0400
Date: Mon, 13 Jun 2005 15:17:36 -0700
From: Greg KH <gregkh@suse.de>
To: Dmitry Torokhov <dtor_core@ameritech.net>
Cc: linux-hotplug-devel@lists.sourceforge.net,
       Kay Sievers <kay.sievers@vrfy.org>, Vojtech Pavlik <vojtech@suse.cz>,
       LKML <linux-kernel@vger.kernel.org>, Hannes Reinecke <hare@suse.de>
Subject: Re: Input sysbsystema and hotplug
Message-ID: <20050613221736.GC15381@suse.de>
References: <200506131607.51736.dtor_core@ameritech.net> <20050613212654.GB11182@vrfy.org> <200506131638.09140.dtor_core@ameritech.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200506131638.09140.dtor_core@ameritech.net>
User-Agent: Mutt/1.5.8i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 13, 2005 at 04:38:08PM -0500, Dmitry Torokhov wrote:
> On Monday 13 June 2005 16:26, Kay Sievers wrote:
> > On Mon, Jun 13, 2005 at 04:07:51PM -0500, Dmitry Torokhov wrote:
> > > 
> > > where inputX are class devices, mouse and event are subclasses of input
> > > class and mouseX and eventX are again class devices.
> > 
> > We don't support childs of class devices until now. Would be nice maybe, but
> > someone needs to add that to the driver-core first and we would need to make
> > a bunch of userspace stuff aware of it ...
> > 
> 
> Something like patch below will suffice I think (not tested).

No, you need to increment the parent when you register the child.  Look
at the device code for what's needed for this.

thanks,

greg k-h
