Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266155AbUGTTiy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266155AbUGTTiy (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 Jul 2004 15:38:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266175AbUGTTND
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 Jul 2004 15:13:03 -0400
Received: from gate.crashing.org ([63.228.1.57]:54949 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S266186AbUGTTM1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 Jul 2004 15:12:27 -0400
Subject: Re: device_suspend() levels [was Re: [patch] ACPI work on aic7xxx]
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Nathan Bryant <nbryant@optonline.net>
Cc: Pavel Machek <pavel@suse.cz>, linux-scsi@vger.kernel.org,
       random1@o-o.yi.org, Luben Tuikov <luben_tuikov@adaptec.com>,
       Linux Kernel list <linux-kernel@vger.kernel.org>
In-Reply-To: <40FD65C2.7060408@optonline.net>
References: <40FD38A0.3000603@optonline.net>
	 <20040720155928.GC10921@atrey.karlin.mff.cuni.cz>
	 <40FD4CFA.6070603@optonline.net>
	 <20040720174611.GI10921@atrey.karlin.mff.cuni.cz>
	 <40FD6002.4070206@optonline.net> <1090347939.1993.7.camel@gaston>
	 <40FD65C2.7060408@optonline.net>
Content-Type: text/plain
Message-Id: <1090350609.2003.9.camel@gaston>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Tue, 20 Jul 2004 15:10:10 -0400
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2004-07-20 at 14:34, Nathan Bryant wrote:
> Benjamin Herrenschmidt wrote:
> 
> > 2 comments here:
> > 
> >  - The low level bus state (PCI D state for example) and the "linux"
> > state should be 2 different entities.
> > 
> >  - For PCI, we probably want a hook so the arch can implement it's own
> > version of pci_set_power_state() so that ACPI can use it's own trickery
> > there.
> 
> Ok, so the takeaway message for driver writers is to treat the 
> pci_dev->suspend() state parameter as an opaque value as far as 
> possible, and just pass it on to the other layers

NO ! The exact opposite in fact. I'll work on cleaning that up and
write some doco this week with Pavel.

Ben.


