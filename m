Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S273303AbRJIGwG>; Tue, 9 Oct 2001 02:52:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S273305AbRJIGvr>; Tue, 9 Oct 2001 02:51:47 -0400
Received: from are.twiddle.net ([64.81.246.98]:42660 "EHLO are.twiddle.net")
	by vger.kernel.org with ESMTP id <S273303AbRJIGvl>;
	Tue, 9 Oct 2001 02:51:41 -0400
Date: Mon, 8 Oct 2001 23:52:08 -0700
From: Richard Henderson <rth@twiddle.net>
To: "Paul E. McKenney" <pmckenne@us.ibm.com>
Cc: lse-tech@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: Re: RFC: patch to allow lock-free traversal of lists with insertion
Message-ID: <20011008235208.A26109@twiddle.net>
Mail-Followup-To: "Paul E. McKenney" <pmckenne@us.ibm.com>,
	lse-tech@lists.sourceforge.net, linux-kernel@vger.kernel.org
In-Reply-To: <200110090155.f991tPt22329@eng4.beaverton.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <200110090155.f991tPt22329@eng4.beaverton.ibm.com>; from pmckenne@us.ibm.com on Mon, Oct 08, 2001 at 06:55:24PM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 08, 2001 at 06:55:24PM -0700, Paul E. McKenney wrote:
> This is a proposal to provide a wmb()-like primitive that enables
> lock-free traversal of lists while elements are concurrently being
> inserted into these lists.

I've discussed this with you before and you continue to have
completely missed the point.

Alpha requires that you issue read-after-read memory barriers on
the reader side if you require ordering between reads.  That is
the extent of the weakness of the memory ordering.

Sparc64 is the same way.

This crap will never be applied.  Your algorithms are simply broken
if you do not ensure proper read ordering via the rmb() macro.



r~
