Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S311928AbSCOETv>; Thu, 14 Mar 2002 23:19:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S311929AbSCOETc>; Thu, 14 Mar 2002 23:19:32 -0500
Received: from deimos.hpl.hp.com ([192.6.19.190]:33264 "EHLO deimos.hpl.hp.com")
	by vger.kernel.org with ESMTP id <S311928AbSCOETZ>;
	Thu, 14 Mar 2002 23:19:25 -0500
From: David Mosberger <davidm@napali.hpl.hp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15505.30281.414005.400815@napali.hpl.hp.com>
Date: Thu, 14 Mar 2002 20:19:21 -0800
To: Rusty Russell <rusty@rustcorp.com.au>
Cc: Andi Kleen <ak@suse.de>, davidm@hpl.hp.com, linux-kernel@vger.kernel.org,
        rth@twiddle.net
Subject: Re: [PATCH] 2.5.1-pre5: per-cpu areas 
In-Reply-To: <E16lj03-0007Zm-00@wagner.rustcorp.com.au>
In-Reply-To: <20020314195122.A30566@wotan.suse.de>
	<E16lj03-0007Zm-00@wagner.rustcorp.com.au>
X-Mailer: VM 7.01 under Emacs 21.1.1
Reply-To: davidm@hpl.hp.com
X-URL: http://www.hpl.hp.com/personal/David_Mosberger/
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> On Fri, 15 Mar 2002 15:07:27 +1100, Rusty Russell <rusty@rustcorp.com.au> said:

  Rusty> Sorry, after thought, I've reverted to my original position.  the
  Rusty> original SMP per_cpu()/this_cpu() implementations were broken.

  Rusty> They must return an lvalue, otherwise they're useless for 50% of cases
  Rusty> (ie. assignment).  x86_64 can still use its own mechanism for
  Rusty> arch-specific per-cpu data, of course.

What's your position about someone taking the address of this_cpu(foo)
and passing it to another CPU?  IMO, the effect of this should be
allowed to be implementation-dependent.  If you agree, perhaps it
would be good to add a comment to this effect?

	--david
