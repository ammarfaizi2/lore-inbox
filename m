Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262846AbVBBWNN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262846AbVBBWNN (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Feb 2005 17:13:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262549AbVBBWLb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Feb 2005 17:11:31 -0500
Received: from omx1-ext.sgi.com ([192.48.179.11]:40836 "EHLO
	omx1.americas.sgi.com") by vger.kernel.org with ESMTP
	id S262569AbVBBVb6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Feb 2005 16:31:58 -0500
Date: Wed, 2 Feb 2005 13:31:42 -0800 (PST)
From: Christoph Lameter <clameter@sgi.com>
X-X-Sender: clameter@schroedinger.engr.sgi.com
To: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
cc: David Woodhouse <dwmw2@infradead.org>, linux-mm@kvack.org,
       linux-kernel@vger.kernel.org, akpm@osdl.org
Subject: Re: A scrub daemon (prezeroing)
In-Reply-To: <20050202163110.GB23132@logos.cnet>
Message-ID: <Pine.LNX.4.58.0502021328290.13966@schroedinger.engr.sgi.com>
References: <Pine.LNX.4.58.0501211228430.26068@schroedinger.engr.sgi.com>
 <1106828124.19262.45.camel@hades.cambridge.redhat.com> <20050202153256.GA19615@logos.cnet>
 <Pine.LNX.4.58.0502021103410.12695@schroedinger.engr.sgi.com>
 <20050202163110.GB23132@logos.cnet>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2 Feb 2005, Marcelo Tosatti wrote:

> > Nope the BTE is a block transfer engine. Its an inter numa node DMA thing
> > that is being abused to zero blocks.
> Ah, OK.
> Is there a driver for normal BTE operation or is not kernel-controlled ?

There is a function bte_copy in the ia64 arch. See

arch/ia64/sn/kernel/bte.c

> I wonder what has to be done to have active DMA engines be abused for zeroing
> when idle and what are the implications of that. Some kind of notification mechanism
> is necessary to inform idleness ?
>
> Someone should try implementing the zeroing driver for a fast x86 PCI device. :)

Sure but I am on ia64 not i386. Find your own means to abuse your own
chips ... ;-)
