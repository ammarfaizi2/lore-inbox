Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750854AbWJLUSS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750854AbWJLUSS (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 Oct 2006 16:18:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750891AbWJLUSS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 Oct 2006 16:18:18 -0400
Received: from mustang.oldcity.dca.net ([216.158.38.3]:30626 "HELO
	mustang.oldcity.dca.net") by vger.kernel.org with SMTP
	id S1750851AbWJLUSR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 Oct 2006 16:18:17 -0400
Subject: Re: USB performance bug since kernel 2.6.13 (CRITICAL???)
From: Lee Revell <rlrevell@joe-job.com>
To: Open Source <opensource3141@yahoo.com>
Cc: linux-usb-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
In-Reply-To: <20061012200527.14579.qmail@web58107.mail.re3.yahoo.com>
References: <20061012200527.14579.qmail@web58107.mail.re3.yahoo.com>
Content-Type: text/plain
Date: Thu, 12 Oct 2006 16:19:12 -0400
Message-Id: <1160684353.24931.79.camel@mindpipe>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2006-10-12 at 13:05 -0700, Open Source wrote:
> Hi,
> 
> Thanks for the rapid response!  But...I'm a bit confused.  Why is there any software OS timer involved at all?  Bulk messages should be scheduled by the host controller and for USB 2.0 the microframe period is 125 us.  When I submit an URB, it should be sent to the host controller and scheduled for the next microframe.  When the URB completes I should get an interrupt from the hardware.  Hence, my transactions (WRITE followed by READ) should at worst be approximately 250 us plus some overhead to process the transaction itself, provided there aren't any other time consuming processes running on my OS.  My overhead is less than 250 us.  I was willing to tolerate 1 ms per transaction, but 4 ms just doesn't make any sense.  Therefore I'm not sure if CONFIG_HZ is an appropriate excuse for this issue.
> 

I don't know, it just seemed likely because 1ms vs 4ms is close to the
change in the timer tick rate.  Try it.

Lee

