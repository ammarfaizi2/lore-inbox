Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317662AbSHCSlU>; Sat, 3 Aug 2002 14:41:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317698AbSHCSlU>; Sat, 3 Aug 2002 14:41:20 -0400
Received: from e35.co.us.ibm.com ([32.97.110.133]:35721 "EHLO
	e35.co.us.ibm.com") by vger.kernel.org with ESMTP
	id <S317662AbSHCSlU>; Sat, 3 Aug 2002 14:41:20 -0400
Content-Type: text/plain; charset=US-ASCII
From: Hubertus Franke <frankeh@watson.ibm.com>
Reply-To: frankeh@watson.ibm.com
Organization: IBM Research
To: davidm@hpl.hp.com, David Mosberger <davidm@napali.hpl.hp.com>,
       Linus Torvalds <torvalds@transmeta.com>
Subject: Re: large page patch (fwd) (fwd)
Date: Sat, 3 Aug 2002 14:41:29 -0400
User-Agent: KMail/1.4.1
Cc: davidm@hpl.hp.com, Gerrit Huizenga <gh@us.ibm.com>,
       <Martin.Bligh@us.ibm.com>, <wli@holomorpy.com>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <15691.22889.22452.194180@napali.hpl.hp.com> <Pine.LNX.4.44.0208022125040.2694-100000@home.transmeta.com> <15691.24200.512998.875390@napali.hpl.hp.com>
In-Reply-To: <15691.24200.512998.875390@napali.hpl.hp.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <200208031441.29353.frankeh@watson.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Saturday 03 August 2002 12:39 am, David Mosberger wrote:
> >>>>> On Fri, 2 Aug 2002 21:26:52 -0700 (PDT), Linus Torvalds
> >>>>> <torvalds@transmeta.com> said:
>   >>
>   >> I wasn't disagreeing with your case for separate large page
>   >> syscalls.  Those syscalls certainly simplify implementation and,
>   >> as you point out, it well may be the case that a transparent
>   >> superpage scheme never will be able to replace the former.
>
>   Linus> Somebody already had patches for the transparent superpage
>   Linus> thing for alpha, which supports it. I remember seeing numbers
>   Linus> implying that helped noticeably.
>
> Yes, I saw those.  I still like the Rice work a _lot_ better.  It's
> just a thing of beauty, from a design point of view (disclaimer: I
> haven't seen the implementation, so there may be ugly things
> lurking...).
>

I agree, the Rice solution is ellegant in the promotion and demotion.

>   Linus> But yes, that definitely doesn't work for humongous pages (or
>   Linus> whatever we should call the multi-megabyte-special-case-thing
>   Linus> ;).
>
> Yes, you're probably right.  2MB was reported to be fine in the Rice
> experiments, but I doubt 256MB (and much less 4GB, as supported by
> some CPUs) would fly.
>
> 	--david

As if the page coloring, it certainly helps.
But I'd like to point out that superpages are there to reduce the number of
TLB misses by providing larger coverage. Simply providing page coloring
will not get you there. 


-- 
-- Hubertus Franke  (frankeh@watson.ibm.com)
