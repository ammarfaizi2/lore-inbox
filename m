Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262190AbULMBur@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262190AbULMBur (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 12 Dec 2004 20:50:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262191AbULMBur
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 12 Dec 2004 20:50:47 -0500
Received: from out008pub.verizon.net ([206.46.170.108]:64749 "EHLO
	out008.verizon.net") by vger.kernel.org with ESMTP id S262190AbULMBug
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 12 Dec 2004 20:50:36 -0500
From: Gene Heskett <gene.heskett@verizon.net>
Reply-To: gene.heskett@verizon.net
Organization: Organization: None, detectable by casual observers
To: linux-kernel@vger.kernel.org
Subject: Re: dummy help on io
Date: Sun, 12 Dec 2004 20:50:34 -0500
User-Agent: KMail/1.7
Cc: "Randy.Dunlap" <rddunlap@osdl.org>
References: <200412121854.48898.gene.heskett@verizon.net> <41BCDE26.9030309@osdl.org>
In-Reply-To: <41BCDE26.9030309@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200412122050.34610.gene.heskett@verizon.net>
X-Authentication-Info: Submitted using SMTP AUTH at out008.verizon.net from [151.205.42.94] at Sun, 12 Dec 2004 19:50:35 -0600
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sunday 12 December 2004 19:11, Randy.Dunlap wrote:
>Gene Heskett wrote:
>> Greetings;
>>
>> I've ordered the device drivers book from O-Reilly but it will be
>> a few days getting here.
>
>Get it online:
>http://lwn.net/Kernel/LDD2/

Thanks, but my printer is down, I mde the mistake of installing
cups-1.1.22.  But I'll go get it anyway.
>
>> I'm trying to mod the GPL'd archive PIO.tar.gz, so it will build a
>> driver for a pci card with 3 each 82C55's on it, and I *think* I'd
>> have it working with the first of the 3 chips if I could figure
>> out what to do about using the call "iopl(3);" on installing
>> the driver, and conversely an "iopl(0);" at rmmod time.
>
>Where is that coming from?  I don't see it in the tarball
>or the web site (if I'm looking at the right place).
>   http://ieee.uow.edu.au/~daniel/software/robotd/

<http://ieee.uow.edu.au/~daniel/software/PIO/>

>> I'm told this is required to gain access perms to addresses above
>> 0x3FF.  The call "ioperm" is used below that I've been told.
>
>iopl() and ioperm() are userspace calls that call (g)libc.
>The kernel doesn't call them.

So my driver module does need them?

>> Unforch, an "insmod PIO io=0xf100" (where the card is addressed
>> at currently) is spitting out an "unresolved symbol" error for the
>> iopl call.
>>
>> Being a rank beginner at "pc" hardware, can someone give me a
>> checklist of things I've probably left out please?
>
>Can you put the iopl() call into your app instead?

I can try it in the examples demo.c which I've modified to run
the motor 10 revolutions, if it runs.  1 step/sec.  That runs
without any errors *if* I take the iopl() back out of the driver
and insmod it.

>or into a shell script that forks the app (since the iopl
>man page says:  Permissions are inherited by fork and exec.)
>
>> Kernel is 2.4.25-adeos.  With the module "rtai" inserted when emc
>> is running for realtime control purposes.
>>
>> The card is pure hardware, no bios, only address decoding that
>> can set the base address anyplace in the first 64k of address
>> space in a step of 4 sequence from 0xnn00-0xnn0C for the 4
>> ports of chip 1, 0xnn10-1C for chip 2, etc, where the nn is the
>> dipswitch setting.

-- 
Cheers, Gene
"There are four boxes to be used in defense of liberty:
 soap, ballot, jury, and ammo. Please use in that order."
-Ed Howdershelt (Author)
99.30% setiathome rank, not too shabby for a WV hillbilly
Yahoo.com attorneys please note, additions to this message
by Gene Heskett are:
Copyright 2004 by Maurice Eugene Heskett, all rights reserved.

