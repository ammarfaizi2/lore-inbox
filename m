Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129296AbQKBXWO>; Thu, 2 Nov 2000 18:22:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129596AbQKBXWE>; Thu, 2 Nov 2000 18:22:04 -0500
Received: from ra.lineo.com ([204.246.147.10]:53157 "EHLO thor.lineo.com")
	by vger.kernel.org with ESMTP id <S129296AbQKBXVo>;
	Thu, 2 Nov 2000 18:21:44 -0500
Message-ID: <3A01F5B1.CD499EF4@Rikers.org>
Date: Thu, 02 Nov 2000 16:16:01 -0700
From: Tim Riker <Tim@Rikers.org>
Organization: Riker Family (http://rikers.org/)
X-Accept-Language: en
MIME-Version: 1.0
To: "Theodore Y. Ts'o" <tytso@MIT.EDU>
CC: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: non-gcc linux? (was Re: Where did kgcc go in 2.4.0-test10?)
In-Reply-To: <200011022246.RAA21440@tsx-prime.MIT.EDU>
X-MIMETrack: Serialize by Router on thor/Lineo(Release 5.0.5 |September 22, 2000) at 11/02/2000
 04:21:41 PM,
	Serialize complete at 11/02/2000 04:21:41 PM
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ted

Agreed. C99 does not replace all the needed gcc features. We should
start using the ones that make sense, and push for
standardization/documentation on the rest.

I'm perfectly happy with this as a long term goal. I'll put what effort
I can into moving that direction without breaking the existing world as
we know it.

Tim

"Theodore Y. Ts'o" wrote:
> 
>    Date: Thu, 02 Nov 2000 13:53:55 -0700
>    From: Tim Riker <Tim@Rikers.org>
> 
>    As is being discussed here, C99 has some replacements to the gcc syntax
>    the kernel uses. I believe the C99 syntax will win in the near future,
>    and thus the gcc syntax will have to be removed at some point. In the
>    interim the kernel will either move towards supporting both, or a
>    quantum jump to support the new gcc3+ compiler only. I am hoping a
>    little thought can get put into this such that this change will be less
>    painful down the road.
> 
> That's reasonable as a long-term goal.  Keep in mind that though there
> have been questions in the past about code correctness assumptions of
> kernel versus specific GCC versions.  This has been one place where GCC
> has tended to blame the kernel developers, and kernel developers have
> pointed out (rightly, in my opinion) that the GCC documentation of some
> of these features has been less than stellar --- in fact, some would say
> non-existent.  If it's not documented, then you don't have much moral
> ground to stand upon when people complain that the changes you made
> breaks things.
> 
> So moving to a C99 syntax is useful simply from the point of view that
> it's well documented (unlike the register constraints for inline
> functions, which still give me a headache whenever I try to look at the
> GCC "documentation").  The problem here is that C99 doesn't (as far as I
> know) give us everything we need, so simply moving to C99 syntax won't
> be sufficient to support propietary C compilers.
> 
> There will also be work needed to make sure that a kernel compiled with
> gcc 3.x (whenever it's ready) will actually omit code which was intended
> by the kernel developers.  So we're definitely looking at a 2.5+

omit? did you mean emit?

> project, and one which may actually be fairly high risk; it's certainly
> not a trivial task.
> 
>                                                 - Ted

-- 
Tim Riker - http://rikers.org/ - short SIGs! <g>
All I need to know I could have learned in Kindergarten
... if I'd just been paying attention.
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
