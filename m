Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262836AbUJ1Ivi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262836AbUJ1Ivi (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 28 Oct 2004 04:51:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262832AbUJ1Ivh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Oct 2004 04:51:37 -0400
Received: from digitalimplant.org ([64.62.235.95]:22972 "HELO
	digitalimplant.org") by vger.kernel.org with SMTP id S262833AbUJ1Iuw
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Oct 2004 04:50:52 -0400
Date: Thu, 28 Oct 2004 01:50:48 -0700 (PDT)
From: Patrick Mochel <mochel@digitalimplant.org>
X-X-Sender: mochel@monsoon.he.net
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
cc: Jeff Garzik <jgarzik@pobox.com>,
       Linux-pm mailing list <linux-pm@lists.osdl.org>,
       Linux Kernel list <linux-kernel@vger.kernel.org>
Subject: Re: [linux-pm] Re: Concerns about our pci_{save,restore}_state()
In-Reply-To: <1098685464.26695.32.camel@gaston>
Message-ID: <Pine.LNX.4.50.0410280149140.13935-100000@monsoon.he.net>
References: <1098677182.26697.21.camel@gaston>  <417C991C.2070806@pobox.com>
 <1098685464.26695.32.camel@gaston>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Mon, 25 Oct 2004, Benjamin Herrenschmidt wrote:

> On Mon, 2004-10-25 at 02:11 -0400, Jeff Garzik wrote:

> > This is _clearly_ something that should be decided upon in the driver.
> > The PCI layer should _only_ present standard helper functions, and maybe
> > a standard storage space that works for most drivers; not force all
> > drivers through a narrow funnel.
>
> Agreed. However, my concern is to have some "default" stuff that will
> take over in absence of a driver. This is, I think, important for things
> like P2P bridges which are rather standard and will usually survive well
> with a simple save/retore of whatever is there. I suppose it would be
> interesting to define a pair of quirk types to hook on the "default"
> implementation, unless we actually want to have a bunch of pci_driver's
> just for things that don't have normally a driver but need some specific
> save/restore procedure ...

What's wrong with that? They would be simple and straightforward, and
could probably work to remove many of the quirks, too..


	Pat

