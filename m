Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262350AbVF2BAU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262350AbVF2BAU (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Jun 2005 21:00:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262336AbVF2A6k
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Jun 2005 20:58:40 -0400
Received: from gate.crashing.org ([63.228.1.57]:7839 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S262332AbVF1X71 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Jun 2005 19:59:27 -0400
Subject: Re: [PATCH] ppc/ppc64: Fix pci mmap via sysfs
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Greg KH <greg@kroah.com>
Cc: Andrew Morton <akpm@osdl.org>,
       Linux Kernel list <linux-kernel@vger.kernel.org>,
       linux-pci <linux-pci@atrey.karlin.mff.cuni.cz>,
       linuxppc64-dev <linuxppc64-dev@ozlabs.org>
In-Reply-To: <20050628075140.GF3577@kroah.com>
References: <1119836190.5133.59.camel@gaston>
	 <20050626185727.0ce92772.akpm@osdl.org> <1119838264.5133.76.camel@gaston>
	 <20050628075140.GF3577@kroah.com>
Content-Type: text/plain
Date: Wed, 29 Jun 2005 09:53:59 +1000
Message-Id: <1120002840.5133.216.camel@gaston>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.2 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> > This implement the change to /proc and sysfs PCI mmap functions that we
> > discussed a while ago, that is adding an arch optional
> > pci_resource_to_user() to allow munging on the exposed value of PCI
> > resources to userland and thus hiding kernel internal values. It also
> > implements using of that callback to sanitize exposed values on ppc an
> > ppc64, thus fixing mmap of PCI devices via /proc and sysfs.
> 
> Hm, did I just send the right one to Linus?

I'll check & send any additional fix that may be necessary (I just got
noticed that it breaks iSeries ... :)

Ben.


