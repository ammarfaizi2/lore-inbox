Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262308AbUCCBGR (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 2 Mar 2004 20:06:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262311AbUCCBGR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 Mar 2004 20:06:17 -0500
Received: from gateway-1237.mvista.com ([12.44.186.158]:22776 "EHLO
	av.mvista.com") by vger.kernel.org with ESMTP id S262308AbUCCBF5
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 Mar 2004 20:05:57 -0500
Message-ID: <40452F70.1070706@mvista.com>
Date: Tue, 02 Mar 2004 17:05:52 -0800
From: George Anzinger <george@mvista.com>
Organization: MontaVista Software
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2.1) Gecko/20030225
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Pavel Machek <pavel@ucw.cz>
CC: Tom Rini <trini@kernel.crashing.org>,
       "Amit S. Kale" <akale@users.sourceforge.net>,
       kernel list <linux-kernel@vger.kernel.org>
Subject: Re: kgdb: fix kgdbeth compilation and make it init late enough
References: <20040302112500.GA485@elf.ucw.cz> <20040302153250.GE16434@smtp.west.cox.net> <20040302223326.GF1225@elf.ucw.cz>
In-Reply-To: <20040302223326.GF1225@elf.ucw.cz>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Pavel Machek wrote:
> Hi!
> 
> 
>>>CONFIG_NO_KGDB_CPUS can not be found anywhere in the patches => its
>>>probably not needd any more.
>>
>>I don't know if we can do that.  There's some funky locking stuff done
>>on SMP, which for some reason can't be done to NR_CPUS (or, no one has
>>tried doing that).
> 
> 
> There seems to be KGDB_MAX_NO_CPUS, but as 8250 patch does not check
> it, I believe that eth has no business checking it either.

I have not seen this one before.  It must be from Amit's patch base.

-- 
George Anzinger   george@mvista.com
High-res-timers:  http://sourceforge.net/projects/high-res-timers/
Preemption patch: http://www.kernel.org/pub/linux/kernel/people/rml

