Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264979AbTIIWkQ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 Sep 2003 18:40:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264978AbTIIWkQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 Sep 2003 18:40:16 -0400
Received: from gateway-1237.mvista.com ([12.44.186.158]:60145 "EHLO
	av.mvista.com") by vger.kernel.org with ESMTP id S264979AbTIIWkG
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 Sep 2003 18:40:06 -0400
Message-ID: <3F5E56AB.9060606@mvista.com>
Date: Tue, 09 Sep 2003 15:39:39 -0700
From: George Anzinger <george@mvista.com>
Organization: MontaVista Software
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2) Gecko/20021202
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Kendrick Hamilton <hamilton@sedsystems.ca>
CC: linux-kernel@vger.kernel.org
Subject: Re: Timer Interrupts, please CC hamilton@sedsystems.ca
References: <3F5CD45A.2060207@sedsystems.ca>
In-Reply-To: <3F5CD45A.2060207@sedsystems.ca>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Kendrick Hamilton wrote:
> Hello,
>    Please send/cc responses to hamilton@sedsystems.ca
>    We are using a custom modulator card with the Linux 2.2.16 kernel 
> running on an IBM e-server (dual 2.8GHz, a lot of RAM). The modulator 
> card uses interrupts to send data (the card has a large FIFO and 
> interrupts when almost empty). The interrupt service routine re-fills 
> the fifo. While it is re-filling the FIFO interrupts are disabled. We 
> are noticing horrible clock skew.
>    Can you tell me the frequency of timer interrupts used by the linux 
> 2.2.16 kernel on Intel x86 SMP platform. I want to know how long my 
> interrupt service routine can leave the interrupt disabled.

Two VERY different questions IMNSHO. :)

The normal tick time for the x86 platform on 2.4.x kernels was/is 
10ms.  The interrupt latency, on the other hand, is usually well under 
1ms.  Shame to see that go up.



-- 
George Anzinger   george@mvista.com
High-res-timers:  http://sourceforge.net/projects/high-res-timers/
Preemption patch: http://www.kernel.org/pub/linux/kernel/people/rml

