Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263750AbUC3Q6l (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 Mar 2004 11:58:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263751AbUC3Q6l
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 Mar 2004 11:58:41 -0500
Received: from zcars0m9.nortelnetworks.com ([47.129.242.157]:49311 "EHLO
	zcars0m9.nortelnetworks.com") by vger.kernel.org with ESMTP
	id S263750AbUC3Q6j (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 Mar 2004 11:58:39 -0500
Message-ID: <4069A729.3030507@nortelnetworks.com>
Date: Tue, 30 Mar 2004 11:58:17 -0500
X-Sybari-Space: 00000000 00000000 00000000 00000000
From: Chris Friesen <cfriesen@nortelnetworks.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040113
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: root@chaos.analogic.com
CC: Linux kernel <linux-kernel@vger.kernel.org>
Subject: Re: sched_yield() version 2.4.24
References: <Pine.LNX.4.53.0403301138260.6967@chaos>
In-Reply-To: <Pine.LNX.4.53.0403301138260.6967@chaos>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Richard B. Johnson wrote:
> Anybody know why a task that does:
> 
> 		for(;;)
> 		   sched_yield();
> 
> Shows 100% CPU utiliization when there are other tasks that
> are actually getting the CPU? 

What do the other tasks show for cpu in top?

Maybe it's an artifact of the timer-based process sampling for cpu 
utilization, and it just happens to be running when the timer interrupt 
fires, so it keeps getting billed?

Chris
