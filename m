Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317091AbSFFVTG>; Thu, 6 Jun 2002 17:19:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317185AbSFFVTF>; Thu, 6 Jun 2002 17:19:05 -0400
Received: from deimos.hpl.hp.com ([192.6.19.190]:45010 "EHLO deimos.hpl.hp.com")
	by vger.kernel.org with ESMTP id <S317091AbSFFVTE>;
	Thu, 6 Jun 2002 17:19:04 -0400
From: David Mosberger <davidm@napali.hpl.hp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15615.53702.794957.958227@napali.hpl.hp.com>
Date: Thu, 6 Jun 2002 14:19:02 -0700
To: "Ulrich Weigand" <Ulrich.Weigand@de.ibm.com>
Cc: davidm@hpl.hp.com, Andi Kleen <ak@suse.de>, linux-kernel@vger.kernel.org
Subject: Re: [RFC] 4KB stack + irq stack for x86
In-Reply-To: <OF81A861D7.0F84A7BA-ONC1256BD0.0072344C@de.ibm.com>
X-Mailer: VM 7.03 under Emacs 21.2.1
Reply-To: davidm@hpl.hp.com
X-URL: http://www.hpl.hp.com/personal/David_Mosberger/
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> On Thu, 6 Jun 2002 22:55:12 +0200, "Ulrich Weigand" <Ulrich.Weigand@de.ibm.com> said:

  Uli> So in the case of 8K page size, you need an order-2 allocation
  Uli> for the stack, right?  How do you handle failures due to
  Uli> fragmentation?

We don't do anything special.  I'm not sure what the fragmentation
statistics look like on machines with 1+GB memory; it's something I
have been wondering about and hoping to look into at some point (if
someone has done that already, I'd love to see the results).  In
practice, every ia64 linux distro as of today ships with 16KB page
size, so you only get order-1 allocations for stacks.

	--david
