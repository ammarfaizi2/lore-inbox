Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265245AbUETWAX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265245AbUETWAX (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 20 May 2004 18:00:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265264AbUETWAX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 20 May 2004 18:00:23 -0400
Received: from palrel13.hp.com ([156.153.255.238]:27548 "EHLO palrel13.hp.com")
	by vger.kernel.org with ESMTP id S265245AbUETWAH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 20 May 2004 18:00:07 -0400
From: David Mosberger <davidm@napali.hpl.hp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16557.10848.19940.20498@napali.hpl.hp.com>
Date: Thu, 20 May 2004 15:00:00 -0700
To: Andrew Morton <akpm@osdl.org>
Cc: davidm@hpl.hp.com, hch@infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] fixing sendfile on 64bit architectures
In-Reply-To: <20040520145658.3a7bf7df.akpm@osdl.org>
References: <26879984$108499340940abaf81679ba6.07529629@config22.schlund.de>
	<16556.19979.951743.994128@napali.hpl.hp.com>
	<20040519234106.52b6db78.davem@redhat.com>
	<16556.65456.624986.552865@napali.hpl.hp.com>
	<20040520120645.3accf048.akpm@osdl.org>
	<16557.1651.307484.282000@napali.hpl.hp.com>
	<20040520203532.A11902@infradead.org>
	<16557.4709.694265.314748@napali.hpl.hp.com>
	<20040520145658.3a7bf7df.akpm@osdl.org>
X-Mailer: VM 7.18 under Emacs 21.3.1
Reply-To: davidm@hpl.hp.com
X-URL: http://www.hpl.hp.com/personal/David_Mosberger/
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> On Thu, 20 May 2004 14:56:58 -0700, Andrew Morton <akpm@osdl.org> said:

  >> I think the current patch is an improvement, so unless someone
  >> comes up with something better, I'd like to see it applied.

  Andrew> I do agree that ARCH_WANT_FOO is easier to understand and
  Andrew> more idiomatic.

That is true.  Actually, now that I have ARCH_OMIT, it's pretty easy
to write a script to do the complement, so the risk of introducing
errors is quite small.  Let me see what this looks like.

  Andrew> An alternative might be to remove all the ifdefs, build with
  Andrew> -ffunction-sections and let the linker drop any unreferenced
  Andrew> code...

Yeah, that might be an option.  -ffunction-sections does bad things to
link-time, though, and I'm not sure I like the idea of having a
bazillion of tiny little sections.

	--david
