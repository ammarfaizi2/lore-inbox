Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318991AbSHFFP7>; Tue, 6 Aug 2002 01:15:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318992AbSHFFP7>; Tue, 6 Aug 2002 01:15:59 -0400
Received: from deimos.hpl.hp.com ([192.6.19.190]:65506 "EHLO deimos.hpl.hp.com")
	by vger.kernel.org with ESMTP id <S318991AbSHFFP6>;
	Tue, 6 Aug 2002 01:15:58 -0400
From: David Mosberger <davidm@napali.hpl.hp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15695.23644.912136.988590@napali.hpl.hp.com>
Date: Mon, 5 Aug 2002 22:19:24 -0700
To: "David S. Miller" <davem@redhat.com>
Cc: davidm@hpl.hp.com, rohit.seth@intel.com, frankeh@watson.ibm.com,
       torvalds@transmeta.com, gh@us.ibm.com, Martin.Bligh@us.ibm.com,
       wli@holomorphy.com, linux-kernel@vger.kernel.org
Subject: Re: large page patch (fwd) (fwd)
In-Reply-To: <20020805.215817.05805181.davem@redhat.com>
References: <25282B06EFB8D31198BF00508B66D4FA03EA56CA@fmsmsx114.fm.intel.com>
	<15695.22556.128499.64377@napali.hpl.hp.com>
	<20020805.215817.05805181.davem@redhat.com>
X-Mailer: VM 7.07 under Emacs 21.2.1
Reply-To: davidm@hpl.hp.com
X-URL: http://www.hpl.hp.com/personal/David_Mosberger/
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> On Mon, 05 Aug 2002 21:58:17 -0700 (PDT), "David S. Miller" <davem@redhat.com> said:

  >>    From: David Mosberger <davidm@napali.hpl.hp.com> Date:
  >> Mon, 5 Aug 2002 22:01:16 -0700

  >>    In my opinion, this is perhaps the strongest argument
  >> *for* a separate "giant page" syscall interface.  It will be
  >> very hard (perhaps impossible) to optimize superpages to work
  >> efficiently when the ratio of superpage/basepage grows huge
  >> (as, by definition, the kernel would manage them as a set of
  >> basepages).

  DaveM> Actually, this is one of the reasons there was a lot of
  DaveM> research into using sub-page clustering for large mappings in
  DaveM> the TLB.  Basically how this worked is that for a superpage,
  DaveM> you could stick multiple sub-mappings into the entry such
  DaveM> that you didn't need a fully physically contiguous superpage.

Sounds great if you have the hardware that can do it.  Not too many
CPUs I know of support it.

	--david
