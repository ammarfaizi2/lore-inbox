Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264094AbTE0Ty4 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 May 2003 15:54:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264099AbTE0Ty4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 May 2003 15:54:56 -0400
Received: from jma24.plus.com ([212.159.46.210]:7560 "EHLO lion")
	by vger.kernel.org with ESMTP id S264094AbTE0Tyy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 May 2003 15:54:54 -0400
From: "John Appleby" <john@dnsworld.co.uk>
To: <linux-kernel@vger.kernel.org>
Subject: 2.5.70 Oops in scheduler
Date: Tue, 27 May 2003 21:12:45 +0100
Message-ID: <434747C01D5AC443809D5FC5405011315693@bobcat.unickz.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook, Build 10.0.2616
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1106
In-Reply-To: <434747C01D5AC443809D5FC540501131096306@bobcat.unickz.com>
Importance: Normal
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

We are having problems under arm26 having upgraded to .70; getting an
oops directly after the POSIX conformance...

<6>ksoftirqd/0 (0): address exception: pc=020ab494
Code: eb001b23 ebffb8b5 e5846030 e5950004 (e5971004)
kernel/sched.c: 245: spin_lock(kernel/sched.c:021a8000) already locked
by kernel/sched.c/1271

I won't go any further because I've done some debugging and next is set
to 0 in all the schedule() calls. prev looks about right...

Someone suggested to me that some of the init_idle stuff has changed.
This might explain it, but I'm not sure where next is being set up
incorrectly.

Any ideas?

TIA

John


