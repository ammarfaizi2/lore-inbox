Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267712AbTAHEoP>; Tue, 7 Jan 2003 23:44:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267713AbTAHEoP>; Tue, 7 Jan 2003 23:44:15 -0500
Received: from e5.ny.us.ibm.com ([32.97.182.105]:25572 "EHLO e5.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id <S267712AbTAHEoO>;
	Tue, 7 Jan 2003 23:44:14 -0500
Subject: [PATCH] linux-2.5.54_delay-cleanup_A1
From: john stultz <johnstul@us.ibm.com>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: lkml <linux-kernel@vger.kernel.org>
In-Reply-To: <1042001164.1048.112.camel@w-jstultz2.beaverton.ibm.com>
References: <1042001164.1048.112.camel@w-jstultz2.beaverton.ibm.com>
Content-Type: text/plain
Organization: 
Message-Id: <1042001318.1050.116.camel@w-jstultz2.beaverton.ibm.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.1 
Date: 07 Jan 2003 20:48:38 -0800
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus, all, 

	Here again is my delay-cleanup patch. As described earlier, this patch
tries to cleanup the delay code by moving the timer-specific
implementations into the timer_ops struct. Thus, rather then doing:

	if(x86_delay_tsc)
		__rdtsc_delay(loops);
	else if(x86_delay_cyclone)
		__cyclone_delay(loops);
	else if(whatever....

we just simply do:

	timer->delay(loops);

Please apply on top of linux-2.5.54_timer-none_A0.

thanks
-john



