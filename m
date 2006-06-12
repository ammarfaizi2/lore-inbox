Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750725AbWFLRdU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750725AbWFLRdU (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 Jun 2006 13:33:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750794AbWFLRdU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 Jun 2006 13:33:20 -0400
Received: from mail2.utc.com ([192.249.46.191]:43708 "EHLO mail2.utc.com")
	by vger.kernel.org with ESMTP id S1750725AbWFLRdT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 Jun 2006 13:33:19 -0400
Message-ID: <448DA546.7070102@cybsft.com>
Date: Mon, 12 Jun 2006 12:32:54 -0500
From: "K.R. Foley" <kr@cybsft.com>
Organization: Cybersoft Solutions, Inc.
User-Agent: Thunderbird 1.5.0.4 (X11/20060516)
MIME-Version: 1.0
To: tglx@linutronix.de
CC: Ingo Molnar <mingo@elte.hu>, linux-kernel@vger.kernel.org
Subject: Re: 2.6.17-rc6-rt3
References: <20060610082406.GA31985@elte.hu> <448D9F70.2040400@cybsft.com>	 <448DA21C.7090609@cybsft.com> <1150132934.5257.230.camel@localhost.localdomain>
In-Reply-To: <1150132934.5257.230.camel@localhost.localdomain>
X-Enigmail-Version: 0.93.0.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Thomas Gleixner wrote:
> On Mon, 2006-06-12 at 12:19 -0500, K.R. Foley wrote:
>>> BUG: unable to handle kernel paging request at virtual address f3010000
>>>  printing eip:
>>> *pde = 00000000
>>> Oops: 0000 [#1]
>>> PREEMPT SMP
>>> Modules linked in:
>>> CPU:    1
>>> EIP:    0060:[<c0132f9c>]    Not tainted VLI
>>> EFLAGS: 00010297   (2.6.17-rc6-rt4 #10)
>>> EIP is at lookup_symbol+0x11/0x35
>>> eax: 00000001   ebx: e083185c   ecx: c02f20c4   edx: c02f0000
>>> esi: f3010000   edi: e083185c   ebp: df597e80   esp: df597e74
>>> ds: 007b   es: 007b   ss: 0068   preempt: 00000001
>>> Process modprobe (pid: 1419, threadinfo=df596000 task=dec3ac90
>>> stack_left=7744 worst_left=-1)
>>> Stack: e083b580 00000bf0 e083185c df597e9c c0132fe5 df597eb4 df597eb0
>>> e083b580
>>>        00000bf0 e083185c df597ec4 c0133c93 00000001 00000012 e082dde8
>>> 00000000
>>>        df597ed8 e0839200 00000bf0 e082dde8 df597ee8 c01341fa e083b580
>>> 00000000
>>> Call Trace:
>>>  [<c01036a1>] show_stack_log_lvl+0x82/0x8a (36)
>>>  [<c0103821>] show_registers+0x139/0x1a1 (32)
>>>  [<c0103a15>] die+0x118/0x1df (60)
>>>  [<c0110cf3>] do_page_fault+0x45c/0x532 (76)
>>>  [<c010336b>] error_code+0x4f/0x54 (72)
>>>  [<c0132fe5>] __find_symbol+0x25/0x1b7 (28)
>>>  [<c0133c93>] resolve_symbol+0x27/0x5f (40)
>>>  [<c01341fa>] simplify_symbols+0x83/0xf3 (36)
>>>  [<c0134e31>] load_module+0x668/0x9e2 (184)
>>>  [<c0135210>] sys_init_module+0x42/0x1a4 (20)
>>>  [<c01027fb>] sysenter_past_esp+0x54/0x75 (-8116)
>>> Code: eb 11 8b 75 f0 41 83 c2 28 0f b7 46 30 39 c1 72 c9 31 c0 5a 59 5b
>>> 5e 5f 5d c3 55 89 e5 57 56 53 89 c3 39 ca 73 22 8b 72 04 89 df <ac> ae
>>> 75 08 84 c0 75 f8 31 c0 eb 04 19 c0 0c 01 85 c0 75 04 89
>>> EIP: [<c0132f9c>] lookup_symbol+0x11/0x35 SS:ESP 0068:df597e74
>> DOH! That was actually 2.6.17-rc6-rt4. Sorry.
> 
> Which module is it trying to load ?
> 
> 	tglx

Can't really say which it is trying to load when it dies. The lines
below are the lines that immediately preceed the oops.

NET: Registered protocol family 1
input: AT Translated Set 2 keyboard as /class/input/input0
NET: Registered protocol family 17
NET: Registered protocol family 8
NET: Registered protocol family 20
Starting balanced_irq
Using IPI Shortcut mode
Time: tsc clocksource has been installed.
hrtimers: Switched to high resolution mode CPU 3
hrtimers: Switched to high resolution mode CPU 2
hrtimers: Switched to high resolution mode CPU 1
hrtimers: Switched to high resolution mode CPU 0
*****************************************************************************
*
    *
*  REMINDER, the following debugging option is turned on in your
.config:   *
*
    *
*        CONFIG_DEBUG_RT_MUTEXES
     *
*
    *
*  it may increase runtime overhead and latencies.
    *
*
    *
*****************************************************************************
Freeing unused kernel memory: 200k freed
input: ImExPS/2 Generic Explorer Mouse as /class/input/input1
kjournald starting.  Commit interval 5 seconds
EXT3-fs: mounted filesystem with ordered data mode.

-- 
   kr
