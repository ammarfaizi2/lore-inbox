Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317435AbSHCEOW>; Sat, 3 Aug 2002 00:14:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317440AbSHCEOW>; Sat, 3 Aug 2002 00:14:22 -0400
Received: from deimos.hpl.hp.com ([192.6.19.190]:19657 "EHLO deimos.hpl.hp.com")
	by vger.kernel.org with ESMTP id <S317435AbSHCEOV>;
	Sat, 3 Aug 2002 00:14:21 -0400
From: David Mosberger <davidm@napali.hpl.hp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15691.22889.22452.194180@napali.hpl.hp.com>
Date: Fri, 2 Aug 2002 21:17:45 -0700
To: Linus Torvalds <torvalds@transmeta.com>
Cc: <davidm@hpl.hp.com>, Gerrit Huizenga <gh@us.ibm.com>,
       Hubertus Franke <frankeh@watson.ibm.com>, <Martin.Bligh@us.ibm.com>,
       <wli@holomorpy.com>, Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: large page patch (fwd) (fwd) 
In-Reply-To: <Pine.LNX.4.33.0208022030170.2083-100000@penguin.transmeta.com>
References: <15691.19423.265864.413887@napali.hpl.hp.com>
	<Pine.LNX.4.33.0208022030170.2083-100000@penguin.transmeta.com>
X-Mailer: VM 7.07 under Emacs 21.2.1
Reply-To: davidm@hpl.hp.com
X-URL: http://www.hpl.hp.com/personal/David_Mosberger/
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> On Fri, 2 Aug 2002 20:32:10 -0700 (PDT), Linus Torvalds <torvalds@transmeta.com> said:

  >> And since superpages quickly become counter-productive in
  >> tight-memory situations anyhow, this seems like a very reasonable
  >> approach.

  Linus> Ehh.. The only people who are _really_ asking for the
  Linus> superpages want almost nothing _but_ superpages. They are
  Linus> willing to use 80% of all memory for just superpages.

  Linus> Yes, it's Oracle etc, and the whole point for these users is
  Linus> to avoid having any OS memory allocation for these areas.

My terminology is perhaps a bit too subtle: I user "superpage"
exclusively for the case where multiple pages get coalesced into a
larger page.  The "large page" ("huge page") case that you were
talking about is different, since pages never get demoted or promoted.

I wasn't disagreeing with your case for separate large page syscalls.
Those syscalls certainly simplify implementation and, as you point
out, it well may be the case that a transparent superpage scheme never
will be able to replace the former.

	--david
