Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964806AbWALICN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964806AbWALICN (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 Jan 2006 03:02:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964856AbWALICN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 Jan 2006 03:02:13 -0500
Received: from tornado.reub.net ([202.89.145.182]:36509 "EHLO tornado.reub.net")
	by vger.kernel.org with ESMTP id S964806AbWALICM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 Jan 2006 03:02:12 -0500
Message-ID: <43C60D01.5080808@reub.net>
Date: Thu, 12 Jan 2006 21:02:09 +1300
From: Reuben Farrelly <reuben-lkml@reub.net>
User-Agent: Thunderbird 1.6a1 (Windows/20060111)
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: Andre Hessling <ahessling@gmx.de>, linux-kernel@vger.kernel.org
Subject: Re: Kernel 2.6.15 sometimes only detects one of two SATA drives and
 panics
References: <1137003241.7603.20.camel@localhost.localdomain> <20060111234011.451c5c36.akpm@osdl.org>
In-Reply-To: <20060111234011.451c5c36.akpm@osdl.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On 12/01/2006 8:40 p.m., Andrew Morton wrote:
> Andre Hessling <ahessling@gmx.de> wrote:
>> Hello!
>>
>> I recently upgraded from 2.6.14 to 2.6.15 vanilla and I encountered some
>> random kernel panics on boot so far.
>>
>> The panic is:
>> "Kernel panic: VFS: Unable to mount root fs on unknown-block(0,0)"
> 
> Reuben, do you think this is the same as the bug you're seeing?

Hard to be sure, on this one I'm not convinced.  With mine, both controllers are 
recognised but display timeout messages which are not shown by the sequences 
reported below.

The hardware here is similar to mine though, mine is:

00:1f.2 SATA controller: Intel Corporation 82801FR/FRW (ICH6R/ICH6RW) SATA 
Controller (rev 03) (prog-if 01 [AHCI 1.0]

with 3x SATAs on raid-1 over reiserfs (although mine is a genuine Intel board).


>> My config hasn't changed since 2.6.14 and I never encountered such an
>> error under 2.6.14.
>>
>> My system configuration: I have two SATA drives, /dev/sdb7 is the root
>> partition using reiserfs.
>> SATA, SCSI and reiserfs are compiled into the kernel.

Ditto.

>> My kernel command line is just: root=/dev/sdb7
>>
>> lspci -v gives for the SATA controller:
>>
>> 0000:00:1f.2 IDE interface: Intel Corp. 82801FB/FW (ICH6/ICH6W) SATA
>> Controller (rev 03) (prog-if 8f [Master SecP SecO PriP PriO])
>>         Subsystem: Micro-Star International Co., Ltd.: Unknown device
>> 7091
>>         Flags: bus master, 66MHz, medium devsel, latency 0, IRQ 18
>>         I/O ports at e400 [size=8]
>>         I/O ports at e500 [size=4]
>>         I/O ports at e600 [size=8]
>>         I/O ports at e700 [size=4]
>>         I/O ports at e800 [size=16]
>>         Capabilities: [70] Power Management version 2
>>
>>
>> Sometimes the kernel boots without an error and sometimes it just

My problem is also somewhat intermittent but fairly common, which makes it more 
difficult to track down than a completely reproduceable bug.

>> panics. I found out (using a camera, since I can't log the sys messages
>> at this time) that there is one big difference between booting the
>> kernel with and without a panic.

Andre: serial console is your friend ;)

reuben
