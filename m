Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S277493AbRJJW1I>; Wed, 10 Oct 2001 18:27:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S277494AbRJJW06>; Wed, 10 Oct 2001 18:26:58 -0400
Received: from are.twiddle.net ([64.81.246.98]:45734 "EHLO are.twiddle.net")
	by vger.kernel.org with ESMTP id <S277493AbRJJW0r>;
	Wed, 10 Oct 2001 18:26:47 -0400
Date: Wed, 10 Oct 2001 15:27:17 -0700
From: Richard Henderson <rth@twiddle.net>
To: Paul McKenney <Paul.McKenney@us.ibm.com>
Cc: linux-kernel@vger.kernel.org, lse-tech@lists.sourceforge.net,
        Paul Mackerras <paulus@samba.org>
Subject: Re: RFC: patch to allow lock-free traversal of lists with insertion
Message-ID: <20011010152717.B31099@twiddle.net>
Mail-Followup-To: Paul McKenney <Paul.McKenney@us.ibm.com>,
	linux-kernel@vger.kernel.org, lse-tech@lists.sourceforge.net,
	Paul Mackerras <paulus@samba.org>
In-Reply-To: <OF99CB0435.488D4308-ON88256AE1.0077A859@boulder.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <OF99CB0435.488D4308-ON88256AE1.0077A859@boulder.ibm.com>; from Paul.McKenney@us.ibm.com on Wed, Oct 10, 2001 at 02:47:05PM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 10, 2001 at 02:47:05PM -0700, Paul McKenney wrote:
> > I don't think it's actually all that bad.  There won't be all
> > that many places that require the rmbdd, and they'll pretty
> > much exactly correspond to the places in which you have to put
> > wmb for all architectures anyway.
> 
> Just to make sure I understand...  This rmbdd() would use IPIs to
> get all the CPUs' caches synchronized, right?

Err, I see your confusion now.

"Correspond" meaning "for every wmb needed on the writer side,
there is likely an rmb needed on the reader side in a similar
place".


r~
