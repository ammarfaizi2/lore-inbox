Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289496AbSAJPa6>; Thu, 10 Jan 2002 10:30:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289499AbSAJPas>; Thu, 10 Jan 2002 10:30:48 -0500
Received: from motgate2.mot.com ([136.182.1.10]:45037 "EHLO motgate2.mot.com")
	by vger.kernel.org with ESMTP id <S289496AbSAJPag>;
	Thu, 10 Jan 2002 10:30:36 -0500
Date: Thu, 10 Jan 2002 10:30:14 -0500
Message-Id: <200201101530.g0AFUEA00462@hyper.wm.sps.mot.com>
From: Peter Barada <pbarada@mail.wm.sps.mot.com>
To: fjh@cs.mu.oz.au
CC: gcc@gcc.gnu.org, linux-kernel@vger.kernel.org
In-Reply-To: <20020110124702.B30669@hg.cs.mu.oz.au> (message from Fergus
	Henderson on Thu, 10 Jan 2002 12:47:02 +1100)
Subject: Re: [PATCH] C undefined behavior fix
In-Reply-To: <20020108012734.E23665@werewolf.able.es> <20020109204043.T1027-100000@gerard> <20020110004952.A11641@werewolf.able.es> <200201100019.g0A0JOM32110@hyper.wm.sps.mot.com> <20020110124702.B30669@hg.cs.mu.oz.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


>No, you're wrong here.  That would violate the following provisions of
>the C99 standard, because the two accesses to `a' would not have occurred.
>(It would also violate similar provisions of the C89 and C++ standards.)
>The "as if" rule -- which is stated in 5.1.2.3 [#3] in C99 -- is explicitly
>defined to NOT allow optimizing away accesses to volatile objects.
>
> |        [#3] In the abstract machine, all expressions are  evaluated
> |        as  specified  by  the  semantics.  An actual implementation
> |        need not evaluate part of an expression  if  it  can  deduce
> |        that  its  value is not used and that no needed side effects
> |        are produced (including any caused by calling a function  or
> |        accessing a volatile object).

Ahh, I see now said the blind man...  When I read over this, I homed in
on "An actual emplementation need not evaluate part of the expression
if it can deduce that its value is not needed", and conveniently
skipped the rest of the sentence.

My Bad.

-- 
Peter Barada                                   Peter.Barada@motorola.com
Wizard                                         781-852-2768 (direct)
WaveMark Solutions(wholly owned by Motorola)   781-270-0193 (fax)
