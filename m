Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932179AbVISLqq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932179AbVISLqq (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 19 Sep 2005 07:46:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932194AbVISLqq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 19 Sep 2005 07:46:46 -0400
Received: from mx1.redhat.com ([66.187.233.31]:2494 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S932179AbVISLqp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 19 Sep 2005 07:46:45 -0400
Date: Mon, 19 Sep 2005 07:46:33 -0400 (EDT)
From: Rik van Riel <riel@redhat.com>
X-X-Sender: riel@cuia.boston.redhat.com
To: liyu <liyu@ccoss.com.cn>
cc: LKML <linux-kernel@vger.kernel.org>, Linux-MM <linux-mm@kvack.org>
Subject: Re: [Question] Clock-pro patches questions
In-Reply-To: <432E683E.7090002@ccoss.com.cn>
Message-ID: <Pine.LNX.4.63.0509190744140.19512@cuia.boston.redhat.com>
References: <432E683E.7090002@ccoss.com.cn>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; CHARSET=US-ASCII; FORMAT=flowed
Content-ID: <Pine.LNX.4.63.0509190744142.19512@cuia.boston.redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 19 Sep 2005, liyu wrote:

>      When boot with this new kernel, kernel often pop oops message. the Oops
> like this:   
>    BUG: using smp_processor_id() in preemptible [00000001] code: ifup/1983
> caller is recently_evicted+0x9c/0xb8

Ohhhh fun, so code like the following is now illegal ?
 
	__get_cpu_var(refault_histogram)[distance]++;

I'll figure out how to fix this and will try to release
new clock-pro patches this week.

-- 
All Rights Reversed
