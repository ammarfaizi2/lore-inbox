Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264066AbTGFWy2 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 6 Jul 2003 18:54:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266748AbTGFWy2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 6 Jul 2003 18:54:28 -0400
Received: from mail.jlokier.co.uk ([81.29.64.88]:7308 "EHLO mail.jlokier.co.uk")
	by vger.kernel.org with ESMTP id S264066AbTGFWy1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 6 Jul 2003 18:54:27 -0400
Date: Mon, 7 Jul 2003 00:08:23 +0100
From: Jamie Lokier <jamie@shareable.org>
To: Bernardo Innocenti <bernie@develer.com>
Cc: Philippe Elie <phil.el@wanadoo.fr>, linux-kernel@vger.kernel.org,
       Richard Henderson <rth@twiddle.net>
Subject: Re: SPAM[RBL] Re: C99 types VS Linus types
Message-ID: <20030706230823.GB6123@mail.jlokier.co.uk>
References: <200307060703.58533.bernie@develer.com> <3F0814B1.1000401@wanadoo.fr> <200307061937.26519.bernie@develer.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200307061937.26519.bernie@develer.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Bernardo Innocenti wrote:
> On Sunday 06 July 2003 14:23, Philippe Elie wrote:
>  > alpha user space .h define uint64_t as unsigned long,
>  > include/asm-alpha/types.h defines it as unsigned long long.
> 
>  Why is that? Isn't uint64_t supposed to be _always_ a 64bit
> unsigned integer? Either the kernel or the user space might
> be doing the wrong thing...

uint64_t is always a 64-bit type, and in the case given the compiler
emits a warning but the code runs ok.

The problem is that "64-bit long" and "64-bit long long" are different
types with the same representation.  Which means they are mostly
interchangeable, with occasional C weirdness.

-- Jamie
