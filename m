Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261332AbVHAXaE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261332AbVHAXaE (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 1 Aug 2005 19:30:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261338AbVHAXaE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 1 Aug 2005 19:30:04 -0400
Received: from gateway-1237.mvista.com ([12.44.186.158]:44274 "EHLO
	av.mvista.com") by vger.kernel.org with ESMTP id S261332AbVHAXaC
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 1 Aug 2005 19:30:02 -0400
Message-ID: <42EEB004.4040601@mvista.com>
Date: Mon, 01 Aug 2005 16:28:04 -0700
From: George Anzinger <george@mvista.com>
Reply-To: george@mvista.com
Organization: MontaVista Software
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.6) Gecko/20050323 Fedora/1.7.6-1.3.2
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: greg <ustrel@free.fr>
CC: linux-kernel@vger.kernel.org
Subject: Re: Clock resolution / RT preemption
References: <42EDD473.3010308@free.fr>
In-Reply-To: <42EDD473.3010308@free.fr>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

greg wrote:
> Hi folks,
> 
> I'm looking for a timer resolution lower than 1 ms (and monotonic clock 
> rate) destined to be used with some network code running on x86 
> platforms. Would you please provide me with informations about how to 
> get/implement this.
> 
> AFAIK, there's a "high resultion timer" patch hanging around, but 
> there's not much informations with regard to portability (specific 
> hardware requirements ?), scalability, integration with RT patches.
> I understand the POSIX 1003.1b Clocks and Timers system calls are not 
> fully available within the linux kernel (and libc ?), am I right on that ?

On the HRT web site (see signature) there is a CVS repository.  In there 
is a special version for the RT kernel.  As to porting it to other 
archs, have a look at the include/linux/hrtimer.h file.  It has (or 
should have) all you need to know.  Please pass back any port you do.
> 
> One more question : I believe Ingo's preemption patch run 
> timers/interrupt handlers within kernel threads, how should I assign 
> specific priority to address my goals without compromising system 
> stability ?

Carefully :)

-- 
George Anzinger   george@mvista.com
HRT (High-res-timers):  http://sourceforge.net/projects/high-res-timers/
