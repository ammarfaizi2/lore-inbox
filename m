Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261353AbUKFJv1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261353AbUKFJv1 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 6 Nov 2004 04:51:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261352AbUKFJv1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 6 Nov 2004 04:51:27 -0500
Received: from grendel.digitalservice.pl ([217.67.200.140]:37023 "HELO
	mail.digitalservice.pl") by vger.kernel.org with SMTP
	id S261351AbUKFJvO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 6 Nov 2004 04:51:14 -0500
From: "Rafael J. Wysocki" <rjw@sisk.pl>
To: Andi Kleen <ak@suse.de>
Subject: Re: breakage: flex mmap patch for x86-64
Date: Sat, 6 Nov 2004 10:50:27 +0100
User-Agent: KMail/1.6.2
Cc: Ricky Beam <jfbeam@bluetronic.net>, linux-kernel@vger.kernel.org,
       Andrew Morton <akpm@osdl.org>, arjanv@redhat.com
References: <200411060026.48571.rjw@sisk.pl> <Pine.GSO.4.33.0411060252370.9358-100000@sweetums.bluetronic.net> <20041106091240.GA4996@wotan.suse.de>
In-Reply-To: <20041106091240.GA4996@wotan.suse.de>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Message-Id: <200411061050.27304.rjw@sisk.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Saturday 06 of November 2004 10:12, Andi Kleen wrote:
> >  static inline int mmap_is_legacy(void)
> >  {
> > +       if (test_thread_flag(TIF_IA32))
> > +               return 1;
> 
> That's definitely not the right fix because for 32bit you need flexmmap
> more than for 64bit because it gives you more address space.

So let's call it temporary, but I like 32-bit apps having less address space 
rather than segfaulting.

Greets,
RJW

-- 
- Would you tell me, please, which way I ought to go from here?
- That depends a good deal on where you want to get to.
		-- Lewis Carroll "Alice's Adventures in Wonderland"
