Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268712AbRGZWZi>; Thu, 26 Jul 2001 18:25:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267837AbRGZWZ2>; Thu, 26 Jul 2001 18:25:28 -0400
Received: from juicer14.bigpond.com ([139.134.6.23]:14038 "EHLO
	mailin2.email.bigpond.com") by vger.kernel.org with ESMTP
	id <S268717AbRGZWZP>; Thu, 26 Jul 2001 18:25:15 -0400
From: Rusty Russell <rusty@rustcorp.com.au>
To: Andrea Arcangeli <andrea@suse.de>
Cc: torvalds@transmeta.com, linux-kernel@vger.kernel.org
Subject: Re: 2.4.7 softirq incorrectness. 
In-Reply-To: Your message of "Wed, 25 Jul 2001 21:33:51 +0200."
             <20010725213351.A32148@athlon.random> 
Date: Fri, 27 Jul 2001 06:26:54 +1000
Message-Id: <E15Pril-0004aT-00@localhost>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org
Original-Recipient: rfc822;linux-kernel-outgoing

In message <20010725213351.A32148@athlon.random> you write:
> You are wrong, please check again all the code involved.

Apologies: you are absolutely correct, disregard my crap patch.
local_irq_save does not inc local_irq_count, unlike local_bh_disable.
Oops.

> do_softirq can be re-entered but on re-entry it will return immediatly

"immediately" leaves a narrow window.  Sure, it'd be really hard to
hit, but it's still there.

Rusty.
--
Premature optmztion is rt of all evl. --DK
