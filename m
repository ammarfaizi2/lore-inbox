Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932163AbWEAROq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932163AbWEAROq (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 1 May 2006 13:14:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932164AbWEAROq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 1 May 2006 13:14:46 -0400
Received: from smtp-out.google.com ([216.239.45.12]:58305 "EHLO
	smtp-out.google.com") by vger.kernel.org with ESMTP id S932163AbWEAROq
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 1 May 2006 13:14:46 -0400
DomainKey-Signature: a=rsa-sha1; s=beta; d=google.com; c=nofws; q=dns;
	h=received:message-id:date:from:user-agent:
	x-accept-language:mime-version:to:cc:subject:references:in-reply-to:
	content-type:content-transfer-encoding;
	b=hNVla/c/XnjLFhRv14+RDxf7fbZwXWSYh7U1mPR72qonjIokw5LjOb17IRdLw6cjU
	gMGHg6HohLUFSEZBQEKWw==
Message-ID: <445641EF.70601@google.com>
Date: Mon, 01 May 2006 10:14:23 -0700
From: Martin Bligh <mbligh@google.com>
User-Agent: Mozilla Thunderbird 1.0.7 (X11/20051011)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: apw@shadowen.org, linuxppc64-dev@ozlabs.org, linux-kernel@vger.kernel.org,
       ak@suse.de
Subject: Re: 2.6.17-rc2-mm1
References: <4450F5AD.9030200@google.com>	<20060428012022.7b73c77b.akpm@osdl.org>	<44561A1E.7000103@google.com> <20060501100731.051f4eff.akpm@osdl.org>
In-Reply-To: <20060501100731.051f4eff.akpm@osdl.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


>>double fault: 0000 [1] SMP
>>last sysfs file: /devices/pci0000:00/0000:00:06.0/resource
>>CPU 0
>>Modules linked in:
>>Pid: 20519, comm: mtest01 Not tainted 2.6.17-rc3-mm1-autokern1 #1
>>RIP: 0010:[<ffffffff8047c8b8>] <ffffffff8047c8b8>{__sched_text_start+1856}
>>RSP: 0000:0000000000000000  EFLAGS: 00010082
>>RAX: 0000000000000000 RBX: 0000000000000000 RCX: ffffffff805d9438
>>RDX: ffff8100db12c0d0 RSI: ffffffff805d9438 RDI: ffff8100db12c0d0
>>RBP: ffffffff805d9438 R08: 0000000000000000 R09: 0000000000000000
>>R10: 0000000000000000 R11: 0000000000000000 R12: 0000000000000000
>>R13: ffff8100e39bd440 R14: ffff810008003620 R15: 000002b02751726c
>>FS:  0000000000000000(0000) GS:ffffffff805fa000(0063) knlGS:00000000f7dd0460
>>CS:  0010 DS: 002b ES: 002b CR0: 000000008005003b
>>CR2: fffffffffffffff8 CR3: 00000000da399000 CR4: 00000000000006e0
>>Process mtest01 (pid: 20519, threadinfo ffff8100b1bb4000, task 
>>ffff8100db12c0d0)
>>Stack: ffffffff80579e20 ffff8100db12c0d0 0000000000000001 ffffffff80579f58
>>        0000000000000000 ffffffff80579e78 ffffffff8020b0b2 ffffffff80579f58
>>        0000000000000000 ffffffff80485520
>>Call Trace: <#DF> <ffffffff8020b0b2>{show_registers+140}
>>        <ffffffff8020b357>{__die+159} <ffffffff8020b3cc>{die+50}
>>        <ffffffff8020bba6>{do_double_fault+115} 
>><ffffffff8020aa91>{double_fault+125}
>>        <ffffffff8047c8b8>{__sched_text_start+1856} <EOE>
>>
>>Code: e8 4c ba d8 ff 65 48 8b 34 25 00 00 00 00 4c 8b 46 08 f0 41
>>RIP <ffffffff8047c8b8>{__sched_text_start+1856} RSP <0000000000000000>
>>  -- 0:conmux-control -- time-stamp -- May/01/06  3:54:37 --
> 
> 
> I was not able to reproduce this on the 4-way EMT64 machine.  Am a bit stuck.

OK, is there anything we could run this with that'd dump more info?
(eg debug patches or something). There's bugger all of use that I
can see in that stack (and why does __sched_text_start come up anyway,
is that an x86_64-ism ?). I suppose if we're really desperate, we can
play chop search, but that's very boring to try to do remotely ...

It's a couple-of-year-old 4x newisys box.

M.
