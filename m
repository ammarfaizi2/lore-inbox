Return-Path: <linux-kernel-owner+w=401wt.eu-S1753580AbWLRJIL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753580AbWLRJIL (ORCPT <rfc822;w@1wt.eu>);
	Mon, 18 Dec 2006 04:08:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753575AbWLRJIK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 18 Dec 2006 04:08:10 -0500
Received: from relay.2ka.mipt.ru ([194.85.82.65]:38762 "EHLO 2ka.mipt.ru"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753577AbWLRJII (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 18 Dec 2006 04:08:08 -0500
Date: Mon, 18 Dec 2006 12:05:45 +0300
From: Evgeniy Polyakov <johnpol@2ka.mipt.ru>
To: David Woodhouse <dwmw2@infradead.org>
Cc: Linus Torvalds <torvalds@osdl.org>, Nick Piggin <nickpiggin@yahoo.com.au>,
       Russell King <rmk+lkml@arm.linux.org.uk>,
       David Howells <dhowells@redhat.com>, Andrew Morton <akpm@osdl.org>,
       "David S. Miller" <davem@davemloft.net>, matthew@wil.cx,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       linux-arch@vger.kernel.org
Subject: Re: [PATCH 1/2] WorkStruct: Add assign_bits() to give an atomic-bitops safe assignment
Message-ID: <20061218090545.GC21778@2ka.mipt.ru>
References: <20061212201112.29817.22041.stgit@warthog.cambridge.redhat.com> <20061212225443.GA25902@flint.arm.linux.org.uk> <Pine.LNX.4.64.0612121726150.3535@woody.osdl.org> <457F606B.70805@yahoo.com.au> <Pine.LNX.4.64.0612151437130.3849@woody.osdl.org> <1166432184.25827.8.camel@pmac.infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=koi8-r
Content-Disposition: inline
In-Reply-To: <1166432184.25827.8.camel@pmac.infradead.org>
User-Agent: Mutt/1.5.9i
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-1.7.5 (2ka.mipt.ru [0.0.0.0]); Mon, 18 Dec 2006 12:05:46 +0300 (MSK)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 18, 2006 at 08:56:24AM +0000, David Woodhouse (dwmw2@infradead.org) wrote:
> On Fri, 2006-12-15 at 14:45 -0800, Linus Torvalds wrote:
> > This uses "atomic_long_t" for the workstruct "data" field, which shares 
> > the per-cpu pointer and the workstruct flag bits in one field.
> 
> This fixes drivers/connector/connector.c to cope...
> 
> Signed-off-by: David Woodhouse <dwmw2@infradead.org>

Yep, there are already four different patches to fix it.
Proper one will be pushed through David Miller's netdev tree splitted into 
fix and delayed work removal.

Thanks David.
 
> -- 
> dwmw2

-- 
	Evgeniy Polyakov
