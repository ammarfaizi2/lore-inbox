Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261974AbTJSQFK (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 19 Oct 2003 12:05:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261982AbTJSQFK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 19 Oct 2003 12:05:10 -0400
Received: from natsmtp00.rzone.de ([81.169.145.165]:7552 "EHLO
	natsmtp00.webmailer.de") by vger.kernel.org with ESMTP
	id S261974AbTJSQFE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 19 Oct 2003 12:05:04 -0400
Message-ID: <3F92B62C.8020602@softhome.net>
Date: Sun, 19 Oct 2003 18:05:00 +0200
From: "Ihar 'Philips' Filipau" <filia@softhome.net>
Organization: Home Sweet Home
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.5) Gecko/20030927
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: "Martin J. Bligh" <fletch@aracnet.com>
CC: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [2.6 patch] add a config option for -Os compilation
References: <I2Ue.7PG.3@gated-at.bofh.it> <I2Ue.7PG.5@gated-at.bofh.it> <I2Ue.7PG.7@gated-at.bofh.it> <I2Ue.7PG.9@gated-at.bofh.it> <I2Ue.7PG.11@gated-at.bofh.it> <I2Ue.7PG.13@gated-at.bofh.it> <I2Ue.7PG.1@gated-at.bofh.it> <ImzK.4TR.25@gated-at.bofh.it> <ImzK.4TR.23@gated-at.bofh.it> <InYQ.6OJ.21@gated-at.bofh.it>
In-Reply-To: <InYQ.6OJ.21@gated-at.bofh.it>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Martin J. Bligh wrote:
> 
> But if someone with a small cache would actually *measure* the damned 
> thing, I'd be more impressed ... I've never seen that, but perhaps
> I just missed it. 
> 
> Point is the same either way though ... we shouldn't unconditionally
> optimise for *anyone's* system. If it's faster on all systems that anyone
> can be bothered to measure, great. If it's faster on some, and slower on
> others, a config option seems more appropriate, defaulting to the majority
> of users.
> 

   The thing is, that in fact kernel optimization is not that important.

   The goal of kernel is to provide framework for applications to the 
job well. I wasn't doing any kernels measurements - since kernel docs 
are saying that -O2 is the standard. And it is really hard to measure 
kernel only perfomance. (And it is rather pointless - I'm not going to 
sell linux kernel ;-)))

   But indeed I was testing my application on embedded system with 16K 
L1 cache. Results were pretty predictable: gcc 2.95.3 + -Os was giving 
some (around 2-3%) performance improvements, while 2.95.3 + -O[23] and 
3.2.3 with any optimization were giving aprox. the same times. (App is 
bloated with third-party libraries, C++ and threads. Save God I have 
killed all exceptions - they were really really really slow on target 
system.)

   But on other side - since embedded systems are not that overclocked 
as high-end toys - cache miss is not that painful. As of docs, NatSemi 
Geode@266MHz cache miss costs exactly 266/66 == 4 cycles.

-- 
Ihar 'Philips' Filipau  / with best regards from Saarbruecken.
--
   "... and for $64000 question, could you get yourself vaguely
      familiar with the notion of on-topic posting?"
				-- Al Viro @ LKML

