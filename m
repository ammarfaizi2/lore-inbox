Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267953AbUJMAfU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267953AbUJMAfU (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Oct 2004 20:35:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268117AbUJMAfU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Oct 2004 20:35:20 -0400
Received: from zcars04e.nortelnetworks.com ([47.129.242.56]:59790 "EHLO
	zcars04e.nortelnetworks.com") by vger.kernel.org with ESMTP
	id S267953AbUJMAfO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Oct 2004 20:35:14 -0400
Message-ID: <416C7833.7000000@nortelnetworks.com>
Date: Tue, 12 Oct 2004 18:34:59 -0600
X-Sybari-Space: 00000000 00000000 00000000 00000000
From: Chris Friesen <cfriesen@nortelnetworks.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040113
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: george@mvista.com
CC: Linux kernel <linux-kernel@vger.kernel.org>
Subject: Re: question about linux time change
References: <4165AFBC.8010605@nortelnetworks.com> <416C6A33.6030202@mvista.com>
In-Reply-To: <416C6A33.6030202@mvista.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

George Anzinger wrote:
> Chris Friesen wrote:
> 
>>
>> I have been asked to add the ability to notify userspace when the time 
>> of day changes.  The actual notification is the easy part.  I'm having 
>> issues with where exactly the time is really changed.
> 
> 
> Just what sort of time changes do you want to notify on?  The ntp code 
> "drifts" time a lot.  Do you want to know about this?  If it is only 
> cases where there is a jump in time, you might do well to look at 
> "clock_was_set()".  It is in kernel/posix-timers.c and is called when 
> ever do_settimeofday() is called AND on leap second calls.
> 
> You will even find code in there to push the ladder out of the softirq 
> context.


Cool.  Will do.

Chris
