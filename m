Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261379AbUK0XR5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261379AbUK0XR5 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 27 Nov 2004 18:17:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261376AbUK0XR4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 27 Nov 2004 18:17:56 -0500
Received: from canuck.infradead.org ([205.233.218.70]:50951 "EHLO
	canuck.infradead.org") by vger.kernel.org with ESMTP
	id S261381AbUK0XRU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 27 Nov 2004 18:17:20 -0500
Subject: Re: [RFC] Splitting kernel headers and deprecating __KERNEL__
From: David Woodhouse <dwmw2@infradead.org>
To: Arnd Bergmann <arnd@arndb.de>
Cc: "Randy.Dunlap" <rddunlap@osdl.org>, Matthew Wilcox <matthew@wil.cx>,
       Tonnerre <tonnerre@thundrix.ch>, dhowells <dhowells@redhat.com>,
       torvalds@osdl.org, hch@infradead.org, aoliva@redhat.com,
       linux-kernel@vger.kernel.org, libc-hacker@sources.redhat.com
In-Reply-To: <200411272353.54056.arnd@arndb.de>
References: <19865.1101395592@redhat.com> <41A8AF8F.8060005@osdl.org>
	 <1101575782.21273.5347.camel@baythorne.infradead.org>
	 <200411272353.54056.arnd@arndb.de>
Content-Type: text/plain
Date: Sat, 27 Nov 2004 23:12:58 +0000
Message-Id: <1101597178.5278.6.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.2 (2.0.2-3.dwmw2.1) 
Content-Transfer-Encoding: 7bit
X-Spam-Score: 0.0 (/)
X-SRS-Rewrite: SMTP reverse-path rewritten from <dwmw2@infradead.org> by canuck.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2004-11-27 at 23:53 +0100, Arnd Bergmann wrote:
> The problem with these (atomic.h, bitops.h, byteorder.h, div64.h,
> list.h, spinlock.h, unaligned.h and xor.h) is that they provide
> functionality that is needed by many user application but not
> provided by the compiler or libc. 
> 
> While I agree that it is an absolutely evil concept to include
> them from the kernel headers, we have to face that by not installing
> them, lots of this existing evil user code will be broken even
> more and someone has to pick up the pieces.

The existing evil user code is broken already. Any of the above can be
implemented in a such a way that it only works in the kernel anyway.

We don't need to preserve it any more than we need to preserve evil
broken code which defines __KERNEL__ before including certain headers.
We're supposed to be cleaning this crap up. If we want every evil broken
hack that's currently possible to _remain_ possible, it's never going to
work.
 
-- 
dwmw2

