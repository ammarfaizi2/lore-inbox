Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S277836AbRJIRAe>; Tue, 9 Oct 2001 13:00:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S277835AbRJIRAP>; Tue, 9 Oct 2001 13:00:15 -0400
Received: from are.twiddle.net ([64.81.246.98]:10917 "EHLO are.twiddle.net")
	by vger.kernel.org with ESMTP id <S277839AbRJIQ7y>;
	Tue, 9 Oct 2001 12:59:54 -0400
Date: Tue, 9 Oct 2001 10:00:23 -0700
From: Richard Henderson <rth@twiddle.net>
To: Paul McKenney <Paul.McKenney@us.ibm.com>
Cc: linux-kernel@vger.kernel.org, lse-tech@lists.sourceforge.net
Subject: Re: RFC: patch to allow lock-free traversal of lists with insertion
Message-ID: <20011009100023.A27427@twiddle.net>
Mail-Followup-To: Paul McKenney <Paul.McKenney@us.ibm.com>,
	linux-kernel@vger.kernel.org, lse-tech@lists.sourceforge.net
In-Reply-To: <OF296D0EDC.4D1AE07A-ON88256AE0.00568638@boulder.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <OF296D0EDC.4D1AE07A-ON88256AE0.00568638@boulder.ibm.com>; from Paul.McKenney@us.ibm.com on Tue, Oct 09, 2001 at 08:45:15AM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 09, 2001 at 08:45:15AM -0700, Paul McKenney wrote:
> Please see the example above.  I do believe that my algorithms are
> reliably forcing proper read ordering using IPIs, just in an different
> way.

I wasn't suggesting that the IPI wouldn't work -- it will.
But it will be _extremely_ slow.

I am suggesting that the lock-free algorithms should add the
read barriers, and that failure to do so indicates that they
are incomplete.  If nothing else, it documents where the real
dependancies are.


r~
