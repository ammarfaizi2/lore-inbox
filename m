Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262251AbUKDPNS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262251AbUKDPNS (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 Nov 2004 10:13:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262253AbUKDPNS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Nov 2004 10:13:18 -0500
Received: from out002pub.verizon.net ([206.46.170.141]:5259 "EHLO
	out002.verizon.net") by vger.kernel.org with ESMTP id S262251AbUKDPNM
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Nov 2004 10:13:12 -0500
From: Gene Heskett <gene.heskett@verizon.net>
Reply-To: gene.heskett@verizon.net
Organization: Organization: None, detectable by casual observers
To: linux-kernel@vger.kernel.org
Subject: Re: is killing zombies possible w/o a reboot?
Date: Thu, 4 Nov 2004 10:13:09 -0500
User-Agent: KMail/1.7
Cc: DervishD <lkml@dervishd.net>, Ian Campbell <icampbell@arcom.com>,
       Jan Knutar <jk-lkml@sci.fi>, Tom Felker <tfelker2@uiuc.edu>
References: <200411030751.39578.gene.heskett@verizon.net> <200411040907.22684.gene.heskett@verizon.net> <20041104142620.GA23973@DervishD>
In-Reply-To: <20041104142620.GA23973@DervishD>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Message-Id: <200411041013.09124.gene.heskett@verizon.net>
X-Authentication-Info: Submitted using SMTP AUTH at out002.verizon.net from [151.205.42.194] at Thu, 4 Nov 2004 09:13:09 -0600
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 04 November 2004 09:26, DervishD wrote:
>    Hi Gene :)
>
> * Gene Heskett <gene.heskett@verizon.net> dixit:
>> Possibly, but OTOH,
>> [root@coyote root]#  cat /proc/sys/kernel/sysrq
>> 0
>>
>> And no, I'm not turning it off anyplace in the boot proceedure. 
>> An 'echo 1 >/proc/sys/kernel/sysrq', and repeating the keypresses
>> now gets a boatload of stuff in the logs, but nothing on the
>> console.
>
>    Well, the stuff goes to the logs and not the console because of
>the console log level. You can change that using proc, too. Look in
>/proc/sys/kernel/printk (well, at least under 2.4.x). You'll see
>four numbers. The first one is the console loglevel. Any message
>directed to syslog with a priority higher than this number will be
>printed in the console. Otherwise they won't.
>
>    The second number is the default message level. Any message
>without a priority will get this priority.
>
>    The third number is the highest value you can assign to the
> first number (the console loglevel).
>
>    The fourth number is the default value for the first number.
>
>    The interesting number for you is the first one. Set it to a
>correct value for you (see syslog(2) to see what the numbers mean).
>
>    Raúl Núñez de Arenas Coronado

I have it going to the logs as the prefered method as thats permanent 
whereas the console output is 100% volatile.  That way I can look at 
the logs when the machine has been made functional again.

-- 
Cheers, Gene
"There are four boxes to be used in defense of liberty:
 soap, ballot, jury, and ammo. Please use in that order."
-Ed Howdershelt (Author)
99.28% setiathome rank, not too shabby for a WV hillbilly
Yahoo.com attorneys please note, additions to this message
by Gene Heskett are:
Copyright 2004 by Maurice Eugene Heskett, all rights reserved.
