Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261322AbVF1VXs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261322AbVF1VXs (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Jun 2005 17:23:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261400AbVF1VXq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Jun 2005 17:23:46 -0400
Received: from rwcrmhc11.comcast.net ([204.127.198.35]:14469 "EHLO
	rwcrmhc11.comcast.net") by vger.kernel.org with ESMTP
	id S261322AbVF1VVI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Jun 2005 17:21:08 -0400
From: Jesse Barnes <jbarnes@virtuousgeek.org>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH] ppc/ppc64: Fix pci mmap via sysfs
Date: Tue, 28 Jun 2005 14:19:57 -0700
User-Agent: KMail/1.8
Cc: Andrew Morton <akpm@osdl.org>,
       Linux Kernel list <linux-kernel@vger.kernel.org>,
       linux-pci <linux-pci@atrey.karlin.mff.cuni.cz>,
       linuxppc64-dev <linuxppc64-dev@ozlabs.org>
References: <1119836190.5133.59.camel@gaston> <20050626185727.0ce92772.akpm@osdl.org> <1119838264.5133.76.camel@gaston>
In-Reply-To: <1119838264.5133.76.camel@gaston>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-6"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200506281419.57400.jbarnes@virtuousgeek.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sunday, June 26, 2005 7:11 pm, Benjamin Herrenschmidt wrote:
> On Sun, 2005-06-26 at 18:57 -0700, Andrew Morton wrote:
> > Benjamin Herrenschmidt <benh@kernel.crashing.org> wrote:
> > > Hi !
> > >
> > > This implement the change to /proc and sysfs PCI mmap functions
> > > that we discussed a while ago, that is adding an arch optional
> > > pci_resource_to_user() to allow munging on the exposed value of
> > > PCI resources to userland and thus hiding kernel internal values.
> > > It also implements using of that callback to sanitize exposed
> > > values on ppc an ppc64, thus fixing mmap of PCI devices via /proc
> > > and sysfs.
> >
> > You sure you want all those printks in there?
>
> One quilt ref later ... :)

This one looks better. :)  Thanks for fixing this up.

Please document it in sysfs-pci.txt too (I guess we don't have a similar 
document for /proc/bus/pci unfortunately) so that people won't miss it 
when they implement /proc/bus/pci and sysfs PCI mmap support in the 
future.

Thanks,
Jesse
