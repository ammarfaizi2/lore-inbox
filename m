Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964788AbVKGGEp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964788AbVKGGEp (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Nov 2005 01:04:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964789AbVKGGEp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Nov 2005 01:04:45 -0500
Received: from [210.76.114.22] ([210.76.114.22]:36519 "EHLO ccoss.com.cn")
	by vger.kernel.org with ESMTP id S964788AbVKGGEo (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Nov 2005 01:04:44 -0500
Message-ID: <436EEEA4.1020703@ccoss.com.cn>
Date: Mon, 07 Nov 2005 14:05:24 +0800
From: liyu <liyu@ccoss.com.cn>
User-Agent: Mozilla Thunderbird 1.0.6 (X11/20050716)
X-Accept-Language: zh-cn,zh
MIME-Version: 1.0
To: LKML <linux-kernel@vger.kernel.org>
Subject: [question] I doublt on timer interrput.
Content-Type: text/plain; charset=gb18030; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, all:

    I have one question about timer interrupt (i386 architecture).

    As we known, the timer emit HZ times interrputs per second,
and in i386. The interrupt handler will call scheduler_tick()
each time (on i386 at least, both enable or disable APIC).

    On my Celeron machine(IOW, only one CPU, not SMP/SMT), I defined
a global int variable 'tick_count' in kernel/sched.c, and add one line
of code like follow in scheduler_tick():

    ++tick_count;

    but I found it is not same with content of the /proc/interrupts,
and the differennt between them is not little.
   
    I can not understand why that is.
   
    Any useful idea.



-liyu / NOW~




   

