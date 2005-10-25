Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751437AbVJYFME@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751437AbVJYFME (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 25 Oct 2005 01:12:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751455AbVJYFME
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 25 Oct 2005 01:12:04 -0400
Received: from gateway-1237.mvista.com ([12.44.186.158]:63481 "EHLO
	hermes.mvista.com") by vger.kernel.org with ESMTP id S1751437AbVJYFMD
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 25 Oct 2005 01:12:03 -0400
Message-ID: <435DBE9E.2040205@mvista.com>
Date: Mon, 24 Oct 2005 22:11:58 -0700
From: George Anzinger <george@mvista.com>
Reply-To: george@mvista.com
Organization: MontaVista Software
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.12) Gecko/20050922 Fedora/1.7.12-1.3.1
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
Cc: torvalds@osdl.org, linux-kernel@vger.kernel.org,
       robustmutexes@lists.osdl.org
Subject: Re: [PATCH] 2.6.14-rc5 fails to build with out CONFIG_FUTEX
References: <435D6F50.1000403@mvista.com>	<20051024165452.3a809632.akpm@osdl.org>	<435D7E7F.6020608@mvista.com> <20051024175039.49d97e6f.akpm@osdl.org>
In-Reply-To: <20051024175039.49d97e6f.akpm@osdl.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton wrote:
> George Anzinger <george@mvista.com> wrote:
> 
>>Andrew Morton wrote:
>>
>>>George Anzinger <george@mvista.com> wrote:
>>>
>>>
>>>>Both kernel/exit.c and fs/dcache.c refer to functions in kernel/futex.c which is not built unless 
>>>>CONFIG_FUTEX is true.  This causes a build failure at link time:
>>>>  LD      vmlinux
>>>>kernel/built-in.o(.text+0xab58): In function `do_exit':
>>>>/usr/src/linux-2.6.14-rc/kernel/exit.c:851: undefined reference to `exit_futex'
>>>>fs/built-in.o(.text+0x1b2bf): In function `dput':
>>>>/usr/src/linux-2.6.14-rc/fs/dcache.c:165: undefined reference to `futex_free_robust_list'
>>>
>>>
>>>This problem is specific to the robust-futexes patch.
>>
>>And that appears to be in rc5, right?
>>
Ok, got it, excuse the noise.

-- 
George Anzinger   george@mvista.com
HRT (High-res-timers):  http://sourceforge.net/projects/high-res-timers/
