Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317448AbSHCEgQ>; Sat, 3 Aug 2002 00:36:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317457AbSHCEgQ>; Sat, 3 Aug 2002 00:36:16 -0400
Received: from deimos.hpl.hp.com ([192.6.19.190]:4816 "EHLO deimos.hpl.hp.com")
	by vger.kernel.org with ESMTP id <S317448AbSHCEgP>;
	Sat, 3 Aug 2002 00:36:15 -0400
From: David Mosberger <davidm@napali.hpl.hp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15691.24200.512998.875390@napali.hpl.hp.com>
Date: Fri, 2 Aug 2002 21:39:36 -0700
To: Linus Torvalds <torvalds@transmeta.com>
Cc: davidm@hpl.hp.com, Gerrit Huizenga <gh@us.ibm.com>,
       Hubertus Franke <frankeh@watson.ibm.com>, <Martin.Bligh@us.ibm.com>,
       <wli@holomorpy.com>, Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: large page patch (fwd) (fwd) 
In-Reply-To: <Pine.LNX.4.44.0208022125040.2694-100000@home.transmeta.com>
References: <15691.22889.22452.194180@napali.hpl.hp.com>
	<Pine.LNX.4.44.0208022125040.2694-100000@home.transmeta.com>
X-Mailer: VM 7.07 under Emacs 21.2.1
Reply-To: davidm@hpl.hp.com
X-URL: http://www.hpl.hp.com/personal/David_Mosberger/
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> On Fri, 2 Aug 2002 21:26:52 -0700 (PDT), Linus Torvalds <torvalds@transmeta.com> said:

  >> I wasn't disagreeing with your case for separate large page
  >> syscalls.  Those syscalls certainly simplify implementation and,
  >> as you point out, it well may be the case that a transparent
  >> superpage scheme never will be able to replace the former.

  Linus> Somebody already had patches for the transparent superpage
  Linus> thing for alpha, which supports it. I remember seeing numbers
  Linus> implying that helped noticeably.

Yes, I saw those.  I still like the Rice work a _lot_ better.  It's
just a thing of beauty, from a design point of view (disclaimer: I
haven't seen the implementation, so there may be ugly things
lurking...).

  Linus> But yes, that definitely doesn't work for humongous pages (or
  Linus> whatever we should call the multi-megabyte-special-case-thing
  Linus> ;).

Yes, you're probably right.  2MB was reported to be fine in the Rice
experiments, but I doubt 256MB (and much less 4GB, as supported by
some CPUs) would fly.

	--david
