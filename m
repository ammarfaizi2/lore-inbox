Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317815AbSHCVW7>; Sat, 3 Aug 2002 17:22:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317817AbSHCVW7>; Sat, 3 Aug 2002 17:22:59 -0400
Received: from phobos.hpl.hp.com ([192.6.19.124]:38603 "EHLO phobos.hpl.hp.com")
	by vger.kernel.org with ESMTP id <S317815AbSHCVW6>;
	Sat, 3 Aug 2002 17:22:58 -0400
From: David Mosberger <davidm@napali.hpl.hp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15692.19075.541249.977133@napali.hpl.hp.com>
Date: Sat, 3 Aug 2002 14:26:27 -0700
To: frankeh@watson.ibm.com
Cc: davidm@hpl.hp.com, David Mosberger <davidm@napali.hpl.hp.com>,
       Linus Torvalds <torvalds@transmeta.com>,
       Gerrit Huizenga <gh@us.ibm.com>, <Martin.Bligh@us.ibm.com>,
       <wli@holomorpy.com>, Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: large page patch (fwd) (fwd)
In-Reply-To: <200208031653.39827.frankeh@watson.ibm.com>
References: <15691.22889.22452.194180@napali.hpl.hp.com>
	<200208031441.29353.frankeh@watson.ibm.com>
	<15692.12781.344389.519591@napali.hpl.hp.com>
	<200208031653.39827.frankeh@watson.ibm.com>
X-Mailer: VM 7.07 under Emacs 21.2.1
Reply-To: davidm@hpl.hp.com
X-URL: http://www.hpl.hp.com/personal/David_Mosberger/
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> On Sat, 3 Aug 2002 16:53:39 -0400, Hubertus Franke <frankeh@watson.ibm.com> said:

  Hubertus> Cool.  Does that mean that BSD already has page coloring
  Hubertus> implemented ?

FreeBSD (at least on Alpha) makes some attempts at page-coloring, but
it's said to be far from perfect.

  Hubertus> The agony is: Page Coloring helps to reduce cache
  Hubertus> conflicts in low associative caches while large pages may
  Hubertus> reduce TLB overhead.

Why agony?  The latter helps the TLB _and_ solves the page coloring
problem (assuming the largest page size is bigger than the largest
cache; yeah, I see that could be a problem on some Power 4
machines... ;-)

  Hubertus> One shouldn't rule out one for the other, there is a place
  Hubertus> for both.

  Hubertus> How did you arrive to the (weak) empirical evidence?  You
  Hubertus> checked TLB misses and cache misses and turned page
  Hubertus> coloring on and off and large pages on and off?

Yes, that's basically what we did (there is a patch implementing a
page coloring kernel module floating around).

	--david
