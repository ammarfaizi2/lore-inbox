Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751507AbWHRWDO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751507AbWHRWDO (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Aug 2006 18:03:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751509AbWHRWDO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Aug 2006 18:03:14 -0400
Received: from smtp-105-friday.nerim.net ([62.4.16.105]:16902 "EHLO
	kraid.nerim.net") by vger.kernel.org with ESMTP id S1751507AbWHRWDM
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Aug 2006 18:03:12 -0400
Date: Sat, 19 Aug 2006 00:03:17 +0200
From: Jean Delvare <khali@linux-fr.org>
To: Daniel Ritz <daniel.ritz-ml@swissonline.ch>, Greg KH <gregkh@suse.de>
Cc: Andrew Morton <akpm@osdl.org>,
       "linux-kernel" <linux-kernel@vger.kernel.org>,
       "linux-pci" <linux-pci@atrey.karlin.mff.cuni.cz>
Subject: Re: [PATCH] PCI: fix ICH6 quirks
Message-Id: <20060819000317.198c3c54.khali@linux-fr.org>
In-Reply-To: <200608181921.31798.daniel.ritz-ml@swissonline.ch>
References: <200608181650.41869.daniel.ritz-ml@swissonline.ch>
	<20060818185743.d16d2a98.khali@linux-fr.org>
	<200608181921.31798.daniel.ritz-ml@swissonline.ch>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.6.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> On Friday 18 August 2006 18.57, Jean Delvare wrote:
> > Hi Daniel,
> > 
> > > [PATCH] PCI: fix ICH6 quirks
> > > 
> > > - add the ICH6(R) LPC to the ICH6 ACPI quirks. currently only the ICH6-M is
> > >   handled. [ PCI_DEVICE_ID_INTEL_ICH6_1 is the ICH6-M LPC, ICH6_0 is the ICH6(R) ]
> > 
> > No objection.
> > 
> > > - remove the wrong quirk calling asus_hides_smbus_lpc() for ICH6. the register
> > >   modified in asus_hides_smbus_lpc() has a different meaning in ICH6.
> > 
> > My mistake :( Thanks for fixing it. Do you know if executing the old
> > quirk on the ICH6 can cause trouble? In other words, should we backport
> > this fix to 2.6.17.y?
> 
> the register it touches is part of the "root complex base address" register. so
> changing it means the ICH6 decodes a different address range that could conflict
> with something else...so yes, i think this is a 2.6.17.x candidate.

OK, this also means that we want your patch in 2.6.18. Greg, can you
pick it quickly?

Thanks,
-- 
Jean Delvare
