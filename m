Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S282836AbRK0HYW>; Tue, 27 Nov 2001 02:24:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S282840AbRK0HYN>; Tue, 27 Nov 2001 02:24:13 -0500
Received: from [203.124.139.197] ([203.124.139.197]:17165 "EHLO
	pcsmail.patni.com") by vger.kernel.org with ESMTP
	id <S282836AbRK0HYA>; Tue, 27 Nov 2001 02:24:00 -0500
Reply-To: <chandrasekhar.nagaraj@patni.com>
From: "Chandrasekhar" <chandrasekhar.nagaraj@patni.com>
To: <linux-kernel@vger.kernel.org>
Subject: problem with CPU_RAISE_SOFTIRQ
Date: Tue, 27 Nov 2001 13:03:04 +0530
Message-ID: <NFBBJJFKOKJEMFAEIPPJGEMDCAAA.chandrasekhar.nagaraj@patni.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook IMO, Build 9.0.2416 (9.0.2910.0)
Importance: Normal
X-MimeOLE: Produced By Microsoft MimeOLE V5.00.2314.1300
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi,

I am unable to understand the purpose for recursivly calling the function
cpu_raise_softirq.

Problem defination: In the file softirq.c I got this problem.

1.Device Driver for scheduling its bottom half calls the function mark_bh
which in turn calls the   function tasklet_hi_schedule.
2.tasklet_hi_schedule calls the function cpu_raise_softirq which in turn
wakes up task ksoftirqd.
3.The task ksoftirrd calls the function tasklet_hi_action which in turns
calls cpu_raise_softirq.

Reply ASAP

Regards
Chandrasekhar

