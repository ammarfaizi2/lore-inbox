Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751332AbWFLFNe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751332AbWFLFNe (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 Jun 2006 01:13:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751348AbWFLFNe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 Jun 2006 01:13:34 -0400
Received: from willy.net1.nerim.net ([62.212.114.60]:26120 "EHLO 1wt.eu")
	by vger.kernel.org with ESMTP id S1751332AbWFLFNd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 Jun 2006 01:13:33 -0400
Date: Mon, 12 Jun 2006 07:13:18 +0200
From: Willy Tarreau <w@1wt.eu>
To: Matt Mackall <mpm@selenic.com>
Cc: Arjan van de Ven <arjan@infradead.org>,
       linux-kernel <linux-kernel@vger.kernel.org>, akpm@osdl.org
Subject: Re: [PATCH] x86 built-in command line
Message-ID: <20060612051318.GB13255@w.ods.org>
References: <20060611215530.GH24227@waste.org> <1150069241.3131.97.camel@laptopd505.fenrus.org> <20060611235101.GK24227@waste.org> <1150070898.3131.99.camel@laptopd505.fenrus.org> <20060612013801.GL24227@waste.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060612013801.GL24227@waste.org>
User-Agent: Mutt/1.5.10i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jun 11, 2006 at 08:38:01PM -0500, Matt Mackall wrote:
> On Mon, Jun 12, 2006 at 02:08:18AM +0200, Arjan van de Ven wrote:
> > On Sun, 2006-06-11 at 18:51 -0500, Matt Mackall wrote:
> > > On Mon, Jun 12, 2006 at 01:40:41AM +0200, Arjan van de Ven wrote:
> > > > On Sun, 2006-06-11 at 16:55 -0500, Matt Mackall wrote:
> > > > > This patch allows building in a kernel command line on x86 as is
> > > > > possible on several other arches.
> > > > 
> > > > wouldn't it make more sense to allow the initramfs to set such arguments
> > > > instead?
> > > 
> > > Huh?
> > > 
> > > Are you suggesting we go digging around in a gzipped initramfs image at
> > > early command line parsing time? I can't really see how that would work. 
> > 
> > but.. the example you give is for the rootfs.. which is used only really
> > late...
> 
> That's not an example, that's just pointing out if you don't specify
> root=, it probably won't boot.

I've had other usages of this : when booting kernels from PXE, it is
very convenient to have default command line arguments in different
images, and not have to modify anything in the boot loader. Moreover,
using a *default* command line allows the boot loader to override the
arguments while it would not be easy from the initramfs. Last but not
least, disabling sensible features such as ACPI/APIC needs to be
performed before initramfs.

Cheers,
Willy

