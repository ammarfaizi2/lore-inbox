Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263590AbTGBIAb (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Jul 2003 04:00:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263632AbTGBIAb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Jul 2003 04:00:31 -0400
Received: from server0011.freedom2surf.net ([194.106.56.14]:57485 "EHLO
	server0027.freedom2surf.net") by vger.kernel.org with ESMTP
	id S263590AbTGBIAa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Jul 2003 04:00:30 -0400
Date: Wed, 2 Jul 2003 09:14:25 +0100
From: Ian Molton <spyro@f2s.com>
To: Russell King <rmk@arm.linux.org.uk>
Cc: bernie@develer.com, linux-kernel@vger.kernel.org, torvalds@transmeta.com
Subject: Re: [PATCH] Kill div64.h dupes, parenthesize do_div() macro params
Message-Id: <20030702091425.5b7787e8.spyro@f2s.com>
In-Reply-To: <20030702085302.A30638@flint.arm.linux.org.uk>
References: <200307020232.20726.bernie@develer.com>
	<200307020424.47629.bernie@develer.com>
	<20030701193250.1cbd4af9.akpm@digeo.com>
	<200307020515.17722.bernie@develer.com>
	<20030702085302.A30638@flint.arm.linux.org.uk>
Organization: The Dragon Roost
X-Mailer: Sylpheed version 0.8.6 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2 Jul 2003 08:53:02 +0100
Russell King <rmk@arm.linux.org.uk> wrote:

> On Wed, Jul 02, 2003 at 05:15:17AM +0200, Bernardo Innocenti wrote:
> > What's worse, it has different semantics on different architectures:
> 
> Any arch which does 32/32 -> 32q + 32r will break in the new time
> code; it certainly did for ARM.  do_div must now be a 64/32 -> 64q +
> 32r implementation.
> 
> >  arm       64/32 -> 64q + 32r (asm function call)
> >  arm26     32/32 -> 32q + 32r (generic)
> 
> arm26 needs fixing in the same way arm recently was.

Thanks for the heads-up. Im not familiar with the time stuff yet, could
someone send me the full text of the partially snipped post above so I
have some background?


-- 
Spyros lair: http://www.mnementh.co.uk/   ||||   Maintainer: arm26 linux

Do not meddle in the affairs of Dragons, for you are tasty and good with
ketchup.
