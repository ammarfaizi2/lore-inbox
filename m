Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271924AbTHOWQ2 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 15 Aug 2003 18:16:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271969AbTHOWQ2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 15 Aug 2003 18:16:28 -0400
Received: from mail.jlokier.co.uk ([81.29.64.88]:59777 "EHLO
	mail.jlokier.co.uk") by vger.kernel.org with ESMTP id S271924AbTHOWQ0
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 15 Aug 2003 18:16:26 -0400
Date: Fri, 15 Aug 2003 23:16:08 +0100
From: Jamie Lokier <jamie@shareable.org>
To: Matt Mackall <mpm@selenic.com>
Cc: M?ns Rullg?rd <mru@users.sourceforge.net>, linux-kernel@vger.kernel.org
Subject: Re: [RFC][PATCH] Make cryptoapi non-optional?
Message-ID: <20030815221608.GC19707@mail.jlokier.co.uk>
References: <20030813032038.GA1244@think> <20030813040614.GP31810@waste.org> <20030814165320.GA2839@speare5-1-14> <bhgoj9$9ab$1@abraham.cs.berkeley.edu> <20030815001713.GD5333@speare5-1-14> <20030815093003.A2784@pclin040.win.tue.nl> <20030815004004.52f94f9a.davem@redhat.com> <20030815095503.C2784@pclin040.win.tue.nl> <yw1xfzk3pcod.fsf@users.sourceforge.net> <20030815151116.GY325@waste.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030815151116.GY325@waste.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Matt Mackall wrote:
> No, it's a premise stated at the beginning of the thread. We're
> assuming perfect distribution for x and y. The problem here is that x
> and y can be dependent or independent. If they're independent, then
> there's no issue. If they're dependent (for instance correlated or
> anticorrelated) then x^y biases toward zero or one. Which clearly has
> less entropy.

Sure, but that only holds when you assume a specific mix of
independence and dependence among the bits.

(Bits within x are independent of each other, and also within y, while
at the same time x and y are dependent.)

In general, bits from x^y do not have more bias towards zero or one
than bits from x or y alone.  Consider an extreme:

   x = [ random_bit_0, random_bit_0 ]
   y = [ random_bit_1, ~random_bit_1 ]

Then:

   entropy(x) = entropy(y) = 1
   entropy(x^y)            = 2

This is no more arbitrary a mix of dependence and independence than
your assumption.

-- Jamie
