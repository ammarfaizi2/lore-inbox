Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263552AbUDBCDP (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 Apr 2004 21:03:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263553AbUDBCDO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Apr 2004 21:03:14 -0500
Received: from gateway-1237.mvista.com ([12.44.186.158]:54009 "EHLO
	av.mvista.com") by vger.kernel.org with ESMTP id S263552AbUDBCDE
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 Apr 2004 21:03:04 -0500
Message-ID: <406CC9D3.9030604@mvista.com>
Date: Thu, 01 Apr 2004 18:02:59 -0800
From: George Anzinger <george@mvista.com>
Reply-To: ganzinger@mvista.com
Organization: MontaVista Software
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2.1) Gecko/20030225
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Tyler Riddle <triddle_1999@yahoo.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: Kernel hangs approximitly every 3 days, some times during boot
  on version 2.4 and 2.6
References: <20040401034824.99925.qmail@web41313.mail.yahoo.com>
In-Reply-To: <20040401034824.99925.qmail@web41313.mail.yahoo.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Tyler Riddle wrote:
> Hello,
> 
> You can find a detailed bug report folowing the
> template specified in REPORTING-BUGS at
> http://foodmotron.homeunix.org/~tyler/bug-report.txt
> 
> In short, the kernel will hard lock on my machine
> about every 3 days. I have tried several of the latest
> versions of the 2.4 and 2.6 series kernels, 2.2 has
> not shown this problem. I have tried to remedy this
> problem by removing APIC support, IDE DMA and explicit
> support for my IDE chipset
> (VT82C586A/B/VT82C686/A/B/VT8233/A/C/VT8235), none of
> which has helped any. On every lockup the IDE disk
> access light has been steady and usualy a steady tone
> is left playing out of my sound card.

I am going to take a stab in the dark here and question if it is the sound card 
or the cpu (i.e. in the box, speaker, etc.) that the sound is comming from.  If 
so, it could be that your cpus internal monitor has detected an alarm condition, 
such as voltage out of range, or, and most likely, over temp.  You might want to 
get your "sensors" set up so you can check from time to time.  Might even want 
to put together a script that writes to the system log when ever a sensor is in 
alarm condition.

And yes, linux stresses the box more than windoz, so it will over temp while 
windoz does not.

-g
> 
> I'm hoping someone here can help me figure out what is
> going on. This exact same hardware in the exact same
> configuration ran Windows 2000 for over a year with
> out issue. To verify the problem was localized to the
> linux kernel I also ran FreeBSD 5.2.1 for 3 weeks
> after the lockup problem existed under linux.
> 
> Thanks for your help,
> 
> Tyler Riddle
> 
> =====
> "There are only 10 types of people in this world: Those who understand binary and those who don't."
> 
> aim: TheMastaSpice
> 
> __________________________________
> Do you Yahoo!?
> Yahoo! Small Business $15K Web Design Giveaway 
> http://promotions.yahoo.com/design_giveaway/
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

