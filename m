Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267555AbUHWVwZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267555AbUHWVwZ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 Aug 2004 17:52:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268082AbUHWViu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 Aug 2004 17:38:50 -0400
Received: from host81-154-216-60.range81-154.btcentralplus.com ([81.154.216.60]:58023
	"EHLO worthy.swandive.local") by vger.kernel.org with ESMTP
	id S266553AbUHWULx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 Aug 2004 16:11:53 -0400
Message-ID: <412A4F87.1080707@btinternet.com>
Date: Mon, 23 Aug 2004 21:11:51 +0100
From: Grant Wilson <gww@btinternet.com>
User-Agent: Mozilla Thunderbird 0.7.3 (X11/20040819)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: lkml <linux-kernel@vger.kernel.org>
CC: Andrew Morton <akpm@osdl.org>
Subject: Re: 2.6.8.1-mm4 [ls]trace freeze
References: <87d61h90ak.fsf-news@hsp-law.de>
In-Reply-To: <87d61h90ak.fsf-news@hsp-law.de>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I get similar results on amd64 running Debian unstable:

 > strace rxvt
bad: scheduling while atomic!
Call Trace: <ffffffff8039d62e>{schedule+94} 
<ffffffff8013f27c>{ptrace_notify_info+316}
       <ffffffff8013f468>{get_signal_to_deliver+456} 
<ffffffff8010e9c3>{do_signal+163}
       <ffffffff8010f52f>{sysret_signal+28} 
<ffffffff8010f81b>{ptregsyscall_common+103}

execve("/usr/bin/rxvt".....
rxvt[3639]: segfault @ 0000002a95556e60 ...

bad: scheduling while atomic!
Call Trace: <ffffffff8039d26e>{schedule+94} 
<ffffffff8010faca>{retint_careful+13}

bad: scheduling while atomic!
Call Trace: <ffffffff8039d62e>{schedule+94} 
<ffffffff8013f27c>{ptrace_notify_info+316}
       <ffffffff8013f468>{get_signal_to_deliver+456} 
<ffffffff8010e9c3>{do_signal+163}
       <ffffffff8013360d>{printk+141} <ffffffff8039dc01>{thread_return+41}
       <ffffffff8010fb1c>{retint_signal}
--- SIGSEV (Segmentation fault) @ 0 (0) ---
Kernel panic - not syncing: Aiee, killing interrupt handler!

Rgds,
Grant Wilson

