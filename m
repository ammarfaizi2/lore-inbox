Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751447AbWFPTEU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751447AbWFPTEU (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 16 Jun 2006 15:04:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751448AbWFPTEU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 16 Jun 2006 15:04:20 -0400
Received: from wr-out-0506.google.com ([64.233.184.233]:3014 "EHLO
	wr-out-0506.google.com") by vger.kernel.org with ESMTP
	id S1751447AbWFPTET (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 16 Jun 2006 15:04:19 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:user-agent:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding;
        b=HFSKHGB7+4tEiWd2Sz9JwUSJ1h/bXgFrpo4hdHH0279rYa9oRA3ZoG5SyqQaN65Wro3I3dHfPL4Zr8NbIjHQxLc1xVOLwaObHMXQunb9nPQUp/dVBoTtaY2I3xQc/kaZMhpRhHDKGIrsd9OMTIUgoDSOtuu9b0pgrpn1bW4Q1f8=
Message-ID: <449300A2.7070306@gmail.com>
Date: Fri, 16 Jun 2006 12:04:02 -0700
From: Bruce Eleniak <beleniak@gmail.com>
User-Agent: Thunderbird 1.5.0.4 (Windows/20060516)
MIME-Version: 1.0
To: "K.R. Foley" <kr@cybsft.com>
CC: tglx@linutronix.de, Ingo Molnar <mingo@elte.hu>,
       linux-kernel@vger.kernel.org
Subject: Re: 2.6.17-rc6-rt3
References: <20060610082406.GA31985@elte.hu> <448D9F70.2040400@cybsft.com>	 <448DA21C.7090609@cybsft.com> <1150132934.5257.230.camel@localhost.localdomain> <448DA546.7070102@cybsft.com> <4492FDCC.6040102@gmail.com>
In-Reply-To: <4492FDCC.6040102@gmail.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Bruce Eleniak wrote:
> K.R. Foley wrote:
>> Thomas Gleixner wrote:
>>  
>>> On Mon, 2006-06-12 at 12:19 -0500, K.R. Foley wrote:
>>>    
>>>>> BUG: unable to handle kernel paging request at virtual address 
>>>>> f3010000
>>>>>  printing eip:
>>>>> *pde = 00000000
>>>>> Oops: 0000 [#1]
>>>>> PREEMPT SMP
>>>>> Modules linked in:
>>>>> CPU:    1
>>>>> EIP:    0060:[<c0132f9c>]    Not tainted VLI
>>>>> EFLAGS: 00010297   (2.6.17-rc6-rt4 #10)
>>>>> EIP is at lookup_symbol+0x11/0x35
>>>>> eax: 00000001   ebx: e083185c   ecx: c02f20c4   edx: c02f0000
>>>>> esi: f3010000   edi: e083185c   ebp: df597e80   esp: df597e74
>>>>> ds: 007b   es: 007b   ss: 0068   preempt: 00000001
>>>>> Process modprobe (pid: 1419, threadinfo=df596000 task=dec3ac90
>>>>> stack_left=7744 worst_left=-1)
>>>>> Stack: e083b580 00000bf0 e083185c df597e9c c0132fe5 df597eb4 df597eb0
>>>>> e083b580
>>>>>        00000bf0 e083185c df597ec4 c0133c93 00000001 00000012 e082dde8
>>>>> 00000000
>>>>>        df597ed8 e0839200 00000bf0 e082dde8 df597ee8 c01341fa e083b580
>>>>> 00000000
>>>>> Call Trace:
>>>>>  [<c01036a1>] show_stack_log_lvl+0x82/0x8a (36)
>>>>>  [<c0103821>] show_registers+0x139/0x1a1 (32)
>>>>>  [<c0103a15>] die+0x118/0x1df (60)
>>>>>  [<c0110cf3>] do_page_fault+0x45c/0x532 (76)
>>>>>  [<c010336b>] error_code+0x4f/0x54 (72)
>>>>>  [<c0132fe5>] __find_symbol+0x25/0x1b7 (28)
>>>>>  [<c0133c93>] resolve_symbol+0x27/0x5f (40)
>>>>>  [<c01341fa>] simplify_symbols+0x83/0xf3 (36)
>>>>>  [<c0134e31>] load_module+0x668/0x9e2 (184)
>>>>>  [<c0135210>] sys_init_module+0x42/0x1a4 (20)
>>>>>  [<c01027fb>] sysenter_past_esp+0x54/0x75 (-8116)
>>>>> Code: eb 11 8b 75 f0 41 83 c2 28 0f b7 46 30 39 c1 72 c9 31 c0 5a 
>>>>> 59 5b
>>>>> 5e 5f 5d c3 55 89 e5 57 56 53 89 c3 39 ca 73 22 8b 72 04 89 df 
>>>>> <ac> ae
>>>>> 75 08 84 c0 75 f8 31 c0 eb 04 19 c0 0c 01 85 c0 75 04 89
>>>>> EIP: [<c0132f9c>] lookup_symbol+0x11/0x35 SS:ESP 0068:df597e74
>>>>>         
>>>> DOH! That was actually 2.6.17-rc6-rt4. Sorry.
>>>>       
>>> Which module is it trying to load ?
>>>
>>>     tglx
>>>     
>>
>> Can't really say which it is trying to load when it dies. The lines
>> below are the lines that immediately preceed the oops.
>>
>> NET: Registered protocol family 1
>> input: AT Translated Set 2 keyboard as /class/input/input0
>> NET: Registered protocol family 17
>> NET: Registered protocol family 8
>> NET: Registered protocol family 20
>> Starting balanced_irq
>> Using IPI Shortcut mode
>> Time: tsc clocksource has been installed.
>> hrtimers: Switched to high resolution mode CPU 3
>> hrtimers: Switched to high resolution mode CPU 2
>> hrtimers: Switched to high resolution mode CPU 1
>> hrtimers: Switched to high resolution mode CPU 0
>> ***************************************************************************** 
>>
>> *
>>     *
>> *  REMINDER, the following debugging option is turned on in your
>> .config:   *
>> *
>>     *
>> *        CONFIG_DEBUG_RT_MUTEXES
>>      *
>> *
>>     *
>> *  it may increase runtime overhead and latencies.
>>     *
>> *
>>     *
>> ***************************************************************************** 
>>
>> Freeing unused kernel memory: 200k freed
>> input: ImExPS/2 Generic Explorer Mouse as /class/input/input1
>> kjournald starting.  Commit interval 5 seconds
>> EXT3-fs: mounted filesystem with ordered data mode.
>>
>>   
> Similar for me on a dual Xeon 3.2 with 2.6.17-rc6-rt4:
>
> ***************************************************************************** 
>
> Time: tsc clocksource has been installed.
> hrtimers: Switched to high resolution mode CPU 0
> hrtimers: Switched to high resolution mode CPU 1
> *                                                                           
> *
> *  REMINDER, the following debugging option is turned on in your 
> .config:   *
> *                                                                           
> *
> *        
> CONFIG_DEBUG_RT_MUTEXES                                             *
> *                                                                           
> *
> *  it may increase runtime overhead and 
> latencies.                          *
> *                                                                           
> *
> ***************************************************************************** 
>
> Freeing unused kernel memory: 208k freed
> Red Hat nash version 4.1.18.1 starting
> Mounted /proc filesystem
> Mounting sysfs
> Creating /dev
> Starting udev
> Loading jbd.ko mBUG: unable to handle kernel paging request at virtual 
> address 75010000
> printing eip:
> c0135679
> *pde = 00000000
> Oops: 0000 [#1]
> PREEMPT SMP
> Modules linked in:
> CPU:    1
> Eodule
> IP:    0060:[<c0135679>]    Not tainted VLI
> EFLAGS: 00010297   (2.6.17-rc6-rt5 #1)
> EIP is at lookup_symbol+0xe/0x31
> eax: ffffffff   ebx: f881a7d2   ecx: c0332f3c   edx: c03309d8
> esi: 75010000   edi: f881a7d2   ebp: f7f27ec0   esp: f7f27e8c
> ds: 007b   es: 007b   ss: 0068   preempt: 00000001
> Process insmod (pid: 293, threadinfo=f7f27000 task=f7f360f0 
> stack_left=3672 worst_left=-1)
> Stack: f882e520 000010a0 f881a7d2 c01356bd f7f27ebc f882e520 000010a0 
> f881a7d2
>       00000012 c013630c 00000001 f881752c 00000000 c0334284 f882abc0 
> 000010a0
>       f881752c 0000008f c0136859 f882e520 00000000 f881931c f882e52c 
> f882e52d
> Call Trace:
> [<c01356bd>] __find_symbol+0x21/0x1b3 (16)
> [<c013630c>] resolve_symbol+0x27/0x61 (24)
> [<c0136859>] simplify_symbols+0x85/0xf7 (36)
> [<c0137532>] load_module+0x73f/0xaf9 (32)
> [<c013373e>] try_to_take_rt_mutex+0x165/0x172 (20)
> [<c013792f>] sys_init_module+0x24/0x1a0 (16)
> [<c013794d>] sys_init_module+0x42/0x1a0 (144)
> [<c01032d3>] sysenter_past_esp+0x54/0x75 (16)
> Code: 01 85 c0 75 04 89 c8 eb 0e 0f b7 45 30 41 83 c2 28 39 c1 72 cb 
> 31 c0 5a 5b 5e 5f 5d c3 57 56 53 89 c3 39 ca 73 22 8b 72 04 89 df <ac> 
> ae 75 08 84 c0 75 f8 31 c0 eb 04 19 c0 0c 01 85 c0
>
>
Whoops.  2.6.17-rc6-rt5 sorry.  FWIW, Thomas' 2.6.17-rc6-hrt4 runs fine 
in isolation from the rt patchset.
