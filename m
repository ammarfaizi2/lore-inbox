Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261971AbVASX1D@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261971AbVASX1D (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 19 Jan 2005 18:27:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261978AbVASXZ6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 19 Jan 2005 18:25:58 -0500
Received: from gate.crashing.org ([63.228.1.57]:20205 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S261971AbVASXXw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 19 Jan 2005 18:23:52 -0500
Subject: Re: [PATCH] raid6: altivec support
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: David Woodhouse <dwmw2@infradead.org>
Cc: Olaf Hering <olh@suse.de>, linuxppc-dev list <linuxppc-dev@ozlabs.org>,
       Linus Torvalds <torvalds@osdl.org>,
       Linux Kernel list <linux-kernel@vger.kernel.org>,
       "H. Peter Anvin" <hpa@zytor.com>
In-Reply-To: <1106120622.10851.42.camel@baythorne.infradead.org>
References: <200501082324.j08NOIva030415@hera.kernel.org>
	 <20050109151353.GA9508@suse.de>
	 <1105956993.26551.327.camel@hades.cambridge.redhat.com>
	 <1106107876.4534.163.camel@gaston>
	 <1106120622.10851.42.camel@baythorne.infradead.org>
Content-Type: text/plain
Date: Thu, 20 Jan 2005 10:22:18 +1100
Message-Id: <1106176939.5294.39.camel@gaston>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2005-01-19 at 07:43 +0000, David Woodhouse wrote:
> On Wed, 2005-01-19 at 15:11 +1100, Benjamin Herrenschmidt wrote:
> > We should probably "backport" that simplification to ppc32...
> 
> Yeah.... I'm increasingly tempted to merge ppc32/ppc64 into one arch
> like mips/parisc/s390. Or would that get vetoed on the basis that we
> don't have all that horrid non-OF platform support in ppc64 yet, and
> we're still kidding ourselves that all those embedded vendors will
> either not notice ppc64 or will use OF?

Oh well... i've though about it too, and decided that I was not ready to
try it. For one, the problem you mention, with the pile of embedded
junk. I made the design decision to define an OF client interface as the
standard & mandatory entry mecanism to the ppc64 kernel (except legacy
iSeries of course, but I don't want that to multiply). That or the
kexec-like entrypoint passing a flattened device-tree in.

Also, there are other significant differences in other areas. At this
point, I think the differences are  bigger than the common code.

What would be interesting would be to proceed incrementally, having a
directory somewhere to put the "common" ppc/ppc64 code, and slowly
moving things there.

Ben.


