Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292212AbSBTTJR>; Wed, 20 Feb 2002 14:09:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292216AbSBTTI5>; Wed, 20 Feb 2002 14:08:57 -0500
Received: from deimos.hpl.hp.com ([192.6.19.190]:51656 "EHLO deimos.hpl.hp.com")
	by vger.kernel.org with ESMTP id <S292212AbSBTTIw>;
	Wed, 20 Feb 2002 14:08:52 -0500
From: David Mosberger <davidm@hpl.hp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15475.62505.876859.287751@napali.hpl.hp.com>
Date: Wed, 20 Feb 2002 11:08:25 -0800
To: Rik van Riel <riel@conectiva.com.br>
Cc: Mike Fedyk <mfedyk@matchmail.com>, Ville Herva <vherva@twilight.cs.hut.fi>,
        george anzinger <george@mvista.com>, <linux-kernel@vger.kernel.org>
Subject: Re: jiffies rollover, uptime etc.
In-Reply-To: <Pine.LNX.4.44L.0202201423170.1413-100000@duckman.distro.conectiva>
In-Reply-To: <20020220172052.GA15228@matchmail.com>
	<Pine.LNX.4.44L.0202201423170.1413-100000@duckman.distro.conectiva>
X-Mailer: VM 7.00 under Emacs 21.1.1
Reply-To: davidm@hpl.hp.com
X-URL: http://www.hpl.hp.com/personal/David_Mosberger/
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> On Wed, 20 Feb 2002 14:24:42 -0300 (BRT), Rik van Riel <riel@conectiva.com.br> said:

  Rik> On Wed, 20 Feb 2002, Mike Fedyk wrote:

  >> What's the difference between these two architectures?  Intel
  >> 64bit processor and AMD's upcoming 64bit processor?

  Rik> One is a 64 bit extension to a modern superscalar architecture
  Rik> which has descended from 8 bit machines over the ages.

Interesting opinion.

  Rik> The other is a 3-issue VLIW follow-up to the 2-issue VLIW i860.

There are some factual errors in this statement:

The ia64 _architecture_ places no limit on how many instructions can
be issued at a time.  You could have an instruction group that's
thousands of instructions long which could all be executed in a single
cycle.  Of course, realistic CPUs will bound the number of
instructions that can be issued in parallel.  The Itanium and McKinley
_implementations_ of ia64 happen to issue up to 6 instructions at a
time, but other issue-widths are possible.

To the best of my knowledge, i860 had virtually no influence on ia64.
Cydrome's Cydra5 and Multiflow's TRACE did, as did PA-RISC.

Thanks,

	--david
