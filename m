Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264879AbTIDJgp (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 Sep 2003 05:36:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264846AbTIDJgp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Sep 2003 05:36:45 -0400
Received: from rth.ninka.net ([216.101.162.244]:46025 "EHLO rth.ninka.net")
	by vger.kernel.org with ESMTP id S264879AbTIDJgm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Sep 2003 05:36:42 -0400
Date: Thu, 4 Sep 2003 02:36:24 -0700
From: "David S. Miller" <davem@redhat.com>
To: Paul Mackerras <paulus@samba.org>
Cc: rmk@arm.linux.org.uk, hch@lst.de, torvalds@transmeta.com,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] fix ppc ioremap prototype
Message-Id: <20030904023624.592f1601.davem@redhat.com>
In-Reply-To: <16215.1054.262782.866063@nanango.paulus.ozlabs.org>
References: <20030903203231.GA8772@lst.de>
	<16214.34933.827653.37614@nanango.paulus.ozlabs.org>
	<20030904071334.GA14426@lst.de>
	<20030904083007.B2473@flint.arm.linux.org.uk>
	<16215.1054.262782.866063@nanango.paulus.ozlabs.org>
X-Mailer: Sylpheed version 0.9.2 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 4 Sep 2003 19:21:34 +1000 (EST)
Paul Mackerras <paulus@samba.org> wrote:

> What I would prefer is if we passed a struct device pointer, a
> resource pointer and an offset to ioremap.  Then we could just have
> bus addresses in PCI device resources instead of having to translate
> them into physical addresses.

You only need a resource in order to do this.  Then you can
stick the upper bits, controller number, whatever in the unused
resource flag bits.
