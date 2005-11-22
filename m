Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964951AbVKVO2F@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964951AbVKVO2F (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Nov 2005 09:28:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964950AbVKVO2F
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Nov 2005 09:28:05 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:28305 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S964951AbVKVO2D (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Nov 2005 09:28:03 -0500
Date: Tue, 22 Nov 2005 14:27:55 +0000
From: Christoph Hellwig <hch@infradead.org>
To: Matthew Wilcox <matthew@wil.cx>
Cc: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>,
       Ingo Molnar <mingo@elte.hu>, linux-kernel@vger.kernel.org,
       Russell King <rmk@arm.linux.org.uk>, Ian Molton <spyro@f2s.com>,
       David Howells <dhowells@redhat.com>,
       Benjamin Herrenschmidt <benh@kernel.crashing.org>,
       Paul Mackerras <paulus@samba.org>
Subject: Re: [PATCH 2/5] Ensure NO_IRQ is appropriately defined on all architectures
Message-ID: <20051122142755.GA28239@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Matthew Wilcox <matthew@wil.cx>, Linus Torvalds <torvalds@osdl.org>,
	Andrew Morton <akpm@osdl.org>, Ingo Molnar <mingo@elte.hu>,
	linux-kernel@vger.kernel.org, Russell King <rmk@arm.linux.org.uk>,
	Ian Molton <spyro@f2s.com>, David Howells <dhowells@redhat.com>,
	Benjamin Herrenschmidt <benh@kernel.crashing.org>,
	Paul Mackerras <paulus@samba.org>
References: <E1EeQYc-00055n-Gc@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <E1EeQYc-00055n-Gc@localhost.localdomain>
User-Agent: Mutt/1.4.2.1i
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 22, 2005 at 12:19:06AM -0500, Matthew Wilcox wrote:
> Add a default definition of NO_IRQ to <linux/hardirq.h> and make the
> definition in <asm/hardirq.h> uniform across all architectures which
> define it.

Please put the definition into <asm/irq.h> and <linux/interrupt.h>,
hardirq.h is rather misnamed and about the internal irq/softirq/preempt
mask mechanisms.

