Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263171AbTGGBpC (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 6 Jul 2003 21:45:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264393AbTGGBpC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 6 Jul 2003 21:45:02 -0400
Received: from mail.dt.E-Technik.Uni-Dortmund.DE ([129.217.163.1]:62981 "EHLO
	krusty.dt.e-technik.uni-dortmund.de") by vger.kernel.org with ESMTP
	id S263171AbTGGBpA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 6 Jul 2003 21:45:00 -0400
Date: Mon, 7 Jul 2003 03:59:28 +0200
From: Matthias Andree <matthias.andree@gmx.de>
To: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: C99 types VS Linus types
Message-ID: <20030707015928.GC1006@merlin.emma.line.org>
Mail-Followup-To: linux-kernel <linux-kernel@vger.kernel.org>
References: <1057529906.749.41.camel@cube>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1057529906.749.41.camel@cube>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 06 Jul 2003, Albert Cahalan wrote:

> Sure, both are "correct", but there would be a lot less
> pain and suffering in the world if "unsigned long long"
> would be used for 64-bit.

What if unsigned long long is 96 bit? or 128?

> It ought to be at least 40 years
> before 128-bit types begin to matter.

Yup, and 8-Bit CPU and 640 kB RAM ought to be enough for...

nevermind.

> In the Linux world,
> we can consider "long long" to be 64-bit, "int" to be
> 32-bit, and "long" to be the same size as a pointer.

> Then we can ditch the nasty casts:
> sprintf(foo, "%llu", (unsigned long long)bar);

Speaking of shifting forward to standards:

unsigned char foo = 42;
char bar[42];
sprintf(bar, "%ju", (uintmax_t)foo); // see IEEE Std 1003.1-2001

If that's too ugly, write your own [u]intmax_t-to-char[] converter, then
only the stack is nasty if uintmax_t is 128 bits wide and you're
printing an array uint8_t. :-P

-- 
Matthias Andree
