Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262844AbTJ3VCA (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 30 Oct 2003 16:02:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262848AbTJ3VCA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 30 Oct 2003 16:02:00 -0500
Received: from gateway-1237.mvista.com ([12.44.186.158]:41462 "EHLO
	av.mvista.com") by vger.kernel.org with ESMTP id S262844AbTJ3VB6
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 30 Oct 2003 16:01:58 -0500
Message-ID: <3FA17C43.5030709@mvista.com>
Date: Thu, 30 Oct 2003 13:01:55 -0800
From: George Anzinger <george@mvista.com>
Organization: MontaVista Software
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2) Gecko/20021202
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: First Name <linuxquestasu@yahoo.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: Cyclic Scheduling for linux
References: <20031030181510.5504.qmail@web12905.mail.yahoo.com>
In-Reply-To: <20031030181510.5504.qmail@web12905.mail.yahoo.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

First Name wrote:
> Hi there,
> 
> I am working on providing a cyclic scheduling policy
> to the current non real time version of the linux to
> support hard real time tasks as part of one of my
> projects. This policy should be able to support
> aperiodic, periodic and sporadic tasks too. Could any
> one pour some light on how to go about achieving it?.
> 
> Any Helpful tips, project reports, links or advices
> are greatly appreciated.

Instead of kernel changes, you might want to consider a user monitor task 
running at high rt priority which changes the priority of the tasks you want to 
use the new policy.  You could write an intercept routine for the scheduleset* 
calls and pass the new policy to the monitor.  More thought would be needed to 
make it inherit across a fork..

-g
> 
> Thanks and Regards,
> LQ
> 
> __________________________________
> Do you Yahoo!?
> Exclusive Video Premiere - Britney Spears
> http://launch.yahoo.com/promos/britneyspears/
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 

-- 
George Anzinger   george@mvista.com
High-res-timers:  http://sourceforge.net/projects/high-res-timers/
Preemption patch: http://www.kernel.org/pub/linux/kernel/people/rml

