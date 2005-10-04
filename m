Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965035AbVJDXlI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965035AbVJDXlI (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 4 Oct 2005 19:41:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965036AbVJDXlH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 4 Oct 2005 19:41:07 -0400
Received: from relay00.pair.com ([209.68.5.9]:53257 "HELO relay.pair.com")
	by vger.kernel.org with SMTP id S965035AbVJDXlG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 4 Oct 2005 19:41:06 -0400
X-pair-Authenticated: 67.163.102.102
From: Chase Venters <chase.venters@clientec.com>
To: Marc Perkel <marc@perkel.com>
Subject: Re: what's next for the linux kernel?
Date: Tue, 4 Oct 2005 18:40:33 -0500
User-Agent: KMail/1.8.1
Cc: Luke Kenneth Casson Leighton <lkcl@lkcl.net>, linux-kernel@vger.kernel.org
References: <20051002204703.GG6290@lkcl.net> <4342DC4D.8090908@perkel.com>
In-Reply-To: <4342DC4D.8090908@perkel.com>
Organization: Clientec, Inc.
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200510041840.55820.chase.venters@clientec.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 04 October 2005 02:47 pm, Marc Perkel wrote:
> The bootup sequence of Linux is pathetic. What an ungodly mess. The
> FSTAB file needs to go and a smarter system needs to be developed. I
> know this isn't entirely a kernel issue but it is somewhat related.
>
> I think development needs to be done to make the kernel cleaner and
> smarter rather than just bigger and faster. It's time to look at what
> users need and try to make Linux somewhat more windows like in being
> able to smartly recover from problems. Perhaps better error messages
> that your traditional kernel panic or hex dump screen of death.
>
> The big challenge for Linux is to be able to put it in the hands of
> people who don't want to dedicate their entire life to understanding all
> the little quirks that we have become used to. The slogan should be
> "this just works" and is intuitive.

I agree with the basic sentiment here.

fstab is pretty traditional - and you're right, it really isn't a kernel thing 
per se. Let's not forget the value of simplicity though. fstab works and does 
its job well. I do think it would be interesting for a distribution to 
experiment with different approaches, though -- something with the emerging 
hardware abstraction layer perhaps.

As for error messages... the equivalent of the Linux kernel panic is basically 
the Windows BSOD. Neither one of them should appear in the day to day use of 
the system as they indicate bugs. Linux is actually the clear winner here, I 
think, because a Windows BSOD gives you a single hex code and no indication 
of what happened, except for very vague codes like 
"PAGE_FAULT_IN_NON_PAGED_AREA". I'd much rather have a backtrace :) In any 
case, I'm watching the work on kdump with a keen interest.

Really, I think the whole issue of usability isn't tied directly to the 
kernel. The kernel has been making leaps and bounds in making this easy for 
userspace to deal with (where the approaches to solve the problem belong). 
Sysfs is an obvious great example.

Work on dbus and HAL should give us good improvements in these areas. One 
remaining challenge I see is system configuration - each daemon tends to 
adopt its own syntax for configuration, which means that providing a GUI for 
novice users to manage these systems means attacking each problem separately 
and in full. Now I certainly wouldn't advocate a Windows-style registry, 
because I think it's full of obvious problems. Nevertheless, it would be nice 
to have some kind of configuration editor abstraction library that had some 
sort of syntax definition database to allow for some interesting work on 
GUIs.

In any case, I think pretty much all of this work lives outside the kernel. 
There is one side note I'd make about booting - my own boot process has to 
wait forever for my Adaptec SCSI controller to wake up. It would be 
interesting if bootup initialization tasks could be organized into dependency 
levels and run in parallel, though as I'm a beginner to the workings of the 
kernel I'm not entirely sure how possible this would be.

Cheers,
Chase Venters
