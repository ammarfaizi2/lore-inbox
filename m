Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268750AbRG0BBu>; Thu, 26 Jul 2001 21:01:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268751AbRG0BBk>; Thu, 26 Jul 2001 21:01:40 -0400
Received: from are.twiddle.net ([64.81.246.98]:23438 "EHLO are.twiddle.net")
	by vger.kernel.org with ESMTP id <S268750AbRG0BBb>;
	Thu, 26 Jul 2001 21:01:31 -0400
Date: Thu, 26 Jul 2001 17:57:35 -0700
From: Richard Henderson <rth@twiddle.net>
To: Petr Vandrovec <VANDROVE@vc.cvut.cz>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] gcc-3.0.1 and 2.4.7-ac1
Message-ID: <20010726175735.A20320@twiddle.net>
Mail-Followup-To: Petr Vandrovec <VANDROVE@vc.cvut.cz>,
	Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-kernel@vger.kernel.org
In-Reply-To: <9C117960438@vcnet.vc.cvut.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <9C117960438@vcnet.vc.cvut.cz>; from VANDROVE@vc.cvut.cz on Thu, Jul 26, 2001 at 08:28:32PM +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org
Original-Recipient: rfc822;linux-kernel-outgoing

On Thu, Jul 26, 2001 at 08:28:32PM +0000, Petr Vandrovec wrote:
> Just adding '-finline-limit=150' fixes all of them (critical limit
> is somewhere between 120 and 150 on my kernel). As '-finline-limit'
> is documented as being 10000 by default, it looks like that someone
> changed default value to some really unreasonable value (probably 100).

Yes.  The higher value resulted in much compile-time lossage on
heavily templated c++ code, as it proceeded to inline everything
in sight.

While we may not use 100 in the final 3.0.1, it will definitely
be much lower than 10000.  More intelligent heuristics will have
to wait for 3.1 or something.


r~
