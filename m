Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265520AbUFDCCn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265520AbUFDCCn (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Jun 2004 22:02:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265527AbUFDCCn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Jun 2004 22:02:43 -0400
Received: from smtp106.mail.sc5.yahoo.com ([66.163.169.226]:56928 "HELO
	smtp106.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S265520AbUFDCCm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Jun 2004 22:02:42 -0400
Message-ID: <40BFD839.7060101@yahoo.com.au>
Date: Fri, 04 Jun 2004 12:02:33 +1000
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040401 Debian/1.6-4
X-Accept-Language: en
MIME-Version: 1.0
To: Rusty Russell <rusty@rustcorp.com.au>
CC: Paul Jackson <pj@sgi.com>,
       lkml - Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>, Andi Kleen <ak@muc.de>,
       Ashok Raj <ashok.raj@intel.com>, Christoph Hellwig <hch@infradead.org>,
       Jesse Barnes <jbarnes@sgi.com>, Joe Korty <joe.korty@ccur.com>,
       Manfred Spraul <manfred@colorfullife.com>,
       Matthew Dobson <colpatch@us.ibm.com>,
       Mikael Pettersson <mikpe@csd.uu.se>, Simon Derr <Simon.Derr@bull.net>,
       William Lee Irwin III <wli@holomorphy.com>
Subject: Re: [PATCH] cpumask 5/10 rewrite cpumask.h - single bitmap based
 implementation
References: <20040603094339.03ddfd42.pj@sgi.com>	 <20040603101010.4b15734a.pj@sgi.com> <1086313667.29381.897.camel@bach>
In-Reply-To: <1086313667.29381.897.camel@bach>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Rusty Russell wrote:

> We've discussed this before when talking about whether it'd be easier to
> just make people use raw bitop functions directly, so I know we have
> philosophical differences here.
> 
> So, opinion alert: if I were doing this, I'd probably live without this
> macro; in my mind it crosses the "too much abstraction" line.  I did
> momentarily wonder what this macro did when I saw it used in the
> succeeding patches.
> 

I think if you don't like that abstraction, there should be no
cpumask type at all, just use the bitmap.

I don't see what you gain from having the cpumask type but having
to get at its internals with the bitop functions.


> But it's a minor nit; thanks for doing these.
> 

Yeah it looks quite good
