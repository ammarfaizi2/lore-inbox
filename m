Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261433AbUBUAGK (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 20 Feb 2004 19:06:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261440AbUBUAFw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 20 Feb 2004 19:05:52 -0500
Received: from gateway-1237.mvista.com ([12.44.186.158]:33786 "EHLO
	av.mvista.com") by vger.kernel.org with ESMTP id S261433AbUBUAEG
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 20 Feb 2004 19:04:06 -0500
Message-ID: <40353C69.2030509@mvista.com>
Date: Thu, 19 Feb 2004 14:44:57 -0800
From: George Anzinger <george@mvista.com>
Organization: MontaVista Software
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2) Gecko/20021202
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: =?ISO-8859-1?Q?Kristian_Lyngst=F8l?= <nesquik@bohemians.org>
CC: =?ISO-8859-1?Q?Christian_K=F6gler?= 
	<christian.koegler@unibw-muenchen.de>,
       linux-kernel@vger.kernel.org
Subject: Re: tasklets vs. workqueues
References: <403117FF.1080200@unibw-muenchen.de> <20040217014123.GA16165@bohemians.org>
In-Reply-To: <20040217014123.GA16165@bohemians.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Kristian Lyngstøl wrote:
> On Mon, Feb 16, 2004 at 08:20:31PM +0100, Christian Kögler wrote:
> 
>>When should I use tasklets and when should I user workqueues?
>>What are the differences?
> 
> 
> To quote "Linux Kernel Development" (Which I am currently reading):
> 
> Work queues defer work into a kernel thread-the work always runs in process
> context. Most importantly, work queues are schedulable and can therefore sleep.
> 
> Normally, there is little decision between work queues or sotftirqs/tasklets.
> If the deferred work need to sleep, work queues are used. If the deferred 
> work need not sleepa, softirqs or tasklets are used.

Being in process context, you can also change the priority and schedule policy 
as needed to fit your application, while you are rather stuck with tasklets in 
this regard.


-- 
George Anzinger   george@mvista.com
High-res-timers:  http://sourceforge.net/projects/high-res-timers/
Preemption patch: http://www.kernel.org/pub/linux/kernel/people/rml

