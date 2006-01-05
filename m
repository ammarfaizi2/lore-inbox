Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751219AbWAEX2E@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751219AbWAEX2E (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Jan 2006 18:28:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751402AbWAEX2E
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Jan 2006 18:28:04 -0500
Received: from smtp.osdl.org ([65.172.181.4]:25312 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751219AbWAEX2D (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Jan 2006 18:28:03 -0500
Date: Thu, 5 Jan 2006 15:26:24 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: Joel Schopp <jschopp@austin.ibm.com>
cc: Ingo Molnar <mingo@elte.hu>, lkml <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>, Arjan van de Ven <arjan@infradead.org>,
       Nicolas Pitre <nico@cam.org>, Jes Sorensen <jes@trained-monkey.org>,
       Al Viro <viro@ftp.linux.org.uk>, Oleg Nesterov <oleg@tv-sign.ru>,
       David Howells <dhowells@redhat.com>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Christoph Hellwig <hch@infradead.org>, Andi Kleen <ak@suse.de>,
       Russell King <rmk+lkml@arm.linux.org.uk>,
       Anton Blanchard <anton@samba.org>,
       PPC64-dev <linuxppc64-dev@ozlabs.org>
Subject: Re: [patch 00/21] mutex subsystem, -V14
In-Reply-To: <43BDA672.4090704@austin.ibm.com>
Message-ID: <Pine.LNX.4.64.0601051523060.3169@g5.osdl.org>
References: <20060104144151.GA27646@elte.hu> <43BC5E15.207@austin.ibm.com>
 <20060105143502.GA16816@elte.hu> <43BD4C66.60001@austin.ibm.com>
 <20060105222106.GA26474@elte.hu> <43BDA672.4090704@austin.ibm.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Thu, 5 Jan 2006, Joel Schopp wrote:
> 
> Here is a first pass at a powerpc file for the fast paths just as an FYI/RFC.
> It is completely untested, but compiles.

Shouldn't you make that "isync" dependent on SMP too? UP doesn't need it, 
since DMA will never matter, and interrupts are precise.

		Linus
