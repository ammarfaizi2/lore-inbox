Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S273789AbRIRAS5>; Mon, 17 Sep 2001 20:18:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S273788AbRIRASr>; Mon, 17 Sep 2001 20:18:47 -0400
Received: from maynard.mail.mindspring.net ([207.69.200.243]:62504 "EHLO
	maynard.mail.mindspring.net") by vger.kernel.org with ESMTP
	id <S273787AbRIRASc>; Mon, 17 Sep 2001 20:18:32 -0400
Subject: Re: [SMP lock BUG?] Re: Feedback on preemptible kernel patch
From: Robert Love <rml@tech9.net>
To: Manfred Spraul <manfred@colorfullife.com>
Cc: Pavel Machek <pavel@suse.cz>, Roger Larsson <roger.larsson@norran.net>,
        linux-kernel@vger.kernel.org, nigel@nrg.org
In-Reply-To: <003b01c13fc9$d04a4830$010411ac@local>
In-Reply-To: <000901c138bbe151270/mnt/sendme10411ac@local>
	<1000007070.836.14.camel@phantasy>
	<001a01c1390262c7f30/mnt/sendme10411ac@local>
	<20010914091558.A35@toy.ucw.cz>  <003b01c13fc9$d04a4830$010411ac@local>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution/0.13.99+cvs.2001.09.17.07.08 (Preview Release)
Date: 17 Sep 2001 20:19:28 -0400
Message-Id: <1000772375.12771.8.camel@phantasy>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2001-09-17 at 18:40, Manfred Spraul wrote:
> > is it legal to kmap_atomic(a,b); kmap_atomic(c,d); kunmap_atomic(a,b);
>
> Yes, that's legal - just think about one kmap_atomic from process
> context, and another one in irq context.
> 
> > If so, your patch may need some ounting....
> > Pavel
> 
> I hope ctx_sw_off does internal counting, correct?

yes, ctx_sw_off atomically increments a counter and ctx_sw_on
atomic_dec_and_test()s it.

-- 
Robert M. Love
rml at ufl.edu
rml at tech9.net

