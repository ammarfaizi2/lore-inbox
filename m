Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267416AbUIPBSz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267416AbUIPBSz (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Sep 2004 21:18:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267405AbUIPBSu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Sep 2004 21:18:50 -0400
Received: from smtp200.mail.sc5.yahoo.com ([216.136.130.125]:33130 "HELO
	smtp200.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S267401AbUIPBSG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Sep 2004 21:18:06 -0400
Message-ID: <4148E9C6.9010001@yahoo.com.au>
Date: Thu, 16 Sep 2004 11:17:58 +1000
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.2) Gecko/20040820 Debian/1.7.2-4
X-Accept-Language: en
MIME-Version: 1.0
To: Ingo Molnar <mingo@elte.hu>
CC: Andi Kleen <ak@muc.de>, linux-kernel@vger.kernel.org
Subject: Re: [patch] remove the BKL (Big Kernel Lock), this time for real
References: <2EJTp-7bx-1@gated-at.bofh.it> <m3vfefa61l.fsf@averell.firstfloor.org> <20040915201158.GA18915@elte.hu>
In-Reply-To: <20040915201158.GA18915@elte.hu>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ingo Molnar wrote:

> code using lock_kernel()/unlock_kernel() will see very similar semantics
> as they got from the BKL, so correctness should be fully preserved.
> Per-CPU assumptions still work, locking exclusion and lock-recursion
> still works the same way as it did with the BKL.
> 

Hi Ingo,

One change is that lock_kernel now sleeps, while it previously didn't, I
think?

Is this going to be a problem? Or have you checked the remaining bkl users
to ensure this is OK? Am I on drugs? :)

Nick
