Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261289AbVAWLSh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261289AbVAWLSh (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 23 Jan 2005 06:18:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261296AbVAWLSh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 23 Jan 2005 06:18:37 -0500
Received: from smtp3.wanadoo.fr ([193.252.22.28]:20341 "EHLO smtp3.wanadoo.fr")
	by vger.kernel.org with ESMTP id S261289AbVAWLSf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 23 Jan 2005 06:18:35 -0500
X-ME-UUID: 20050123111834164.283271C00351@mwinf0306.wanadoo.fr
Date: Sun, 23 Jan 2005 12:17:33 +0100
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: David Woodhouse <dwmw2@infradead.org>,
       linuxppc-dev list <linuxppc-dev@ozlabs.org>,
       Linus Torvalds <torvalds@osdl.org>, "H. Peter Anvin" <hpa@zytor.com>,
       Linux Kernel list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] raid6: altivec support
Message-ID: <20050123111733.GB31635@pegasos>
References: <200501082324.j08NOIva030415@hera.kernel.org> <20050109151353.GA9508@suse.de> <1105956993.26551.327.camel@hades.cambridge.redhat.com> <1106107876.4534.163.camel@gaston> <1106120622.10851.42.camel@baythorne.infradead.org> <1106176939.5294.39.camel@gaston>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <1106176939.5294.39.camel@gaston>
User-Agent: Mutt/1.5.6+20040907i
From: Sven Luther <sven.luther@wanadoo.fr>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 20, 2005 at 10:22:18AM +1100, Benjamin Herrenschmidt wrote:
> On Wed, 2005-01-19 at 07:43 +0000, David Woodhouse wrote:
> > On Wed, 2005-01-19 at 15:11 +1100, Benjamin Herrenschmidt wrote:
> > > We should probably "backport" that simplification to ppc32...
> > 
> > Yeah.... I'm increasingly tempted to merge ppc32/ppc64 into one arch
> > like mips/parisc/s390. Or would that get vetoed on the basis that we
> > don't have all that horrid non-OF platform support in ppc64 yet, and
> > we're still kidding ourselves that all those embedded vendors will
> > either not notice ppc64 or will use OF?
> 
> Oh well... i've though about it too, and decided that I was not ready to
> try it. For one, the problem you mention, with the pile of embedded
> junk. I made the design decision to define an OF client interface as the
> standard & mandatory entry mecanism to the ppc64 kernel (except legacy
> iSeries of course, but I don't want that to multiply). That or the
> kexec-like entrypoint passing a flattened device-tree in.
> 
> Also, there are other significant differences in other areas. At this
> point, I think the differences are  bigger than the common code.
> 
> What would be interesting would be to proceed incrementally, having a
> directory somewhere to put the "common" ppc/ppc64 code, and slowly
> moving things there.

It may be too complicated, but what about letting the commong code in ppc, and
moving the ppc32 code into ppc32 ? 

Friendly,

Sven Luther

