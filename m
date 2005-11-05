Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751222AbVKEJNS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751222AbVKEJNS (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 5 Nov 2005 04:13:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751306AbVKEJNS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 5 Nov 2005 04:13:18 -0500
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:46098 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S1751222AbVKEJNR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 5 Nov 2005 04:13:17 -0500
Date: Sat, 5 Nov 2005 09:13:11 +0000
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: Nick Piggin <nickpiggin@yahoo.com.au>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel <linux-kernel@vger.kernel.org>,
       Linus Torvalds <torvalds@osdl.org>
Subject: Re: [patch 2/5] atomic: cmpxchg
Message-ID: <20051105091311.GA19516@flint.arm.linux.org.uk>
Mail-Followup-To: Nick Piggin <nickpiggin@yahoo.com.au>,
	Andrew Morton <akpm@osdl.org>,
	linux-kernel <linux-kernel@vger.kernel.org>,
	Linus Torvalds <torvalds@osdl.org>
References: <436C655F.2080703@yahoo.com.au> <436C65B1.5020508@yahoo.com.au> <436C65E8.8080501@yahoo.com.au> <20051105090010.GA18926@flint.arm.linux.org.uk> <436C771D.8040703@yahoo.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <436C771D.8040703@yahoo.com.au>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Nov 05, 2005 at 08:10:53PM +1100, Nick Piggin wrote:
> While you're here, does the assembly code for the SMP version look
> OK? You basically provided me with it but I don't think you saw its
> final form.

Looks fine.  The only comment is changing the "r" (old) to be
"Ir" (old).  The "I" tells the compiler that it may also use a
constant for that argument, which may allow it to optimise the
code a bit better.

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 Serial core
