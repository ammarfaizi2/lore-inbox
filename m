Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S277322AbRJJRCE>; Wed, 10 Oct 2001 13:02:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S277320AbRJJRBo>; Wed, 10 Oct 2001 13:01:44 -0400
Received: from are.twiddle.net ([64.81.246.98]:21414 "EHLO are.twiddle.net")
	by vger.kernel.org with ESMTP id <S277319AbRJJRBj>;
	Wed, 10 Oct 2001 13:01:39 -0400
Date: Wed, 10 Oct 2001 10:02:08 -0700
From: Richard Henderson <rth@twiddle.net>
To: Paul Mackerras <paulus@samba.org>
Cc: Paul McKenney <Paul.McKenney@us.ibm.com>, linux-kernel@vger.kernel.org,
        lse-tech@lists.sourceforge.net
Subject: Re: RFC: patch to allow lock-free traversal of lists with insertion
Message-ID: <20011010100208.A30345@twiddle.net>
Mail-Followup-To: Paul Mackerras <paulus@samba.org>,
	Paul McKenney <Paul.McKenney@us.ibm.com>,
	linux-kernel@vger.kernel.org, lse-tech@lists.sourceforge.net
In-Reply-To: <OF296D0EDC.4D1AE07A-ON88256AE0.00568638@boulder.ibm.com> <20011009100023.A27427@twiddle.net> <15299.49574.450686.706920@cargo.ozlabs.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <15299.49574.450686.706920@cargo.ozlabs.ibm.com>; from paulus@samba.org on Wed, Oct 10, 2001 at 01:33:58PM +1000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 10, 2001 at 01:33:58PM +1000, Paul Mackerras wrote:
> 1. Define an rmbdd() which is a no-op on all architectures except for
>    alpha, where it is an rmb.  Richard can then have the job of
>    finding all the places where an rmbdd is needed, which sounds like
>    one of the smellier labors of Hercules to me. :)  

I don't think it's actually all that bad.  There won't be all
that many places that require the rmbdd, and they'll pretty
much exactly correspond to the places in which you have to put
wmb for all architectures anyway.


r~
