Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932127AbVHLKda@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932127AbVHLKda (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 12 Aug 2005 06:33:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932136AbVHLKd3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 Aug 2005 06:33:29 -0400
Received: from pollux.ds.pg.gda.pl ([153.19.208.7]:39696 "EHLO
	pollux.ds.pg.gda.pl") by vger.kernel.org with ESMTP id S932105AbVHLKd2
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 Aug 2005 06:33:28 -0400
Date: Fri, 12 Aug 2005 11:33:31 +0100 (BST)
From: "Maciej W. Rozycki" <macro@linux-mips.org>
To: Bjorn Helgaas <bjorn.helgaas@hp.com>
Cc: Jeff Garzik <jgarzik@pobox.com>, B.Zolnierkiewicz@elka.pw.edu.pl,
       linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org,
       linux-ia64@vger.kernel.org, Tony Luck <tony.luck@intel.com>
Subject: Re: [PATCH] IDE: don't offer IDE_GENERIC on ia64
In-Reply-To: <200508111707.30861.bjorn.helgaas@hp.com>
Message-ID: <Pine.LNX.4.61L.0508121121080.1472@blysk.ds.pg.gda.pl>
References: <200508111424.43150.bjorn.helgaas@hp.com> <20050811214807.GA9775@havoc.gtf.org>
 <42FBC985.4030602@pobox.com> <200508111707.30861.bjorn.helgaas@hp.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 11 Aug 2005, Bjorn Helgaas wrote:

> So the scenario in question (correct me if I'm wrong) is that we
> have a PCI IDE device that is handed off in compatibility mode (and
> may only work in that mode).  In that case, the PCI *device* still
> exists, so shouldn't the IDE PCI code claim that device, notice that
> it's in compatibility mode, and use the legacy ports and IRQs if
> necessary?

 You may have a look at how we've solved this for MIPS, where we have a 
mixture of bus arrangements for different platforms, starting from pure 
ISA/EISA ones, ones with PCI and a PCI-(E)ISA bridge, legacy-free PCI ones 
and systems with no Intel-style buses at all, like TURBOchannel ones.  
See "asm-mips/mach-generic/ide.h" for a simple solution that fits all so 
far.  I'm not sure whether the most recent version of the file has been 
merged upstream -- you may have to have look at: 
"http://www.linux-mips.org/cvsweb/linux/include/asm-mips/mach-generic/ide.h" 
instead.

  Maciej
