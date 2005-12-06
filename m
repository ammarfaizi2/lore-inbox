Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932523AbVLFRXG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932523AbVLFRXG (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 Dec 2005 12:23:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932526AbVLFRXG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 Dec 2005 12:23:06 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:484 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S932523AbVLFRXF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 Dec 2005 12:23:05 -0500
Date: Tue, 6 Dec 2005 17:23:00 +0000
From: Christoph Hellwig <hch@infradead.org>
To: Matthew Wilcox <matthew@wil.cx>
Cc: Christoph Hellwig <hch@infradead.org>, Linus Torvalds <torvalds@osdl.org>,
       Andrew Morton <akpm@osdl.org>, Ingo Molnar <mingo@elte.hu>,
       linux-kernel@vger.kernel.org, Russell King <rmk@arm.linux.org.uk>,
       Ian Molton <spyro@f2s.com>, David Howells <dhowells@redhat.com>,
       Benjamin Herrenschmidt <benh@kernel.crashing.org>,
       Paul Mackerras <paulus@samba.org>
Subject: Re: [PATCH 2/5] Ensure NO_IRQ is appropriately defined on all architectures
Message-ID: <20051206172300.GB24092@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Matthew Wilcox <matthew@wil.cx>, Linus Torvalds <torvalds@osdl.org>,
	Andrew Morton <akpm@osdl.org>, Ingo Molnar <mingo@elte.hu>,
	linux-kernel@vger.kernel.org, Russell King <rmk@arm.linux.org.uk>,
	Ian Molton <spyro@f2s.com>, David Howells <dhowells@redhat.com>,
	Benjamin Herrenschmidt <benh@kernel.crashing.org>,
	Paul Mackerras <paulus@samba.org>
References: <E1EeQYc-00055n-Gc@localhost.localdomain> <20051122142755.GA28239@infradead.org> <20051122164345.GM1598@parisc-linux.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051122164345.GM1598@parisc-linux.org>
User-Agent: Mutt/1.4.2.1i
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 22, 2005 at 09:43:46AM -0700, Matthew Wilcox wrote:
> > Please put the definition into <asm/irq.h> and <linux/interrupt.h>,
> > hardirq.h is rather misnamed and about the internal irq/softirq/preempt
> > mask mechanisms.
> 
> Either you're wrong or I'm confused.  I don't see the include path which
> necessarily drags asm/irq.h in from linux/interrupt.h.  There's a
> linux/interrupt.h -> linux/hardirq.h -> asm/hardirq.h path, but not all
> asm/hardirq.h files drag in asm/irq.h.  Look at sparc64 or alpha for
> examples of that.

Indeed.  But that still doesn't mean we should pollute <linux/hardirq.h>
with it..

> Personally, I'd like to see asm/hardirq.h go away and move all its
> contents into asm/irq.h.  And I'd like to see asm/irq.h included
> explicitly from linux/interrupt.h.  And I'd like to see drivers stop
> including asm/irq.h.

Agreed.

