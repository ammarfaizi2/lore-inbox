Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262482AbTJBAOM (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Oct 2003 20:14:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262672AbTJBAOM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Oct 2003 20:14:12 -0400
Received: from gateway-1237.mvista.com ([12.44.186.158]:31741 "EHLO
	av.mvista.com") by vger.kernel.org with ESMTP id S262482AbTJBAOL
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Oct 2003 20:14:11 -0400
Message-ID: <3F7B6DCC.9090604@mvista.com>
Date: Wed, 01 Oct 2003 17:14:04 -0700
From: George Anzinger <george@mvista.com>
Organization: MontaVista Software
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2) Gecko/20021202
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Yifan Zhu <yzhu2@unity.ncsu.edu>
CC: linux-kernel@vger.kernel.org
Subject: Re: TIMER_BH in 2.4 kernel
References: <3F788DE4.8030505@unity.ncsu.edu>
In-Reply-To: <3F788DE4.8030505@unity.ncsu.edu>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Yifan Zhu wrote:
> Hi,
> I'm looking at the 2.4 kernel. My understanding of the code is that the
> TIMER_BH handler is executed when the hardware timer interrupt returns (
> after do_IRQ(), but before returning to the interrupted task ). Is that
> right?
> 
> Thanks for clarification!

Unless there is a bh_lock in effect at the time, in which case it is 
executed when the lock is released.

-
-- 
George Anzinger   george@mvista.com
High-res-timers:  http://sourceforge.net/projects/high-res-timers/
Preemption patch: http://www.kernel.org/pub/linux/kernel/people/rml

