Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261653AbVDEJXP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261653AbVDEJXP (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Apr 2005 05:23:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261652AbVDEJXN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Apr 2005 05:23:13 -0400
Received: from coyote.holtmann.net ([217.160.111.169]:43666 "EHLO
	mail.holtmann.net") by vger.kernel.org with ESMTP id S261649AbVDEJWo
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Apr 2005 05:22:44 -0400
Subject: Re: [PATCH 00/04] Load keyspan firmware with hotplug
From: Marcel Holtmann <marcel@holtmann.org>
To: Dmitry Torokhov <dtor_core@ameritech.net>
Cc: Jan Harkes <jaharkes@cs.cmu.edu>, Greg KH <greg@kroah.com>,
       Sven Luther <sven.luther@wanadoo.fr>,
       Michael Poole <mdpoole@troilus.org>, debian-legal@lists.debian.org,
       debian-kernel@lists.debian.org,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <200504042351.22099.dtor_core@ameritech.net>
References: <20050404100929.GA23921@pegasos>
	 <20050404191745.GB12141@kroah.com>
	 <20050405042329.GA10171@delft.aura.cs.cmu.edu>
	 <200504042351.22099.dtor_core@ameritech.net>
Content-Type: text/plain
Date: Tue, 05 Apr 2005 11:22:06 +0200
Message-Id: <1112692926.8263.125.camel@pegasus>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jan,

> > > > Mmm, probably that 2001 discussion about the keyspan firmware, right ?
> > > > 
> > > >   http://lists.debian.org/debian-legal/2001/04/msg00145.html
> > > > 
> > > > Can you summarize the conclusion of the thread, or what you did get from it,
> > > > please ? 
> > > 
> > > That people didn't like the inclusion of firmware, I posted how you can
> > > fix it by moving it outside of the kernel, and asked for patches.
> > > 
> > > None have come.
> > 
> > Didn't know you were waiting for it. How about something like the
> > following series of patches?
> > 
> > [01/04] - add simple Intel IHEX format parser to the firmware loader.
> 
> Firmware loader is format-agnostic, I think having IHEX parser in a separate
> file would be better...

I agree with Dmitry on this point. The IHEX parser should not be inside
firmware_class.c. What about using keyspan_ihex.[ch] for it?

Regards

Marcel


