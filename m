Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S273261AbRJENzX>; Fri, 5 Oct 2001 09:55:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S277364AbRJENzN>; Fri, 5 Oct 2001 09:55:13 -0400
Received: from mplsdslgw14poolA71.mpls.uswest.net ([63.229.192.71]:57422 "EHLO
	bear.iucha.org") by vger.kernel.org with ESMTP id <S273261AbRJENzL>;
	Fri, 5 Oct 2001 09:55:11 -0400
Date: Fri, 5 Oct 2001 08:55:39 -0500
From: iuchaflorin@qwest.net
To: linux-kernel@vger.kernel.org
Cc: linux@connectcom.net, bfrey@turbolinux.com.cn
Subject: Re: linux-2.4.11-pre3-xfs oops in advansys driver
Message-ID: <20011005085539.A409@bear.iucha.org>
Mail-Followup-To: linux-kernel@vger.kernel.org, linux@connectcom.net,
	bfrey@turbolinux.com.cn
In-Reply-To: <20011005081552.A518@bear.iucha.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20011005081552.A518@bear.iucha.org>
User-Agent: Mutt/1.3.22i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The oops happened again:

Before oops:

advansys: adv_isr_callback: board 0: scp 0xdfef0800 not on active queue
advansys: adv_isr_callback: board 0: scp 0xdfef0a00 not on active queue
advansys: adv_isr_callback: board 0: scp 0xdfef0c00 not on active queue
advansys: adv_isr_callback: board 0: scp 0xdfef9e00 not on active queue
advansys: adv_isr_callback: board 0: scp 0xdfef9c00 not on active queue
advansys: adv_isr_callback: board 0: scp 0xdfef0600 not on active queue
advansys: adv_isr_callback: board 0: scp 0xdfef9a00 not on active queue
advansys: adv_isr_callback: board 0: scp 0xdfefe000 not on active queue

and decoded:

ksymoops 2.4.3 on i586 2.4.11-pre3-xfs.  Options used
     -V (default)
     -k /proc/ksyms (default)
     -l /proc/modules (default)
     -o /lib/modules/2.4.11-pre3-xfs/ (default)
     -m /boot/System.map-2.4.11-pre3-xfs (default)

Warning: You did not tell me where to find symbol information.  I will
assume that the log matches the kernel and modules that are running
right now and I'll use the default options above for symbol resolution.
If the current kernel and/or modules do not match the log, you can get
more accurate output by telling me the kernel version and where to find
map, modules, ksyms etc.  ksymoops -h explains the options.

Unable to handle kernel paging request at virtual address 88000516
c022c5ae
*pde = 00000000
Oops: 0002
CPU:    0
EIP:    0010:[<c022c5ae>]    Not tainted
Using defaults from ksymoops -t elf32-i386 -a i386
EFLAGS: 00210002
eax: c186ad50   ebx: c80004fe   ecx: dc55e000   edx: f000ef57
esi: 880004fe   edi: c0335084   ebp: 00200046   esp: c02d1f2c
ds: 0018   es: 0018   ss: 0018
Process swapper (pid: 0, stackpage=c02d1000)
Stack: c0335000 c033507c 00000000 c02248dc c0335084 c180ef40 24000001 00000005
       c02d1fa8 00000000 00000000 dfee9a20 00000000 c0107d6c 00000005 c033507c
       c02d1fa8 000000a0 c03049a0 00000005 c02d1fa0 c0107ece 00000005 c02d1fa8
Call Trace: [<c02248dc>] [<c0107d6c>] [<c0107ece>] [<c0105150>] [<c0109c68>]
   [<c0105150>] [<c0105173>] [<c01051d7>] [<c0105000>] [<c0105027>]
Code: c6 83 18 00 00 c0 01 c6 83 19 00 00 c0 00 c6 83 1a 00 00 c0

>>EIP; c022c5ae <AdvISR+72/12c>   <=====
Trace; c02248dc <advansys_interrupt+84/180>
Trace; c0107d6c <handle_IRQ_event+30/5c>
Trace; c0107ece <do_IRQ+6e/b0>
Trace; c0105150 <default_idle+0/28>
Trace; c0109c68 <call_do_IRQ+6/e>
Trace; c0105150 <default_idle+0/28>
Trace; c0105172 <default_idle+22/28>
Trace; c01051d6 <cpu_idle+3e/54>
Trace; c0105000 <_stext+0/0>
Trace; c0105026 <rest_init+26/28>
Code;  c022c5ae <AdvISR+72/12c>
00000000 <_EIP>:
Code;  c022c5ae <AdvISR+72/12c>   <=====
   0:   c6 83 18 00 00 c0 01      movb   $0x1,0xc0000018(%ebx)   <=====
Code;  c022c5b4 <AdvISR+78/12c>
   7:   c6 83 19 00 00 c0 00      movb   $0x0,0xc0000019(%ebx)
Code;  c022c5bc <AdvISR+80/12c>
   e:   c6 83 1a 00 00 c0 00      movb   $0x0,0xc000001a(%ebx)

 <0>Kernel panic: Aiee, killing interrupt handler!

1 warning issued.  Results may not be reliable.

florin

-- 

"If it's not broken, let's fix it till it is."

41A9 2BDE 8E11 F1C5 87A6  03EE 34B3 E075 3B90 DFE4
