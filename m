Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265033AbTIDOWl (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 Sep 2003 10:22:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265034AbTIDOWk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Sep 2003 10:22:40 -0400
Received: from pizda.ninka.net ([216.101.162.242]:27566 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id S265033AbTIDOVw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Sep 2003 10:21:52 -0400
Date: Thu, 4 Sep 2003 07:12:11 -0700
From: "David S. Miller" <davem@redhat.com>
To: Matt Porter <mporter@kernel.crashing.org>
Cc: paulus@samba.org, rmk@arm.linux.org.uk, hch@lst.de, torvalds@transmeta.com,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] fix ppc ioremap prototype
Message-Id: <20030904071211.24d4fa58.davem@redhat.com>
In-Reply-To: <20030904071535.A22822@home.com>
References: <20030903203231.GA8772@lst.de>
	<16214.34933.827653.37614@nanango.paulus.ozlabs.org>
	<20030904071334.GA14426@lst.de>
	<20030904083007.B2473@flint.arm.linux.org.uk>
	<16215.1054.262782.866063@nanango.paulus.ozlabs.org>
	<20030904023624.592f1601.davem@redhat.com>
	<20030904104801.A7387@flint.arm.linux.org.uk>
	<16215.14133.352143.660688@nanango.paulus.ozlabs.org>
	<20030904060139.5ef43d71.davem@redhat.com>
	<20030904071535.A22822@home.com>
X-Mailer: Sylpheed version 0.9.2 (GTK+ 1.2.6; sparc-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 4 Sep 2003 07:15:35 -0700
Matt Porter <mporter@kernel.crashing.org> wrote:

> The global space method doesn't allow for proper resource management
> in systems with a small floating physical address window but a huge
> bus address space to be accessed.  MPC8245's DAC scheme is a good
> example of this as well as numerous Xscale PCI implementations.
> Paul's suggestion would allow the removal of lots of ugly hacks.

There is nothing that cannot be represented with a big integer.
Encode the "window" in the upper bits, or whatever, get creative.
