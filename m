Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265002AbTIJPcG (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 10 Sep 2003 11:32:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264998AbTIJPcF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 Sep 2003 11:32:05 -0400
Received: from [63.205.85.133] ([63.205.85.133]:33526 "EHLO gaz.sfgoth.com")
	by vger.kernel.org with ESMTP id S265002AbTIJPaI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 Sep 2003 11:30:08 -0400
Date: Wed, 10 Sep 2003 08:38:16 -0700
From: Mitchell Blank Jr <mitch@sfgoth.com>
To: Matthew Wilcox <willy@debian.org>
Cc: Marc Zyngier <mzyngier@freesurf.fr>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Move EISA_bus
Message-ID: <20030910153816.GA84652@gaz.sfgoth.com>
References: <20030909222937.GH18654@parcelfarce.linux.theplanet.co.uk> <wrpbrttyztg.fsf@hina.wild-wind.fr.eu.org> <20030910114749.GR18654@parcelfarce.linux.theplanet.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030910114749.GR18654@parcelfarce.linux.theplanet.co.uk>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Matthew Wilcox wrote:
> On Wed, Sep 10, 2003 at 07:31:23AM +0200, Marc Zyngier wrote:
> > While we're at it, why not setting EISA_bus as 'deprecated', so people
> > will know they'd better move the driver to the EISA probing API ?
> 
> I'd rather not.  It'll cause warnings in arch code that's making
> perfectly legitimate use of it, eg arch/i386/kernel/traps.c that sets
> it or arch/parisc/kernel/pci.c that keys off EISA_bus to know whether
> to direct port access to the EISA or PCI bus adapters.

Perhaps put the "depreciated" tag inside an "#ifdef MODULE" so the warnings
will show up in allmodconfig at least.  Or are there any modules that have
a legitimate use for EISA_bus?

-Mitch
