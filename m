Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261426AbVGYSzl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261426AbVGYSzl (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 25 Jul 2005 14:55:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261430AbVGYSzk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 25 Jul 2005 14:55:40 -0400
Received: from prgy-npn1.prodigy.com ([207.115.54.37]:32772 "EHLO
	oddball.prodigy.com") by vger.kernel.org with ESMTP id S261426AbVGYSzj
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 25 Jul 2005 14:55:39 -0400
Message-ID: <42E536A5.8060007@tmr.com>
Date: Mon, 25 Jul 2005 14:59:49 -0400
From: Bill Davidsen <davidsen@tmr.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.8) Gecko/20050511
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Variable ticks
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I was thinking about variable tick times, and I can think of three 
classes of action needing CPU attention.
- device interrupts, which occur at no predictable time but would pull 
the CPU out of a HLT or low power state.
- process sleeps of various kinds, which have a known time of occurence.
- polled devices...

Question one, are there other actions to consider?

Question two, what about those polled devices?

I've been asked to give a high level overview of the recent discussion 
for a meeting, and while I want to keep it at the level of "slower 
clock, fewer interrupts" and "faster clock, better sleep resolution," I 
don't want to leave out any important issues, or be asked a question 
(like how to handle polling devices) when I have no idea what people are 
thinking in an area.

-- 
    -bill davidsen (davidsen@tmr.com)
"The secret to procrastination is to put things off until the
  last possible moment - but no longer"  -me
