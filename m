Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265051AbUF1QR4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265051AbUF1QR4 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 28 Jun 2004 12:17:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265053AbUF1QR4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 28 Jun 2004 12:17:56 -0400
Received: from zcars04e.nortelnetworks.com ([47.129.242.56]:24449 "EHLO
	zcars04e.nortelnetworks.com") by vger.kernel.org with ESMTP
	id S265051AbUF1QRz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 28 Jun 2004 12:17:55 -0400
Message-ID: <40E0449F.5050104@nortelnetworks.com>
Date: Mon, 28 Jun 2004 12:17:35 -0400
X-Sybari-Space: 00000000 00000000 00000000 00000000
From: Chris Friesen <cfriesen@nortelnetworks.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040113
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Timothy Miller <miller@techsource.com>
CC: Con Kolivas <kernel@kolivas.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Nice 19 process still gets some CPU
References: <40E03C2D.5000809@techsource.com>
In-Reply-To: <40E03C2D.5000809@techsource.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Timothy Miller wrote:
> 
> 
> Con Kolivas wrote:
> 
>  >
>  > It definitely should _not_ starve. That is the unixy way of doing
>  > things. Everything must go forward. Around 5% cpu for nice 19 sounds
>  > just right. If you want scheduling only when there's spare cpu cycles
>  > you need a sched batch(idle) implementation.
>  >
>  >
> 
> Well, since I can't rewrite the app, I can't make it sched batch.  Nice
> values are an easy thing to get at for anything that's running.

Sure you can.  You can set the scheduler policy on any process in the system, 
while its running.

int sched_setscheduler(pid_t pid, int policy, const struct sched_param *p);

Takes about two minutes to write an equivalent to "nice" to set scheduler 
policies and priorities.


Chris
