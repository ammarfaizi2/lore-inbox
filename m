Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261476AbSJAEUU>; Tue, 1 Oct 2002 00:20:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261477AbSJAEUU>; Tue, 1 Oct 2002 00:20:20 -0400
Received: from pizda.ninka.net ([216.101.162.242]:28856 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S261476AbSJAEUT>;
	Tue, 1 Oct 2002 00:20:19 -0400
Date: Mon, 30 Sep 2002 21:18:48 -0700 (PDT)
Message-Id: <20020930.211848.131274580.davem@redhat.com>
To: mingo@elte.hu
Cc: george@mvista.com, torvalds@transmeta.com, linux-kernel@vger.kernel.org,
       wli@holomorphy.com, dipankar@in.ibm.com, kuznet@ms2.inr.ac.ru
Subject: Re: [patch] smptimers, old BH removal, tq-cleanup, 2.5.39
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <Pine.LNX.4.44.0210010542240.2564-100000@localhost.localdomain>
References: <3D98C60B.9C1EA90B@mvista.com>
	<Pine.LNX.4.44.0210010542240.2564-100000@localhost.localdomain>
X-FalunGong: Information control.
X-Mailer: Mew version 2.1 on Emacs 21.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: Ingo Molnar <mingo@elte.hu>
   Date: Tue, 1 Oct 2002 05:51:45 +0200 (CEST)

   -	/*
   -	 * ok, Intel has some smart code in their APIC that knows
   -	 * if a CPU was in 'hlt' lowpower mode, and this increases
   -	 * its APIC arbitration priority. To avoid the external timer
   -	 * IRQ APIC event being in synchron with the APIC clock we
   -	 * introduce an interrupt skew to spread out timer events.
   -	 *
   -	 * The number of slices within a 'big' timeslice is NR_CPUS+1
   -	 */
   -

I did some thinking, and I don't understand how this old code
can be legal.  Doesn't this make do_gettimeofday() inaccurate?

I must be missing something.
