Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261547AbULUHMq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261547AbULUHMq (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Dec 2004 02:12:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261541AbULUHMq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Dec 2004 02:12:46 -0500
Received: from gate.crashing.org ([63.228.1.57]:30383 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S261547AbULUHMg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Dec 2004 02:12:36 -0500
Subject: Re: [PATCH] add PCI API to sysfs
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Jesse Barnes <jbarnes@engr.sgi.com>
Cc: linux-pci@atrey.karlin.mff.cuni.cz, Greg KH <greg@kroah.com>,
       Linux Kernel list <linux-kernel@vger.kernel.org>,
       Bjorn Helgaas <bjorn.helgaas@hp.com>, willy@debian.org
In-Reply-To: <200412201501.12575.jbarnes@engr.sgi.com>
References: <200412201450.47952.jbarnes@engr.sgi.com>
	 <20041220225817.GA21404@kroah.com>
	 <200412201501.12575.jbarnes@engr.sgi.com>
Content-Type: text/plain
Date: Tue, 21 Dec 2004 08:12:01 +0100
Message-Id: <1103613121.21771.28.camel@gaston>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.2 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> Yeah, I mentioned that in "things to do" at the bottom, but I'm really looking 
> for an "ack, this is a sane way to go" before I sink much more time into it.

Overall, I like it, though I yet have to scrub the details. As far as
the legacy space is concerned, I'd be as "generic" as possible and thus
provide the legacy-files on a per-bus basis. That is each pci bus could
expose those even if it's not a host bridge. It's an arch matter to
actually implement them, and by default, I suppose archs would just
treat all busses of a domain the same, but it leaves us with the
necessary flexibility for setups with bridges that can remap the legacy
space or that kind of thing.

Great work !

Ben.


