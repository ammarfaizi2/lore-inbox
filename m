Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129166AbQKTWib>; Mon, 20 Nov 2000 17:38:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129165AbQKTWiV>; Mon, 20 Nov 2000 17:38:21 -0500
Received: from p3EE00B8B.dip.t-dialin.net ([62.224.11.139]:45044 "EHLO
	mail.linsoft.de") by vger.kernel.org with ESMTP id <S129136AbQKTWiI> convert rfc822-to-8bit;
	Mon, 20 Nov 2000 17:38:08 -0500
From: Oliver Poths <oliver.poths@linsoft.de>
Date: Mon, 20 Nov 2000 22:07:43 GMT
Message-ID: <20001120.22074300@rock.>
Subject: Re: kernel-2.4.0-test11 crashed again; this time i send you the
 Oops-message 
To: Tigran Aivazian <tigran@veritas.com>, linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.21.0011202121000.1664-100000@penguin.homenet>
In-Reply-To: <Pine.LNX.4.21.0011202121000.1664-100000@penguin.homenet>
X-Mailer: Mozilla/3.0 (compatible; StarOffice/5.2;Linux)
X-Priority: 3 (Normal)
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Here´s the output of ksymoops:

No modules in ksyms, skipping objects
Warning (read_lsmod): no symbols in lsmod, is /proc/modules a valid lsmod 
file?
Warning (compare_maps): ksyms_base symbol 
machine_real_restart_R__ver_machine_real_restart not found in System.map. 
 Ignoring ksyms_base entry
Unable to handle kernel NULL pointer dereference at virtual address 
00000010 printing eip:
c01c8e66
*pde = 00000000
Oops: 0000
CPU:    0
EIP:    0010:[<c01c8e66>]
Using defaults from ksymoops -t elf32-i386 -a i386
EFLAGS: 00010246
eax: 00000000   ebx: c7f5f000     ecx: c7f61000       edx: c7fe1e64
esi: c7f58000   edi: c7f6abc0     ebp: 00001000       esp: c7fe1e18
ds: 0018        es: 0018       ss: 0018
Process swapper (pid:1, stackpage=c7fe1000)
Stack: 00001000 c7f58000 c7f5f000 c7f61000 c7fe1e64 00000003 c7f6abc0 
00000003
         c01cbda5 00000003 c7fe1e64 00000003 00000003 c1249bc0 c1240400 
c7fe1e78
         00000000 c7f6abc0 c1240400 c7f6abc0 c7f75340 c7f752c0 00000000 
00000000
Call Trace: [<c01cbda5>] [<c01cbe7c>] [<c01cc274>] [<c01c448c>] 
[<c011ad30>] [<c01c47e1>] [<c024174f>]
        [<c01c49f2>] [<c0107007>] [<c0108d58>]
Code: 8b 40 10 ff d0 83 c4 10 eb 3b 8b 42 0c 8b 78 34 83 7c 24 14

>>EIP; c01c8e66 <xor_block+46/90>   <=====
Trace; c01cbda5 <__check_consistency+165/230>
Trace; c01cbe7c <check_consistency+c/20>
Trace; c01cc274 <raid5_run+3e4/6b0>
Trace; c01c448c <do_md_run+2ac/320>
Trace; c011ad30 <printk+150/160>
Trace; c01c47e1 <autorun_array+81/b0>
Trace; c024174f <usb_bandwidth_option+3da3/8339>
Trace; c01c49f2 <autorun_devices+1e2/210>
Trace; c0107007 <init+7/110>
Trace; c0108d58 <kernel_thread+28/40>
Code;  c01c8e66 <xor_block+46/90>
00000000 <_EIP>:
Code;  c01c8e66 <xor_block+46/90>   <=====
   0:   8b 40 10                  mov    0x10(%eax),%eax   <=====
Code;  c01c8e69 <xor_block+49/90>
   3:   ff d0                     call   *%eax
Code;  c01c8e6b <xor_block+4b/90>
   5:   83 c4 10                  add    $0x10,%esp
Code;  c01c8e6e <xor_block+4e/90>
   8:   eb 3b                     jmp    45 <_EIP+0x45> c01c8eab 
<xor_block+8b/90>
Code;  c01c8e70 <xor_block+50/90>
   a:   8b 42 0c                  mov    0xc(%edx),%eax
Code;  c01c8e73 <xor_block+53/90>
   d:   8b 78 34                  mov    0x34(%eax),%edi
Code;  c01c8e76 <xor_block+56/90>
  10:   83 7c 24 14 00            cmpl   $0x0,0x14(%esp,1)

Kernel panic: Attempted to kill init!

3 warnings issued.  Results may not be reliable.

Hope this helps!
Oliver Poths


>>>>>>>>>>>>>>>>>> Ursprüngliche Nachricht <<<<<<<<<<<<<<<<<<

Am 20.11.00, 22:22:30, schrieb Tigran Aivazian <tigran@veritas.com> zum 
Thema Re: kernel-2.4.0-test11 crashed again; this time i send you the 
Oops-message :


> On Mon, 20 Nov 2000, Oliver Poths wrote:
> > looks fascinating...

> you know, it looks even more fascinating when you pass it through 
ksymoops
> like this:

> ksymoops < rawoops > oops

> and then mail the result.

> Regards,
> Tigran
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
