Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317263AbSHCEWO>; Sat, 3 Aug 2002 00:22:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317440AbSHCEWO>; Sat, 3 Aug 2002 00:22:14 -0400
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:18442 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S317263AbSHCEWO>; Sat, 3 Aug 2002 00:22:14 -0400
Date: Fri, 2 Aug 2002 21:26:52 -0700 (PDT)
From: Linus Torvalds <torvalds@transmeta.com>
To: davidm@hpl.hp.com
cc: Gerrit Huizenga <gh@us.ibm.com>, Hubertus Franke <frankeh@watson.ibm.com>,
       <Martin.Bligh@us.ibm.com>, <wli@holomorpy.com>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: large page patch (fwd) (fwd) 
In-Reply-To: <15691.22889.22452.194180@napali.hpl.hp.com>
Message-ID: <Pine.LNX.4.44.0208022125040.2694-100000@home.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Fri, 2 Aug 2002, David Mosberger wrote:
>
> My terminology is perhaps a bit too subtle: I user "superpage"
> exclusively for the case where multiple pages get coalesced into a
> larger page.  The "large page" ("huge page") case that you were
> talking about is different, since pages never get demoted or promoted.

Ahh, ok.

> I wasn't disagreeing with your case for separate large page syscalls.
> Those syscalls certainly simplify implementation and, as you point
> out, it well may be the case that a transparent superpage scheme never
> will be able to replace the former.

Somebody already had patches for the transparent superpage thing for
alpha, which supports it. I remember seeing numbers implying that helped
noticeably.

But yes, that definitely doesn't work for humongous pages (or whatever we
should call the multi-megabyte-special-case-thing ;).

		Linus

