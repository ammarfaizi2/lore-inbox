Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317506AbSGOPqA>; Mon, 15 Jul 2002 11:46:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317517AbSGOPp7>; Mon, 15 Jul 2002 11:45:59 -0400
Received: from deimos.hpl.hp.com ([192.6.19.190]:44025 "EHLO deimos.hpl.hp.com")
	by vger.kernel.org with ESMTP id <S317506AbSGOPp5>;
	Mon, 15 Jul 2002 11:45:57 -0400
From: David Mosberger <davidm@napali.hpl.hp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15666.61141.799053.70367@napali.hpl.hp.com>
Date: Mon, 15 Jul 2002 08:48:37 -0700
To: Russell King <rmk@arm.linux.org.uk>
Cc: "Albert D. Cahalan" <acahalan@cs.uml.edu>,
       Linus Torvalds <torvalds@transmeta.com>, linux-kernel@vger.kernel.org
Subject: Re: HZ, preferably as small as possible
In-Reply-To: <20020715092411.A12082@flint.arm.linux.org.uk>
References: <agtlq6$iht$1@penguin.transmeta.com>
	<200207150656.g6F6uFx178288@saturn.cs.uml.edu>
	<20020715092411.A12082@flint.arm.linux.org.uk>
X-Mailer: VM 7.03 under Emacs 21.2.1
Reply-To: davidm@hpl.hp.com
X-URL: http://www.hpl.hp.com/personal/David_Mosberger/
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> On Mon, 15 Jul 2002 09:24:11 +0100, Russell King <rmk@arm.linux.org.uk> said:

  Russell> On Mon, Jul 15, 2002 at 02:56:14AM -0400, Albert D. Cahalan
  Russell> wrote:
  >> Unfortunately, the hack must remain for another 4 years or so.
  >> Maybe that's not so bad though. I prefer it over this:
  >> 
  >> #ifdef __386__ #define HZ 100 #endif #ifdef __IA64__ #define HZ
  >> 1024 #endif #ifdef __ARM__ #define HZ 128 // if they settle on
  >> this

  Russell> Ehh?  It's been 100 on the majority of ARM.  If it's
  Russell> different in libproc, the libproc is broken.

libproc should be using AT_CLKTCK (as provided via sysconf(_SC_CLK_TCK))
at any rate.

	--david
