Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751307AbWAaRwR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751307AbWAaRwR (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 31 Jan 2006 12:52:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751309AbWAaRwR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 31 Jan 2006 12:52:17 -0500
Received: from war.OCF.Berkeley.EDU ([192.58.221.244]:14282 "EHLO
	war.OCF.Berkeley.EDU") by vger.kernel.org with ESMTP
	id S1751307AbWAaRwQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 31 Jan 2006 12:52:16 -0500
Date: Tue, 31 Jan 2006 09:52:08 -0800 (PST)
From: chris perkins <cperkins@OCF.Berkeley.EDU>
To: Clark Williams <williams@redhat.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.15-rt16
In-Reply-To: <1138653235.26657.7.camel@localhost.localdomain>
Message-ID: <Pine.SOL.4.63.0601310946000.8770@conquest.OCF.Berkeley.EDU>
References: <Pine.SOL.4.63.0601300839050.8546@conquest.OCF.Berkeley.EDU> 
 <1138640592.12625.0.camel@localhost.localdomain> 
 <Pine.SOL.4.63.0601300917120.8546@conquest.OCF.Berkeley.EDU>
 <1138653235.26657.7.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> <snip>
>
>> CONFIG_LATENCY_TIMING=y
>
> I'm betting this is the same thing I'm seeing. Are you running on a
> uniprocessor x86_64? And if so are you seeing messages similar to the
> following?
>
> init[1]: segfault at ffffffff8010fadc rip ffffffff8010fadc rsp
> 00007fffffdacfc8
>
> If so, then I suspect that you're getting a segfault in ld.so (at least
> that's the furthest I've gotten so far). Something about how the kernel
> sets up the memory map is upsetting dynamically loaded executables. I
> can boot with init=/sbin/sash, but when I try and run a dynamically
> linked program, I get segfaults.
>
> You might try turning off LATENCY_TRACING and see if that allows you to
> boot and run (works for me).
>
> Meanwhile, I'm going to try and pin this down to something better than
> "somewhere in ld.so..."
>
> Clark
> -
> Clark Williams <williams@redhat.com>

hi,
   actually i'm running on a dual processor x86_64. with the problem i was 
having, i never got far enough to see the message you asked about. Steven 
Rostedt's suggestion to turn off NUMA worked and i am now able to boot. 
However, if I turn LATENCY_TRACING on, i get an immediate reboot after the 
kernel is uncompressed. this doesn't sound like the same problem you're 
having, though.
   -chris
