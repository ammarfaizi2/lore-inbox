Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261766AbTIDOPi (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 Sep 2003 10:15:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264984AbTIDOPi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Sep 2003 10:15:38 -0400
Received: from fed1mtao02.cox.net ([68.6.19.243]:29421 "EHLO
	fed1mtao02.cox.net") by vger.kernel.org with ESMTP id S261766AbTIDOPh
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Sep 2003 10:15:37 -0400
Date: Thu, 4 Sep 2003 07:15:35 -0700
From: Matt Porter <mporter@kernel.crashing.org>
To: "David S. Miller" <davem@redhat.com>
Cc: Paul Mackerras <paulus@samba.org>, rmk@arm.linux.org.uk, hch@lst.de,
       torvalds@transmeta.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] fix ppc ioremap prototype
Message-ID: <20030904071535.A22822@home.com>
References: <20030903203231.GA8772@lst.de> <16214.34933.827653.37614@nanango.paulus.ozlabs.org> <20030904071334.GA14426@lst.de> <20030904083007.B2473@flint.arm.linux.org.uk> <16215.1054.262782.866063@nanango.paulus.ozlabs.org> <20030904023624.592f1601.davem@redhat.com> <20030904104801.A7387@flint.arm.linux.org.uk> <16215.14133.352143.660688@nanango.paulus.ozlabs.org> <20030904060139.5ef43d71.davem@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20030904060139.5ef43d71.davem@redhat.com>; from davem@redhat.com on Thu, Sep 04, 2003 at 06:01:39AM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 04, 2003 at 06:01:39AM -0700, David S. Miller wrote:
> On Thu, 4 Sep 2003 22:59:33 +1000 (EST)
> Paul Mackerras <paulus@samba.org> wrote:
> 
> > Perhaps the sensible thing is to have a separate resource tree for
> > each PCI domain (actually two trees, for I/O and memory space),
> > and have them contain bus addresses rather than physical addresses.
> 
> I disagree, I think the current model where all resources are
> in a global space makes more sense.

The global space method doesn't allow for proper resource management
in systems with a small floating physical address window but a huge
bus address space to be accessed.  MPC8245's DAC scheme is a good
example of this as well as numerous Xscale PCI implementations.
Paul's suggestion would allow the removal of lots of ugly hacks.

-Matt
