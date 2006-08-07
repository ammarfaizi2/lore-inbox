Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751076AbWHGFZI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751076AbWHGFZI (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Aug 2006 01:25:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751079AbWHGFZI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Aug 2006 01:25:08 -0400
Received: from xenotime.net ([66.160.160.81]:35244 "HELO xenotime.net")
	by vger.kernel.org with SMTP id S1751076AbWHGFZG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Aug 2006 01:25:06 -0400
Date: Sun, 6 Aug 2006 22:27:47 -0700
From: "Randy.Dunlap" <rdunlap@xenotime.net>
To: Ingo Molnar <mingo@elte.hu>
Cc: Heiko Carstens <heiko.carstens@de.ibm.com>,
       Martin Schwidefsky <schwidefsky@de.ibm.com>,
       Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: [patch] bootmem: use MAX_DMA_ADDRESS instead of LOW32LIMIT
Message-Id: <20060806222747.a49feb8c.rdunlap@xenotime.net>
In-Reply-To: <20060729035523.GA29875@elte.hu>
References: <20060728130852.GB9559@osiris.boeblingen.de.ibm.com>
	<20060728131306.GA32513@elte.hu>
	<1154098725.3211.5.camel@localhost>
	<20060728194104.GA11622@osiris.ibm.com>
	<20060729035523.GA29875@elte.hu>
Organization: YPO4
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.3; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 29 Jul 2006 05:55:23 +0200 Ingo Molnar wrote:

> 
> * Heiko Carstens <heiko.carstens@de.ibm.com> wrote:
> 
> > Hm... how about this one then:
> > 
> > From: Heiko Carstens <heiko.carstens@de.ibm.com>
> > 
> > Introduce ARCH_LOW_ADDRESS_LIMIT which can be set per architecture to
> > override the 4GB default limit used by the bootmem allocater within
> > __alloc_bootmem_low() and __alloc_bootmem_low_node().
> > E.g. s390 needs a 2GB limit instead of 4GB.
> > 
> > Cc: Ingo Molnar <mingo@elte.hu>
> 
> Acked-by: Ingo Molnar <mingo@elte.hu>
> 
> (although you might get some flak about using an ARCH* define. I'm not 
> sure what the current upstream policy is - using an #ifndef default 
> value is the most compact hence sanest thing to do, still it's sometimes 
> being frowned upon in favor of sprinkling the default value into every 
> architecture's processor.h. Putting the value into a Kconfig and 
> combining it with #ifndef might be better.)

(sorry for the delay, too much travel/conferences)

I agree with your ordering.  Linus wrote about the current
ARCH_HAS* (and HAVE_ARCH* I suppose):
  "WE SHOULD GET RID OF ARCH_HAS_XYZZY. It's a disease."

I have patches for some of these that I will post soon (prob.
Monday), converting several ARCH_HAS* to CONFIG_ namespace.

---
~Randy
