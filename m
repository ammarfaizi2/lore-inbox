Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262061AbVCAUuM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262061AbVCAUuM (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Mar 2005 15:50:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262059AbVCAUrp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Mar 2005 15:47:45 -0500
Received: from fire.osdl.org ([65.172.181.4]:39109 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S262054AbVCAUnC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Mar 2005 15:43:02 -0500
Date: Tue, 1 Mar 2005 12:42:11 -0800
From: Andrew Morton <akpm@osdl.org>
To: Russell King <rmk+lkml@arm.linux.org.uk>
Cc: Valdis.Kletnieks@vt.edu, greg@kroah.com, linux-kernel@vger.kernel.org
Subject: Re: 2.6.11-rc5-mm1
Message-Id: <20050301124211.01375439.akpm@osdl.org>
In-Reply-To: <20050301152735.B1940@flint.arm.linux.org.uk>
References: <20050301012741.1d791cd2.akpm@osdl.org>
	<200503011336.j21DaaqC008164@turing-police.cc.vt.edu>
	<20050301135529.A1940@flint.arm.linux.org.uk>
	<200503011518.j21FIuQl004840@turing-police.cc.vt.edu>
	<20050301152735.B1940@flint.arm.linux.org.uk>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Russell King <rmk+lkml@arm.linux.org.uk> wrote:
>
> On Tue, Mar 01, 2005 at 10:18:56AM -0500, Valdis.Kletnieks@vt.edu wrote:
> > On Tue, 01 Mar 2005 13:55:29 GMT, Russell King said:
> > > The PCI updates change the prototype of a helper function for 
> > > pci_bus_alloc_resource(), but don't touch the actual helper function
> > > in PCMCIA.
> > 
> > That explains the warning messages that gcc was tossing, which I suspected was
> > involved...
> > 
> > > This means that the PCI update is actually broken - if it's merged as
> > > is into Linus' tree, PCMCIA will break there as well.
> > 
> > Is the patch made to PCI actually incorrect, or is the proper way to do this
> > to propagate the changes into the relevant PCMCIA code?
> 
> PCI has been updated to accept 64-bit resources, but the PCMCIA code 
> has been missed.  So the correct fix is to propagate the changes where
> necessary into the PCMCIA code.

hmm, I missed that.  That's the price of two screenfuls of fscking compile
warnings.

> The minimalist solution is to fix up the PCMCIA alignment functions.

Greg's dropping the 64-bit-resource patch for now.
