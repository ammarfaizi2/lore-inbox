Return-Path: <linux-kernel-owner+willy=40w.ods.org-S933930AbWKWUok@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933930AbWKWUok (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Nov 2006 15:44:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933931AbWKWUok
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Nov 2006 15:44:40 -0500
Received: from dspnet.fr.eu.org ([213.186.44.138]:35079 "EHLO dspnet.fr.eu.org")
	by vger.kernel.org with ESMTP id S933930AbWKWUoj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Nov 2006 15:44:39 -0500
Date: Thu, 23 Nov 2006 21:44:38 +0100
From: Olivier Galibert <galibert@pobox.com>
To: Arjan van de Ven <arjan@infradead.org>
Cc: linux-pci@atrey.karlin.mff.cuni.cz,
       "Hack inc." <linux-kernel@vger.kernel.org>, Andi Kleen <ak@suse.de>,
       Linus Torvalds <torvalds@osdl.org>
Subject: Re: [PATCH] PCI MMConfig: Detect and support the E7520 and the 945G/GZ/P/PL
Message-ID: <20061123204438.GA42629@dspnet.fr.eu.org>
Mail-Followup-To: Olivier Galibert <galibert@pobox.com>,
	Arjan van de Ven <arjan@infradead.org>,
	linux-pci@atrey.karlin.mff.cuni.cz,
	"Hack inc." <linux-kernel@vger.kernel.org>, Andi Kleen <ak@suse.de>,
	Linus Torvalds <torvalds@osdl.org>
References: <20061123195137.GA35120@dspnet.fr.eu.org> <1164311861.3147.5.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1164311861.3147.5.camel@laptopd505.fenrus.org>
User-Agent: Mutt/1.4.2.2i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 23, 2006 at 08:57:41PM +0100, Arjan van de Ven wrote:
> On Thu, 2006-11-23 at 20:51 +0100, Olivier Galibert wrote:
> > It seems that the only way to reliably support mmconfig in the
> > presence of funky biosen is to detect the hostbridge and read where
> > the window is mapped from its registers.  Do that for the E7520 and
> > the 945G/GZ/P/PL on x86-64 for a start.
> 
> 
> hi,
> 
> while I like this approach a lot, I am wondering if this shouldn't be
> done as a PCI quirk instead.... it would make a lot of sense to use that
> shared infrastructure for this...

I agree in principle, but aren't the quirks running way too late
compared to that?

  OG.

