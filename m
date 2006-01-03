Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751417AbWACPGX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751417AbWACPGX (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 3 Jan 2006 10:06:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751437AbWACPGW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 3 Jan 2006 10:06:22 -0500
Received: from mx2.mail.elte.hu ([157.181.151.9]:37064 "EHLO mx2.mail.elte.hu")
	by vger.kernel.org with ESMTP id S1751417AbWACPGW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 3 Jan 2006 10:06:22 -0500
Date: Tue, 3 Jan 2006 16:05:54 +0100
From: Ingo Molnar <mingo@elte.hu>
To: Nick Piggin <nickpiggin@yahoo.com.au>
Cc: lkml <linux-kernel@vger.kernel.org>, Linus Torvalds <torvalds@osdl.org>,
       Andrew Morton <akpm@osdl.org>, Arjan van de Ven <arjan@infradead.org>,
       Nicolas Pitre <nico@cam.org>, Jes Sorensen <jes@trained-monkey.org>,
       Al Viro <viro@ftp.linux.org.uk>, Oleg Nesterov <oleg@tv-sign.ru>,
       David Howells <dhowells@redhat.com>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Christoph Hellwig <hch@infradead.org>, Andi Kleen <ak@suse.de>,
       Russell King <rmk+lkml@arm.linux.org.uk>
Subject: Re: [patch 08/19] mutex subsystem, core
Message-ID: <20060103150554.GA1211@elte.hu>
References: <20060103100807.GH23289@elte.hu> <43BA78EC.7050603@yahoo.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <43BA78EC.7050603@yahoo.com.au>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamScore: -2.0
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=-2.0 required=5.9 tests=ALL_TRUSTED,AWL autolearn=no SpamAssassin version=3.0.3
	-2.8 ALL_TRUSTED            Did not pass through any untrusted hosts
	0.9 AWL                    AWL: From: address is in the auto white-list
X-ELTE-VirusStatus: clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Nick Piggin <nickpiggin@yahoo.com.au> wrote:

> >+#define spin_lock_mutex(lock)			spin_lock(lock)
> >+#define spin_unlock_mutex(lock)			spin_unlock(lock)
> 
> Is this an interrupt deadlock, or do you not allow interrupt contexts 
> to even trylock a mutex?

correct, no irq contexts are allowed. This is also checked for if 
CONFIG_DEBUG_MUTEXES is enabled.

	Ingo
