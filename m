Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264132AbUFBVAP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264132AbUFBVAP (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Jun 2004 17:00:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264138AbUFBVAO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Jun 2004 17:00:14 -0400
Received: from [213.146.154.40] ([213.146.154.40]:28551 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S264132AbUFBVAK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Jun 2004 17:00:10 -0400
Date: Wed, 2 Jun 2004 22:00:08 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Ingo Molnar <mingo@elte.hu>
Cc: linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>,
       Andi Kleen <ak@suse.de>, Linus Torvalds <torvalds@osdl.org>,
       Arjan van de Ven <arjanv@redhat.com>,
       "Siddha, Suresh B" <suresh.b.siddha@intel.com>,
       "Nakajima, Jun" <jun.nakajima@intel.com>
Subject: Re: [announce] [patch] NX (No eXecute) support for x86, 2.6.7-rc2-bk2
Message-ID: <20040602210008.GA8176@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Ingo Molnar <mingo@elte.hu>, linux-kernel@vger.kernel.org,
	Andrew Morton <akpm@osdl.org>, Andi Kleen <ak@suse.de>,
	Linus Torvalds <torvalds@osdl.org>,
	Arjan van de Ven <arjanv@redhat.com>,
	"Siddha, Suresh B" <suresh.b.siddha@intel.com>,
	"Nakajima, Jun" <jun.nakajima@intel.com>
References: <20040602205025.GA21555@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040602205025.GA21555@elte.hu>
User-Agent: Mutt/1.4.1i
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


the _GPL export of vmalloc_exec is silly, it's a trivial __vmalloc wrapper
and __vmalloc is exported.  You might be better of just killing it anyway,
I don't see much use for it outside module support.

apropos modules, in SuSE's 2.4 kernels Andi had a nice optimization to
not use vmalloc if we could get high enough order allocations, might be
worth ressurecting that.
