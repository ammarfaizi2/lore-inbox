Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S274105AbRIXSDQ>; Mon, 24 Sep 2001 14:03:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S274103AbRIXSDH>; Mon, 24 Sep 2001 14:03:07 -0400
Received: from unused ([12.150.234.220]:36607 "EHLO one.isilinux.com")
	by vger.kernel.org with ESMTP id <S274102AbRIXSC7>;
	Mon, 24 Sep 2001 14:02:59 -0400
Message-ID: <3BAF7567.7030700@interactivesi.com>
Date: Mon, 24 Sep 2001 13:03:19 -0500
From: Timur Tabi <ttabi@interactivesi.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.4) Gecko/20010913
X-Accept-Language: en-us
MIME-Version: 1.0
To: "Nirranjan.K" <nirran@sasken.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: Bottom halves, task queues invokation
In-Reply-To: <9ok0mr$f4q$1@ncc-k.sasi.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Nirranjan.K wrote:

> In case of
> 
> kernel thread is running on behalf of user process. In meantime a timer
> interrupt arrives(slow interrupt). Now after end of timer interrupt are
> Bottom halves, task queues invoked ? (offcourse Scheduler is not invoked as
> kernel is not pre emptive)


I'm not sure I understand your question, but bottom halves and tasklets do not 
pre-empt the kernel.  So if a timer interrupts the kernel, and the timer 
handler schedules a tasklet, then after the timer handler exists, AND after 
the kernel exists, that's when the tasklet is run.

