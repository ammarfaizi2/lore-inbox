Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264577AbUGMFsu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264577AbUGMFsu (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 Jul 2004 01:48:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264584AbUGMFsu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 Jul 2004 01:48:50 -0400
Received: from smtp107.mail.sc5.yahoo.com ([66.163.169.227]:23181 "HELO
	smtp107.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S264577AbUGMFst (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 Jul 2004 01:48:49 -0400
Message-ID: <40F377BD.4080201@yahoo.com.au>
Date: Tue, 13 Jul 2004 15:48:45 +1000
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7) Gecko/20040707 Debian/1.7-5
X-Accept-Language: en
MIME-Version: 1.0
To: Con Kolivas <kernel@kolivas.org>
CC: Andrew Morton <akpm@osdl.org>, William Lee Irwin III <wli@holomorphy.com>,
       ck@vds.kolivas.org, devenyga@mcmaster.ca, linux-kernel@vger.kernel.org
Subject: Re: Preempt Threshold Measurements
References: <200407121943.25196.devenyga@mcmaster.ca> <20040713024051.GQ21066@holomorphy.com> <200407122248.50377.devenyga@mcmaster.ca> <20040713025502.GR21066@holomorphy.com> <20040712210701.46e2cd40.akpm@osdl.org> <cone.1089696847.507419.12958.502@pc.kolivas.org>
In-Reply-To: <cone.1089696847.507419.12958.502@pc.kolivas.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Con Kolivas wrote:

> --- linux-2.6.8-rc1.orig/include/linux/sched.h	2004-07-12 16:11:50.000000000 +1000
> +++ linux-2.6.8-rc1/include/linux/sched.h	2004-07-13 15:31:00.547749905 +1000
> @@ -1021,6 +1021,7 @@
>  extern void __cond_resched(void);
>  static inline void cond_resched(void)
>  {
> +	touch_preempt_timing();
>  	if (need_resched())
>  		__cond_resched();
>  }

cond_resched_lock just below this needs something similar.
