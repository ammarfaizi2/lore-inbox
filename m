Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268462AbRGZRq5>; Thu, 26 Jul 2001 13:46:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268559AbRGZRqr>; Thu, 26 Jul 2001 13:46:47 -0400
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:45839 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S268462AbRGZRqk>; Thu, 26 Jul 2001 13:46:40 -0400
Subject: Re: Linux 2.4.7-ac1
To: plars@austin.ibm.com (Paul Larson)
Date: Thu, 26 Jul 2001 18:47:52 +0100 (BST)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <01072612421000.21482@plars.austin.ibm.com> from "Paul Larson" at Jul 26, 2001 12:42:10 PM
X-Mailer: ELM [version 2.5 PL5]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E15PpEm-0004C2-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org
Original-Recipient: rfc822;linux-kernel-outgoing

> pth_str02 test (simple test that tries to create 1000 threads) could only 
> make it up to 980 threads on my machine.  Saw this change in fork.c with 
> 2.4.7-ac1:
> 
> -       max_threads = mempages / (THREAD_SIZE/PAGE_SIZE) / 2;
> +       max_threads = mempages / (THREAD_SIZE/PAGE_SIZE) / 16;
> 
> Any reason why this was done?  I think the max I was ever able to hit before 
> was somewhere around 1018 or so, so it's not that big of a drop.  I was just 

Im just playing with better choices of parameters to be more conservative
about thread allocations

