Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964980AbVKOS6k@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964980AbVKOS6k (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Nov 2005 13:58:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964992AbVKOS6k
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Nov 2005 13:58:40 -0500
Received: from gw02.applegatebroadband.net ([207.55.227.2]:46572 "EHLO
	data.mvista.com") by vger.kernel.org with ESMTP id S964980AbVKOS6j
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Nov 2005 13:58:39 -0500
Message-ID: <437A2FDA.6090204@mvista.com>
Date: Tue, 15 Nov 2005 10:58:34 -0800
From: George Anzinger <george@mvista.com>
Reply-To: george@mvista.com
Organization: MontaVista Software
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.12) Gecko/20050922 Fedora/1.7.12-1.3.1
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: evan@coolrunningconcepts.com
CC: linux-kernel@vger.kernel.org, john stultz <johnstul@us.ibm.com>
Subject: Re: Timer idea
References: <20051115102425.0iln2874xjoc4g84@coolrunningconcepts.com>
In-Reply-To: <20051115102425.0iln2874xjoc4g84@coolrunningconcepts.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

evan@coolrunningconcepts.com wrote:
> I was thinking about benchmarking, profiling, and various other applications
> that might need frequent access to the current time.  Polling timers or
> frequent timer signal delivery both seem like there would be a lot of overhead.
>  I was thinking it would be nice if you could just read the time information
> without making an OS call.
> 
> I figure the kernel keeps accurate records of current time information and the
> values of various timers.  I then had the idea that one could have a /dev or
> maybe a /proc entry that would allow you to mmap() the kernel records (read
> only) and then you could read this information right from the kernel without
> any overhead.
> 

Your are describing the vsyscall.  John Stultz and company are actively working on this as we speak. 
  If memory serves, it is already available on some platforms.

-- 
George Anzinger   george@mvista.com
HRT (High-res-timers):  http://sourceforge.net/projects/high-res-timers/
