Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263847AbTH1In2 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 28 Aug 2003 04:43:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263882AbTH1Imu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Aug 2003 04:42:50 -0400
Received: from dp.samba.org ([66.70.73.150]:45516 "EHLO lists.samba.org")
	by vger.kernel.org with ESMTP id S263842AbTH1IEE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Aug 2003 04:04:04 -0400
From: Rusty Russell <rusty@rustcorp.com.au>
To: alexander.riesen@synopsys.COM
Cc: akpm@zip.com.au, mingo@redhat.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] Futex minor fixes 
In-reply-to: Your message of "Wed, 27 Aug 2003 08:50:16 +0200."
             <20030827065016.GA11214@Synopsys.COM> 
Date: Thu, 28 Aug 2003 10:49:10 +1000
Message-Id: <20030828080404.0B1AD2C89E@lists.samba.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In message <20030827065016.GA11214@Synopsys.COM> you write:
> Btw, what could that spurious wakeups be?

I don't know, but every other primitive in the kernel handles it, so
we should too.

> It set to loop unconditionally, so if the source of wakeup insists on
> wakeing up the code could result in endless loop, right?

Yes.  If someone wakes you up, you will wake up.  If someone wakes you
up an infinite number of times, you will wake up an infinite number of
times.  cf. waitqueues.

Hope that clarifies,
Rusty.
--
  Anyone who quotes me in their sig is an idiot. -- Rusty Russell.
