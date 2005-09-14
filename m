Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965037AbVINGQz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965037AbVINGQz (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Sep 2005 02:16:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965039AbVINGQy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Sep 2005 02:16:54 -0400
Received: from uucp.cistron.nl ([62.216.30.38]:39319 "EHLO ncc1701.cistron.net")
	by vger.kernel.org with ESMTP id S965037AbVINGQy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Sep 2005 02:16:54 -0400
From: dth@cistron.nl (Danny ter Haar)
Subject: Re: Q: why _less_ performance on machine with SMP then with UP kernel ?
Date: Wed, 14 Sep 2005 06:16:53 +0000 (UTC)
Organization: Cistron
Message-ID: <dg8f8l$80n$1@news.cistron.nl>
References: <dg7fbf$5df$1@news.cistron.nl> <200509132254.15158.andrew@walrond.org>
X-Trace: ncc1701.cistron.net 1126678613 8215 62.216.30.70 (14 Sep 2005 06:16:53 GMT)
X-Complaints-To: abuse@cistron.nl
X-Newsreader: trn 4.0-test76 (Apr 2, 2001)
Originator: dth@cistron.nl (Danny ter Haar)
To: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Walrond  <andrew@walrond.org> wrote:
>> So what is the difference between UP & SMP ?
>Is there any indication in the system log that your userland (news?) software 
>was having problems?

Not really. The load of the machine doesn't get that high as normal.
On machines that feed usenet to us (usenet ==push system) i see that we
grow "backlog" (we're not accepting usenet as fast as we should).

>It may be entirely unrelated to your problem, but you 
>should anyway be aware of a nasty unresolved issue with all smp kernels >=  
>2.6.12 on smp x86_64 systems:
>
>	http://bugzilla.kernel.org/show_bug.cgi?id=4851


Now that you mention it, i saw this in the log file when running the SMP
kernel:

newsgate kernel: mv[7024]: segfault at 00002aaaaabc3648 rip 00002aaaaaaac80e 
 rsp 00007fffffdc17c0 error 4

It was only a oneliner, no further details.

>If you have any indication of userland problems, you might try
>	echo 0 > /proc/sys/kernel/randomize_va_space
>which much reduces (but seemingly does not completely remove) this issue for 
>most people.

What i  did try is the following (prior on other SMP kernels)
I tried binding certain processes to a certain cpu.
Did the same for the irq's.
Just to see if it mattered.

It didn't...

>> A very confused
>One of the major symptoms of this particular bug ;)

I know, that's why a plee for help is _my_ only resort ;-)
I do understand that at this level most people send in patches.

Thanks for your reply!

Will try the "echo 0" next time i boot a smp kernel.

Danny


