Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290685AbSBLBWD>; Mon, 11 Feb 2002 20:22:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290675AbSBLBVy>; Mon, 11 Feb 2002 20:21:54 -0500
Received: from deimos.hpl.hp.com ([192.6.19.190]:46801 "EHLO deimos.hpl.hp.com")
	by vger.kernel.org with ESMTP id <S290677AbSBLBVn>;
	Mon, 11 Feb 2002 20:21:43 -0500
From: David Mosberger <davidm@hpl.hp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15464.28196.894340.327685@napali.hpl.hp.com>
Date: Mon, 11 Feb 2002 17:21:40 -0800
To: "David S. Miller" <davem@redhat.com>
Cc: davidm@hpl.hp.com, anton@samba.org, linux-kernel@vger.kernel.org,
        zippel@linux-m68k.org
Subject: Re: thread_info implementation
In-Reply-To: <20020211.170709.118972278.davem@redhat.com>
In-Reply-To: <20020211.164617.39155905.davem@redhat.com>
	<200202120101.g1C11OJZ010115@napali.hpl.hp.com>
	<20020211.170709.118972278.davem@redhat.com>
X-Mailer: VM 7.00 under Emacs 21.1.1
Reply-To: davidm@hpl.hp.com
X-URL: http://www.hpl.hp.com/personal/David_Mosberger/
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> On Mon, 11 Feb 2002 17:07:09 -0800 (PST), "David S. Miller" <davem@redhat.com> said:

  DaveM> I didn't have to change any of my locore code, what the heck
  DaveM> are you talking about? :-) All of the changes to _ANY_
  DaveM> assembly on sparc64 looked like this:

The task pointer lives in the thread pointer register (r13), so it's
trivial to address off of it.  The stack pointer is a poor replacement
for that.  The bit-masking that the x86 code is doing to get the
thread info pointer atrocious and is part of the reason task coloring
is harder to do on x86.

	--david
