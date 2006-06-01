Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964865AbWFAJzA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964865AbWFAJzA (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 Jun 2006 05:55:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964868AbWFAJzA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Jun 2006 05:55:00 -0400
Received: from anchor-post-31.mail.demon.net ([194.217.242.89]:50702 "EHLO
	anchor-post-31.mail.demon.net") by vger.kernel.org with ESMTP
	id S964865AbWFAJy7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 Jun 2006 05:54:59 -0400
Message-ID: <447EB970.8030005@onelan.co.uk>
Date: Thu, 01 Jun 2006 10:54:56 +0100
From: Barry Scott <barry.scott@onelan.co.uk>
User-Agent: Thunderbird 1.5 (X11/20051201)
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: linux-kernel@vger.kernel.org
Subject: Re: broadcom 5752 in HP dc7600U works on 2.6.13 but does not working
 on 2.6.16
References: <4469E709.7080501@onelan.co.uk> <20060522035943.7829ee32.akpm@osdl.org>
In-Reply-To: <20060522035943.7829ee32.akpm@osdl.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton wrote:
> Barry Scott <barry.scott@onelan.co.uk> wrote:
>   
>> Under FC4's build of 2.6.13 the broadcom 5752 works well. But when the
>>  I use the FC4 build of 2.6.16 it no long works.
>>
>>  The hardware is an HP dc7600U, P4 2.8GHz CPU, 512MB memory
>>  SATA disk.
>>
>>  mii-tool correctly reports the state of the eth0. Removing and inserting the
>>  cable is reported as expected. But DHCP or static IP configuration does not
>>  work under 2.6.16.
>>
>>  In dmesg output on 2.6.16 I see this message:
>>  ADDRCONF(NETDEV_UP): eth0: link is not ready
>>
>>  I have recompiled the 2.6.13 version of tg3.c for 2.6.16 and that does 
>>  not fix
>>  the problem.
>>
>>  Looking at /proc/interrupts I see that a lot of difference between .13 
>>  and .16 kernels.
>>  Is this related to the problem?
>>
>>  Attached are the output of dmesg and /proc/interrupts on 2.6.13 and 
>>  2.6.16 kernels
>>  as well as lspci output.
>>     
>
> It appears that the 2.6.13 kernel did not bring up the machine's io-APICs,
> but 2.6.16 did.  However you are receiving eth0 interrupts on 2.6.16 so
> perhaps that's not relevant.
>
> Don't know, sorry - tg3 works OK for most people.  You could try booting
> with the `noapic' kernel paremeter, perhaps.
>
> Note that googling for "noapic" gets 212,000 hits - we've _really_ screwed
> something up in there.  Maybe one day some developer will lay hands on one
> of these machines and will fix something.
>
> If noapic doesn't work (and I suspect it won't) then a next step would be
> to compile a kernel.org kernel and start enabling debug options.  It's
> hard, when we don't know which kernel subsystem broke.
>   
I'm willing to help get this fixed. I'm happy working inside kernels and 
drivers
but will need some guidance to know where to focus to track this down.

The obvious problem is solve is why are no interrupts being received by
the tg3.c code.

Which kernel should I use to debug this? 2.6.17 latest RC?
Which debug options do you suggest I turn on to get closer to the problem?
What information should I collect?

Barry

