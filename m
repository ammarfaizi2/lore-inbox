Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267552AbUIJQTV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267552AbUIJQTV (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Sep 2004 12:19:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267497AbUIJQS0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Sep 2004 12:18:26 -0400
Received: from the-village.bc.nu ([81.2.110.252]:37553 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id S267527AbUIJQMx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Sep 2004 12:12:53 -0400
Subject: Re: [PATCH 1/3] Separate IRQ-stacks from 4K-stacks option
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Andrea Arcangeli <andrea@novell.com>
Cc: Arjan van de Ven <arjanv@redhat.com>, Hugh Dickins <hugh@veritas.com>,
       "Martin J. Bligh" <mbligh@aracnet.com>,
       Andrea Arcangeli <andrea@suse.de>, Chris Wedgwood <cw@f00f.org>,
       LKML <linux-kernel@vger.kernel.org>,
       Christoph Hellwig <hch@infradead.org>
In-Reply-To: <20040910152852.GC15643@x30.random>
References: <593560000.1094826651@[10.10.2.4]>
	 <Pine.LNX.4.44.0409101555510.16784-100000@localhost.localdomain>
	 <20040910151538.GA24434@devserv.devel.redhat.com>
	 <20040910152852.GC15643@x30.random>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1094828979.17442.10.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Fri, 10 Sep 2004 16:09:40 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Gwe, 2004-09-10 at 16:28, Andrea Arcangeli wrote:
> > What we should consider regardless is disable the nesting of irqs for
> > performance reasons but that's an independent matter
> 
> disabling nesting completely sounds a bit too aggressive, but limiting
> the nesting is probably a good idea.

Thats a trivial change because you can poke the overflow IRQs into
IRQ_PENDING and then do a cleanup loop if it was hit

