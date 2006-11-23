Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1757458AbWKWUkg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757458AbWKWUkg (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Nov 2006 15:40:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757464AbWKWUkg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Nov 2006 15:40:36 -0500
Received: from palinux.external.hp.com ([192.25.206.14]:30389 "EHLO
	mail.parisc-linux.org") by vger.kernel.org with ESMTP
	id S1757458AbWKWUkf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Nov 2006 15:40:35 -0500
Date: Thu, 23 Nov 2006 13:40:34 -0700
From: Matthew Wilcox <matthew@wil.cx>
To: Arjan van de Ven <arjan@infradead.org>
Cc: Olivier Galibert <galibert@pobox.com>, linux-pci@atrey.karlin.mff.cuni.cz,
       "Hack inc." <linux-kernel@vger.kernel.org>, Andi Kleen <ak@suse.de>,
       Linus Torvalds <torvalds@osdl.org>
Subject: Re: [PATCH] PCI MMConfig: Detect and support the E7520 and the 945G/GZ/P/PL
Message-ID: <20061123204034.GF6083@parisc-linux.org>
References: <20061123195137.GA35120@dspnet.fr.eu.org> <1164311861.3147.5.camel@laptopd505.fenrus.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1164311861.3147.5.camel@laptopd505.fenrus.org>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 23, 2006 at 08:57:41PM +0100, Arjan van de Ven wrote:
> On Thu, 2006-11-23 at 20:51 +0100, Olivier Galibert wrote:
> > It seems that the only way to reliably support mmconfig in the
> > presence of funky biosen is to detect the hostbridge and read where
> > the window is mapped from its registers.  Do that for the E7520 and
> > the 945G/GZ/P/PL on x86-64 for a start.
> 
> while I like this approach a lot, I am wondering if this shouldn't be
> done as a PCI quirk instead.... it would make a lot of sense to use that
> shared infrastructure for this...

Except the shared infrastructure kind of relies on having the pci
accesses already working ... unless we want the kernel to print messages
like:

PCI: Using type 1 config access method
...
PCI: Whoops, looks like we're going to use MMCONFIG after all.  Ignore that
