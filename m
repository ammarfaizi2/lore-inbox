Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1031200AbWI0XAp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1031200AbWI0XAp (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 27 Sep 2006 19:00:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1031201AbWI0XAp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 27 Sep 2006 19:00:45 -0400
Received: from nwd2mail10.analog.com ([137.71.25.55]:3245 "EHLO
	nwd2mail10.analog.com") by vger.kernel.org with ESMTP
	id S1031200AbWI0XAo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 27 Sep 2006 19:00:44 -0400
X-IronPort-AV: i="4.09,226,1157342400"; 
   d="scan'208"; a="12239991:sNHT20332830"
Message-Id: <6.1.1.1.0.20060927185639.01ecea00@ptg1.spd.analog.com>
X-Mailer: QUALCOMM Windows Eudora Version 6.1.1.1
Date: Wed, 27 Sep 2006 19:01:03 -0400
To: Arnd Bergmann <arnd@arndb.de>
From: Robin Getz <rgetz@blackfin.uclinux.org>
Subject: Re: [PATCH 1/4] Blackfin: arch patch for 2.6.18
Cc: luke Yang <luke.adi@gmail.com>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Arnd wrote:
>An even better strategy is to do what the better architecture 
>implementations in linux do and to apply common sense. "better" of course 
>is rather subjective, but I typically recommend looking at arch/parisc as 
>a good example.

Sure - we will go with that.

./linux-2.6.x/include/asm-parisc/system.h

/* interrupt control */
#define local_save_flags(x)     __asm__ __volatile__("ssm 0, %0" : "=r" (x) 
: : "memory")
#define local_irq_disable()     __asm__ __volatile__("rsm %0,%%r0\n" : : 
"i" (PSW_I) : "memory" )
#define local_irq_enable()      __asm__ __volatile__("ssm %0,%%r0\n" : : 
"i" (PSW_I) : "memory" )

:)

-Robin 
