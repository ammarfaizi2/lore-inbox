Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263475AbUFDC4i@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263475AbUFDC4i (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Jun 2004 22:56:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265580AbUFDC4i
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Jun 2004 22:56:38 -0400
Received: from mx1.redhat.com ([66.187.233.31]:2249 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S263475AbUFDC4h (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Jun 2004 22:56:37 -0400
Date: Thu, 3 Jun 2004 19:54:09 -0700
From: "David S. Miller" <davem@redhat.com>
To: Paul Jackson <pj@sgi.com>
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org, ak@muc.de,
       ashok.raj@intel.com, hch@infradead.org, jbarnes@sgi.com,
       joe.korty@ccur.com, manfred@colorfullife.com, colpatch@us.ibm.com,
       mikpe@csd.uu.se, nickpiggin@yahoo.com.au, rusty@rustcorp.com.au,
       Simon.Derr@bull.net, wli@holomorphy.com
Subject: Re: [PATCH] cpumask 5/10 rewrite cpumask.h - single bitmap based
 implementation
Message-Id: <20040603195409.11d4aec2.davem@redhat.com>
In-Reply-To: <20040603194755.667e584b.pj@sgi.com>
References: <20040603094339.03ddfd42.pj@sgi.com>
	<20040603101010.4b15734a.pj@sgi.com>
	<20040603170725.4b3f8b34.akpm@osdl.org>
	<20040603194755.667e584b.pj@sgi.com>
X-Mailer: Sylpheed version 0.9.11 (GTK+ 1.2.10; sparc-unknown-linux-gnu)
X-Face: "_;p5u5aPsO,_Vsx"^v-pEq09'CU4&Dc1$fQExov$62l60cgCc%FnIwD=.UF^a>?5'9Kn[;433QFVV9M..2eN.@4ZWPGbdi<=?[:T>y?SD(R*-3It"Vj:)"dP
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 3 Jun 2004 19:47:55 -0700
Paul Jackson <pj@sgi.com> wrote:

> > We avoided doing this because in some situations the compiler will not pass
> > such a cpumask_t in a register, ever.  An efficiency problem on sparc64,
> > apparently.
> 
> When I contacted Dave Miller about this specific problem on March 26,
> 2004, he explained that this was more of a problem on sparc32, and that
> since SMP on sparc32 wasn't in robust shape yet (my words), he seemed
> (from what I could tell) not to be objecting too strongly.
> 
> I've added Dave to the Cc list, in case he wants to add or something, or
> correct my efforts to represent his position.

Those were my feelings, but looking at this specific case why
can't you just change the type to be an aggregate when possible?
Is it really that hard?
