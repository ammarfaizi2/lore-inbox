Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261790AbUCBXxB (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 2 Mar 2004 18:53:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261793AbUCBXxB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 Mar 2004 18:53:01 -0500
Received: from gateway-1237.mvista.com ([12.44.186.158]:47863 "EHLO
	av.mvista.com") by vger.kernel.org with ESMTP id S261790AbUCBXw6
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 Mar 2004 18:52:58 -0500
Message-ID: <40451E50.4080806@mvista.com>
Date: Tue, 02 Mar 2004 15:52:48 -0800
From: George Anzinger <george@mvista.com>
Organization: MontaVista Software
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2.1) Gecko/20030225
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: amitkale@emsyssoft.com, ak@suse.de, pavel@ucw.cz,
       linux-kernel@vger.kernel.org, piggy@timesys.com,
       trini@kernel.crashing.org
Subject: Re: kgdb support in vanilla 2.6.2
References: <20040204230133.GA8702@elf.ucw.cz.suse.lists.linux.kernel>	<200402061914.38826.amitkale@emsyssoft.com>	<403FDB37.2020704@mvista.com>	<200403011508.23626.amitkale@emsyssoft.com>	<4044F84D.4030003@mvista.com> <20040302132751.255b9807.akpm@osdl.org>
In-Reply-To: <20040302132751.255b9807.akpm@osdl.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton wrote:
> George Anzinger <george@mvista.com> wrote:
> 
>> Often it is not clear just why we are in the stub, given that 
>>we trap such things as kernel page faults, NMI watchdog, BUG macros and such.
> 
> 
> Yes, that can be confusing.  A little printk on the console prior to
> entering the debugger would be nice.

That assumes that one can do a printk and not run into a lock.  Far better 
IMNSHO is to provide a simple way to get it from gdb.  One can then even provide 
a gdb macro to print the relevant source line and its surrounds.  I my lighter 
moments I call this the comefrom macro :)  In my kgdb it would look like:

l * kgdb_info.called_from


-- 
George Anzinger   george@mvista.com
High-res-timers:  http://sourceforge.net/projects/high-res-timers/
Preemption patch: http://www.kernel.org/pub/linux/kernel/people/rml

