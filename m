Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269246AbUINKUY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269246AbUINKUY (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Sep 2004 06:20:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269254AbUINKUY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Sep 2004 06:20:24 -0400
Received: from main.gmane.org ([80.91.229.2]:19083 "EHLO main.gmane.org")
	by vger.kernel.org with ESMTP id S269246AbUINKUR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Sep 2004 06:20:17 -0400
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: Georg Schild <dangertools@gmx.net>
Subject: Re: Losing too many ticks! .... on a VIA epia board
Date: Tue, 14 Sep 2004 11:53:16 +0200
Message-ID: <4146BF8C.20309@gmx.net>
References: <4146A09A.9010207@zensonic.dk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: 213-153-45-253.dyn.salzburg-online.at
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.7.2) Gecko/20040820
X-Accept-Language: en-us, en
In-Reply-To: <4146A09A.9010207@zensonic.dk>
X-Enigmail-Version: 0.85.0.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> Losing some ticks... checking if CPU frequency changed.
> Losing some ticks... checking if CPU frequency changed.
> Losing too many ticks!
> TSC cannot be used as a timesource. Possible reasons for this are:
>  You're running with Speedstep,
>  You don't have DMA enabled for your hard disk (see hdparm),
>  Incorrect TSC synchronization on an SMP system (see dmesg).
> Falling back to a sane timesource now.
> 
> 
> Furthermore editors like jed and emacs takes forever to start. A "strace 
> emacs /somefile" shows that it hangs in a poll right after gettimeofday.
> 
> Any clues to what is wrong and how I go about fixing it?!
> 
> Regards Thomas, Denmark
> 

I don't have a clue but the same problem on an amd64 system. I am 
running a 64bit 2.6.9-rc1-mm4 kernel on my machine and if i add the boot 
parameter report_lost_ticks it reports the same messages as your 
machine. Since 2.6.7 there is this parameter, before the lost ticks 
where reported all the time. I always thought that this is a 64bit 
problem because i have heard from others which have this problem too. 
Why are we loosing ticks? On my system it happens almost when an acpi 
event occurs. I know that they aren't reported anymore but I don't like 
the thing that my processor (or timesource) looses something.

Georg Schild

