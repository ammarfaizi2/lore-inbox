Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262707AbTJDTTM (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 4 Oct 2003 15:19:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262716AbTJDTTM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 4 Oct 2003 15:19:12 -0400
Received: from sisko.nodomain.org ([213.208.99.114]:23185 "EHLO
	mail.nodomain.org") by vger.kernel.org with ESMTP id S262707AbTJDTTG
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 4 Oct 2003 15:19:06 -0400
Message-ID: <3F7F1D21.1070503@nodomain.org>
Date: Sat, 04 Oct 2003 20:18:57 +0100
From: Tony Hoyle <tmh@nodomain.org>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030930 Debian/1.4-5
X-Accept-Language: en
MIME-Version: 1.0
To: Andi Kleen <ak@muc.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Oops linux 2.4.23-pre6 on amd64
References: <CYRo.18k.9@gated-at.bofh.it> <m3smm8q22o.fsf@averell.firstfloor.org>
In-Reply-To: <m3smm8q22o.fsf@averell.firstfloor.org>
Content-Type: multipart/mixed;
 boundary="------------080503060707070105050507"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------080503060707070105050507
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Andi Kleen wrote:
>
> Can you load the module whatever it is manually and then decode
> the oops while it's still loaded? Or better compile in all USB
> statically and see if it oopses too.

Oops, scratch that last one... It's invalid too as I used the original 
oops rather than the new one.  This one's the right one (honest!).

Tony

--------------080503060707070105050507
Content-Type: text/plain;
 name="newoops2.txt"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="newoops2.txt"

ksymoops 2.4.9 on x86_64 2.4.23-pre6-amd64.  Options used
     -V (default)
     -k /proc/ksyms (default)
     -l /proc/modules (default)
     -o /lib/modules/2.4.23-pre6-amd64/ (default)
     -m /boot/System.map-2.4.23-pre6-amd64 (default)

Warning: You did not tell me where to find symbol information.  I will
assume that the log matches the kernel and modules that are running
right now and I'll use the default options above for symbol resolution.
If the current kernel and/or modules do not match the log, you can get
more accurate output by telling me the kernel version and where to find
map, modules, ksyms etc.  ksymoops -h explains the options.

Unable to handle kernel paging request<1> at 00000000a000a700 RIP: [<00000000a000a700>]PML4 3f145067 PGD 0
Oops: 0010
CPU 0
Pid: 146, comm: modprobe.moduti Not tainted
RIP: 0010:[<00000000a000a700>]
Using defaults from ksymoops -t elf32-i386 -a i386
RSP: 0000:000001003f165de0  EFLAGS: 00010246
RAX: ffffffffa00220e0 RBX: ffffffffa0022560 RCX: 0000000000000007
RDX: ffffffffa00220e0 RSI: ffffffffa00220e0 RDI: 000001000262f800
RBP: 000001000262f800 R08: 0000000000000001 R09: ffffffffa00224e0
R10: ffffffffa0021fa0 R11: 0000000000000000 R12: ffffffffa00220e0
R13: 0000000000000000 R14: ffffff0000a11000 R15: 0000010002767c00
FS:  0000000000000000(0000) GS:ffffffff8034b540(0000) knlGS:0000000000000000
CS:  0010 DS: 002b ES: 002b CR0: 000000008005003b
CR2: 00000000a000a700 CR3: 0000000000101000 CR4: 00000000000006e0
Process modprobe.moduti (pid: 146, stackpage=1003f165000)
Stack: 000001003f165de0 0000000000000000 ffffffff80202fce 0000000000000007
       000001000262f800 ffffffffa0022560 0000000000000000 00000000000000b8
       ffffffff80203048 ffffffffffffffea ffffffffa001e000 0000000008088758
Call Trace: [<ffffffff80202fce>] [<ffffffffa0022560>]
       [<ffffffff80203048>] [<ffffffffa0021f4d>] [<ffffffff8012008e>]
       [<ffffffff8012e21c>] [<ffffffffa001e0b8>] [<ffffffff80189963>]
Code:  Bad RIP value.
CR2: 00000000a000a700
Warning (Oops_read): Code line not seen, dumping what data is available


>>EIP; a000a700 Before first symbol   <=====

>>RAX; ffffffffa00220e0 <[ehci-hcd]pci_ids+0/40>
>>RBX; ffffffffa0022560 <[ehci-hcd]ehci_pci_driver+0/4f>
>>RDX; ffffffffa00220e0 <[ehci-hcd]pci_ids+0/40>
>>RSI; ffffffffa00220e0 <[ehci-hcd]pci_ids+0/40>
>>R09; ffffffffa00224e0 <[ehci-hcd].rodata.end+3b9/419>
>>R10; ffffffffa0021fa0 <[ehci-hcd]__module_kernel_version+0/0>
>>R12; ffffffffa00220e0 <[ehci-hcd]pci_ids+0/40>

Trace; ffffffff80202fce <pci_announce_device+3e/60>
Trace; ffffffffa0022560 <[ehci-hcd]ehci_pci_driver+0/4f>
Trace; ffffffff80203048 <pci_register_driver+58/80>
Trace; ffffffffa0021f4d <[ehci-hcd]init+d/40>
Trace; ffffffff8012008e <sys_init_module+62e/6f0>
Trace; ffffffff8012e21c <handle_mm_fault+bc/180>
Trace; ffffffffa001e0b8 <[keybdev].data.end+919/921>
Trace; ffffffff80189963 <ia32_syscall+67/71>


2 warnings issued.  Results may not be reliable.

--------------080503060707070105050507--

