Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261356AbVCUSXd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261356AbVCUSXd (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Mar 2005 13:23:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261448AbVCUSXd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Mar 2005 13:23:33 -0500
Received: from atlmail.prod.rxgsys.com ([64.74.124.160]:38099 "EHLO
	bastet.signetmail.com") by vger.kernel.org with ESMTP
	id S261356AbVCUSXN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Mar 2005 13:23:13 -0500
Date: Mon, 21 Mar 2005 13:22:54 -0500
From: Jeff Garzik <jgarzik@pobox.com>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>, Andrew Morton <akpm@osdl.org>,
       Dave Jones <davej@redhat.com>, Greg KH <greg@kroah.com>,
       chas williams - CONTRACTOR <chas@cmf.nrl.navy.mil>,
       Leendert van Doorn <leendert@watson.ibm.com>,
       Reiner Sailer <sailer@watson.ibm.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] alpha build fixes
Message-ID: <20050321182254.GA12553@havoc.gtf.org>
References: <423BABBF.6030103@pobox.com> <20050319231116.GA4114@twiddle.net> <1111416728.14833.20.camel@localhost.localdomain> <20050321181618.GA7136@twiddle.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050321181618.GA7136@twiddle.net>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 21, 2005 at 10:16:18AM -0800, Richard Henderson wrote:
> On Mon, Mar 21, 2005 at 02:52:10PM +0000, Alan Cox wrote:
> > The issue is bigger - it's needed for the CMD controllers on PA-RISC for
> > example it appears - and anything else where IDE legacy IRQ is wired
> > oddly.
> 
> Sure, but who queries this information?  That's my question.

IDE drivers.

Since its a detail that varies widely depending on platform, the arch
should either provide it or at least have a way to override it.

linux/pci.h would be fine place for the "generic version arch overrides
with HAVE_ARCH_PCI_IDE_IRQ", or we could fix the asm-generic header to
not need #ifdefs in -your- source just to be usable.

	Jeff



