Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266793AbUIJPag@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266793AbUIJPag (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Sep 2004 11:30:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267370AbUIJPag
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Sep 2004 11:30:36 -0400
Received: from ppp-217-133-42-200.cust-adsl.tiscali.it ([217.133.42.200]:48258
	"EHLO x30.random") by vger.kernel.org with ESMTP id S266793AbUIJPaf
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Sep 2004 11:30:35 -0400
Date: Fri, 10 Sep 2004 17:28:52 +0200
From: Andrea Arcangeli <andrea@novell.com>
To: Arjan van de Ven <arjanv@redhat.com>
Cc: Hugh Dickins <hugh@veritas.com>, "Martin J. Bligh" <mbligh@aracnet.com>,
       Andrea Arcangeli <andrea@suse.de>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Chris Wedgwood <cw@f00f.org>, LKML <linux-kernel@vger.kernel.org>,
       Christoph Hellwig <hch@infradead.org>
Subject: Re: [PATCH 1/3] Separate IRQ-stacks from 4K-stacks option
Message-ID: <20040910152852.GC15643@x30.random>
References: <593560000.1094826651@[10.10.2.4]> <Pine.LNX.4.44.0409101555510.16784-100000@localhost.localdomain> <20040910151538.GA24434@devserv.devel.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040910151538.GA24434@devserv.devel.redhat.com>
X-GPG-Key: 1024D/68B9CB43 13D9 8355 295F 4823 7C49  C012 DFA1 686E 68B9 CB43
X-PGP-Key: 1024R/CB4660B9 CC A0 71 81 F4 A0 63 AC  C0 4B 81 1D 8C 15 C8 E5
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 10, 2004 at 05:15:38PM +0200, Arjan van de Ven wrote:
> because it gives people a reason to do sloppy coding.

it's not about bad drivers, it's about the number of nested interrupts
not being limited by software right now.

> What we should consider regardless is disable the nesting of irqs for
> performance reasons but that's an independent matter

disabling nesting completely sounds a bit too aggressive, but limiting
the nesting is probably a good idea.
