Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964829AbWCMWof@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964829AbWCMWof (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Mar 2006 17:44:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964833AbWCMWof
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Mar 2006 17:44:35 -0500
Received: from omta03ps.mx.bigpond.com ([144.140.82.155]:30100 "EHLO
	omta03ps.mx.bigpond.com") by vger.kernel.org with ESMTP
	id S964829AbWCMWoe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Mar 2006 17:44:34 -0500
Message-ID: <4415F5CC.6030601@bigpond.net.au>
Date: Tue, 14 Mar 2006 09:44:28 +1100
From: Peter Williams <pwil3058@bigpond.net.au>
User-Agent: Mozilla Thunderbird 1.0.7-1.1.fc4 (X11/20050929)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Ingo Molnar <mingo@elte.hu>
CC: Con Kolivas <kernel@kolivas.org>,
       linux list <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>, ck list <ck@vds.kolivas.org>
Subject: Re: [PATCH][1/4] sched: store weighted load on up
References: <200603131905.17349.kernel@kolivas.org> <20060313090412.GA5780@elte.hu>
In-Reply-To: <20060313090412.GA5780@elte.hu>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Authentication-Info: Submitted using SMTP AUTH PLAIN at omta03ps.mx.bigpond.com from [147.10.133.38] using ID pwil3058@bigpond.net.au at Mon, 13 Mar 2006 22:44:28 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ingo Molnar wrote:
> * Con Kolivas <kernel@kolivas.org> wrote:
> 
> 
>>Modify the smp nice code to store load_weight on uniprocessor as well 
>>to allow relative niceness on one cpu to be assessed. Minor cleanups 
>>and uninline set_load_weight().
>>
>>Signed-off-by: Con Kolivas <kernel@kolivas.org>
> 
> 
> agreed. This only affects a scheduler slowpath [setscheduler()].
> 
> Acked-by: Ingo Molnar <mingo@elte.hu>

It also effects task activation/deactivation but that's on a relatively 
slow path and is just an addition/subtraction respectively.

Peter
-- 
Peter Williams                                   pwil3058@bigpond.net.au

"Learning, n. The kind of ignorance distinguishing the studious."
  -- Ambrose Bierce
