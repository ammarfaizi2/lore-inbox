Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264978AbTIDNLU (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 Sep 2003 09:11:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264979AbTIDNLU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Sep 2003 09:11:20 -0400
Received: from pizda.ninka.net ([216.101.162.242]:59053 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id S264978AbTIDNLT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Sep 2003 09:11:19 -0400
Date: Thu, 4 Sep 2003 06:01:39 -0700
From: "David S. Miller" <davem@redhat.com>
To: Paul Mackerras <paulus@samba.org>
Cc: rmk@arm.linux.org.uk, hch@lst.de, torvalds@transmeta.com,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] fix ppc ioremap prototype
Message-Id: <20030904060139.5ef43d71.davem@redhat.com>
In-Reply-To: <16215.14133.352143.660688@nanango.paulus.ozlabs.org>
References: <20030903203231.GA8772@lst.de>
	<16214.34933.827653.37614@nanango.paulus.ozlabs.org>
	<20030904071334.GA14426@lst.de>
	<20030904083007.B2473@flint.arm.linux.org.uk>
	<16215.1054.262782.866063@nanango.paulus.ozlabs.org>
	<20030904023624.592f1601.davem@redhat.com>
	<20030904104801.A7387@flint.arm.linux.org.uk>
	<16215.14133.352143.660688@nanango.paulus.ozlabs.org>
X-Mailer: Sylpheed version 0.9.2 (GTK+ 1.2.6; sparc-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 4 Sep 2003 22:59:33 +1000 (EST)
Paul Mackerras <paulus@samba.org> wrote:

> Perhaps the sensible thing is to have a separate resource tree for
> each PCI domain (actually two trees, for I/O and memory space),
> and have them contain bus addresses rather than physical addresses.

I disagree, I think the current model where all resources are
in a global space makes more sense.

kernel/resource.c would get more complex with your idea.

I'd suggest making an ocp_ioremap() to solve this problem for
the time being.
