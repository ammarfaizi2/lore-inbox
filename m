Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262613AbTIJLrx (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 10 Sep 2003 07:47:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262641AbTIJLrx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 Sep 2003 07:47:53 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:34733 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S262613AbTIJLru
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 Sep 2003 07:47:50 -0400
Date: Wed, 10 Sep 2003 12:47:49 +0100
From: Matthew Wilcox <willy@debian.org>
To: Marc Zyngier <mzyngier@freesurf.fr>
Cc: Matthew Wilcox <willy@debian.org>, Linus Torvalds <torvalds@osdl.org>,
       linux-kernel@vger.kernel.org, Ralf Baechle <ralf@gnu.org>,
       Richard Henderson <rth@twiddle.net>
Subject: Re: [PATCH] Move EISA_bus
Message-ID: <20030910114749.GR18654@parcelfarce.linux.theplanet.co.uk>
References: <20030909222937.GH18654@parcelfarce.linux.theplanet.co.uk> <wrpbrttyztg.fsf@hina.wild-wind.fr.eu.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <wrpbrttyztg.fsf@hina.wild-wind.fr.eu.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 10, 2003 at 07:31:23AM +0200, Marc Zyngier wrote:
> While we're at it, why not setting EISA_bus as 'deprecated', so people
> will know they'd better move the driver to the EISA probing API ?

I'd rather not.  It'll cause warnings in arch code that's making
perfectly legitimate use of it, eg arch/i386/kernel/traps.c that sets
it or arch/parisc/kernel/pci.c that keys off EISA_bus to know whether
to direct port access to the EISA or PCI bus adapters.

-- 
"It's not Hollywood.  War is real, war is primarily not about defeat or
victory, it is about death.  I've seen thousands and thousands of dead bodies.
Do you think I want to have an academic debate on this subject?" -- Robert Fisk
