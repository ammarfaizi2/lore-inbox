Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751079AbWAJMHl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751079AbWAJMHl (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Jan 2006 07:07:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751081AbWAJMHl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Jan 2006 07:07:41 -0500
Received: from mail.gmx.net ([213.165.64.21]:43149 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S1751079AbWAJMHk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Jan 2006 07:07:40 -0500
X-Authenticated: #14349625
Message-Id: <5.2.1.1.2.20060110125942.00bef510@pop.gmx.net>
X-Mailer: QUALCOMM Windows Eudora Version 5.2.1
Date: Tue, 10 Jan 2006 13:07:33 +0100
To: Paolo Ornati <ornati@fastwebnet.it>
From: Mike Galbraith <efault@gmx.de>
Subject: Re: [SCHED] wrong priority calc - SIMPLE test case
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Con Kolivas <kernel@kolivas.org>, Ingo Molnar <mingo@elte.hu>,
       Nick Piggin <nickpiggin@yahoo.com.au>,
       Peter Williams <pwil3058@bigpond.net.au>
In-Reply-To: <5.2.1.1.2.20060110062457.00c38d18@pop.gmx.net>
References: <20060109210035.3f6adafc@localhost>
 <5.2.1.1.2.20060109162113.00ba9fd0@pop.gmx.net>
 <5.2.1.1.2.20060102092903.00bde090@pop.gmx.net>
 <20060101123902.27a10798@localhost>
 <5.2.1.1.2.20051231162352.00bda610@pop.gmx.net>
 <5.2.1.1.2.20051231090255.00bede00@pop.gmx.net>
 <200512281027.00252.kernel@kolivas.org>
 <20051227190918.65c2abac@localhost>
 <20051227224846.6edcff88@localhost>
 <200512281027.00252.kernel@kolivas.org>
 <5.2.1.1.2.20051231090255.00bede00@pop.gmx.net>
 <5.2.1.1.2.20051231162352.00bda610@pop.gmx.net>
 <5.2.1.1.2.20060109162113.00ba9fd0@pop.gmx.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
X-Antivirus: avast! (VPS 0601-0, 01/02/2006), Outbound message
X-Antivirus-Status: Clean
X-Y-GMX-Trusted: 0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

At 08:08 AM 1/10/2006 +0100, Mike Galbraith wrote:

>>   PID USER      PR  NI  VIRT  RES  SHR S %CPU %MEM    TIME+  COMMAND
>>  5626 paolo     16   0  2392  288  228 R 30.1  0.1   0:39.95 a.out
>>  5627 paolo     16   0  2392  288  228 R 24.1  0.1   0:34.93 a.out
>>  5625 paolo     18   0  2392  288  228 R 23.5  0.1   0:37.53 a.out
>>  5624 paolo     18   0  2392  288  228 R 21.9  0.1   0:37.60 a.out
>>  5193 root      15   0  167m  17m 2916 S  0.2  3.5   0:09.67 X
>>  5638 paolo     18   0  4952 1468  372 R  0.2  0.3   0:00.15 dd
>>
>>DD test (256MB): real    3m37.122s  (instead of 8s)
>
>Ok, I'll  take another look.  Those should be being throttled.

Can you please try this version?  It tries harder to correct any 
imbalance... hopefully not too hard.  In case you didn't notice, you need 
to let your exploits run for a bit before the throttling will take 
effect.  I intentionally start tasks off at 0 cpu usage, so it takes a bit 
to come up to it's real usage.

         -Mike 

