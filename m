Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261595AbVF0TBr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261595AbVF0TBr (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Jun 2005 15:01:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261587AbVF0TBq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Jun 2005 15:01:46 -0400
Received: from smtp-3.llnl.gov ([128.115.41.83]:29936 "EHLO smtp-3.llnl.gov")
	by vger.kernel.org with ESMTP id S261595AbVF0TBl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Jun 2005 15:01:41 -0400
Date: Mon, 27 Jun 2005 12:01:38 -0700 (PDT)
From: Chuck Harding <charding@llnl.gov>
Subject: Re: Real-Time Preemption, -RT-2.6.12-final-V0.7.50-24
In-reply-to: <200506251039.14746.gene.heskett@verizon.net>
To: Linux Kernel Discussion List <linux-kernel@vger.kernel.org>
Message-id: <Pine.LNX.4.63.0506271157200.8605@ghostwheel.llnl.gov>
Organization: Lawrence Livermore National Laboratory
MIME-version: 1.0
Content-type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Content-transfer-encoding: 7BIT
User-Agent: Pine/4.62 (X11; U; Linux i686; en-US; rv:2.6.11-rc2-mm1)
References: <20050608112801.GA31084@elte.hu> <20050625091215.GC27073@elte.hu>
 <200506250919.52640.gene.heskett@verizon.net>
 <200506251039.14746.gene.heskett@verizon.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

What can be causing the following message to appear in dmesg and
how can I fix it?

BUG: scheduling with irqs disabled: kapmd/0x00000000/46
caller is schedule_timeout+0x51/0x9e
  [<c02b3bc9>] schedule+0x96/0xf6 (8)
  [<c02b43f7>] schedule_timeout+0x51/0x9e (28)
  [<c01222ed>] process_timeout+0x0/0x5 (32)
  [<c0112063>] apm_mainloop+0x7a/0x96 (24)
  [<c0115e45>] default_wake_function+0x0/0x16 (12)
  [<c0115e45>] default_wake_function+0x0/0x16 (32)
  [<c0111485>] apm_driver_version+0x1c/0x38 (16)
  [<c01126f7>] apm+0x0/0x289 (8)
  [<c01127a6>] apm+0xaf/0x289 (8)
  [<c010133c>] kernel_thread_helper+0x0/0xb (20)
  [<c0101341>] kernel_thread_helper+0x5/0xb (4)

This was also present in earlier final-V0.7.50 version I've tried
(since -00) I don't get hangs but that doesn't look like it should
be happening. Thanks.

-- 
Charles D. (Chuck) Harding <charding@llnl.gov>  Voice: 925-423-8879
Senior Computer Associate         ICCD            Fax: 925-423-6961
Lawrence Livermore National Laboratory      Computation Directorate
Livermore, CA USA  http://www.llnl.gov  GPG Public Key ID: B9EB6601
------------------ http://tinyurl.com/5w5ey -----------------------
-- Unburdened by the rigors of coherent thought. --
