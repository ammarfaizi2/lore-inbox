Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265247AbTIDQOU (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 Sep 2003 12:14:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265239AbTIDQOT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Sep 2003 12:14:19 -0400
Received: from pizda.ninka.net ([216.101.162.242]:30127 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id S265247AbTIDQNZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Sep 2003 12:13:25 -0400
Date: Thu, 4 Sep 2003 09:03:43 -0700
From: "David S. Miller" <davem@redhat.com>
To: Matt Porter <mporter@kernel.crashing.org>
Cc: paulus@samba.org, rmk@arm.linux.org.uk, hch@lst.de, torvalds@transmeta.com,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] fix ppc ioremap prototype
Message-Id: <20030904090343.50fd35c4.davem@redhat.com>
In-Reply-To: <20030904082605.C22822@home.com>
References: <20030903203231.GA8772@lst.de>
	<16214.34933.827653.37614@nanango.paulus.ozlabs.org>
	<20030904071334.GA14426@lst.de>
	<20030904083007.B2473@flint.arm.linux.org.uk>
	<16215.1054.262782.866063@nanango.paulus.ozlabs.org>
	<20030904023624.592f1601.davem@redhat.com>
	<20030904073650.B22822@home.com>
	<20030904073009.6684112e.davem@redhat.com>
	<20030904082605.C22822@home.com>
X-Mailer: Sylpheed version 0.9.2 (GTK+ 1.2.6; sparc-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 4 Sep 2003 08:26:05 -0700
Matt Porter <mporter@kernel.crashing.org> wrote:

> That will work for the PCI case.  It does force us to maintain a
> remap_page_range64() in arch/ppc, duplicating code, and creating a
> maintainer headache.

We've had an io_remap_page_range() with an extra "space"
argument for the >32bits of the physical address on sparc32
for ages exactly for this purpose.
