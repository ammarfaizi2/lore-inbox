Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264696AbTGBE6l (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Jul 2003 00:58:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264709AbTGBE6l
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Jul 2003 00:58:41 -0400
Received: from air-2.osdl.org ([65.172.181.6]:59091 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S264696AbTGBE6k (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Jul 2003 00:58:40 -0400
Date: Tue, 1 Jul 2003 22:12:48 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: Bernardo Innocenti <bernie@develer.com>
cc: Andrew Morton <akpm@digeo.com>, <linux-kernel@vger.kernel.org>,
       <torvalds@transmeta.com>
Subject: Re: [PATCH] Kill div64.h dupes, parenthesize do_div() macro params
In-Reply-To: <200307020515.17722.bernie@develer.com>
Message-ID: <Pine.LNX.4.44.0307012209510.2047-100000@home.osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Wed, 2 Jul 2003, Bernardo Innocenti wrote:
>
>  Wait! It's not documented at all that do_div() really does a
> 64bit/32bit division with 32bit remainder.

Oh, it's documented all right. It's even documented by the architectures 
that do it wrong (ie chris/arm26 say "we're not 64-bit but..")

> What's worse, it has different semantics on different archictecures:

only because some architectures on purpose get it wrong, because they 
don't care.

>  i386      64/32 -> 64q + 32r (inline asm + C for 64bit case)

This is the only version that has ever been valid.

It's a 64/32->64+32. No excuses, no nothing. There is no question about 
it.

		Linus

