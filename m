Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262690AbTJDTFt (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 4 Oct 2003 15:05:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262692AbTJDTFs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 4 Oct 2003 15:05:48 -0400
Received: from sisko.nodomain.org ([213.208.99.114]:14993 "EHLO
	mail.nodomain.org") by vger.kernel.org with ESMTP id S262690AbTJDTFq
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 4 Oct 2003 15:05:46 -0400
Message-ID: <3F7F1A00.1010600@nodomain.org>
Date: Sat, 04 Oct 2003 20:05:36 +0100
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
 boundary="------------010102060508080901050909"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------010102060508080901050909
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Andi Kleen wrote:

> Can you load the module whatever it is manually and then decode
> the oops while it's still loaded? Or better compile in all USB
> statically and see if it oopses too.

Here's the decode with it loaded.  The oops happens during the 
initialisation of ehci-hcd (from an init=/bin/bash clean system, I did 
modprobe usb-uhci then modprobe ehci-hcd and it oopsed).

> Your legacy USB problems are very likely BIOS bugs.

Well this BIOS does insist I have 'sourth' bridge, so I don't have high 
hopes on that score :)

Tony


--------------010102060508080901050909
Content-Type: text/plain;
 name="oops3.txt"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="oops3.txt"

ksymoops 2.4.9 on x86_64 2.4.23-pre6-amd64.  Options used
     -V (default)
     -k /proc/ksyms (default)
     -l /proc/modules (default)
     -o /lib/modules/2.4.23-pre6-amd64/ (default)
     -m /boot/System.map-2.4.23-pre6-amd64 (default)
     -t elf64-x86-64 -a x86-64

Warning: You did not tell me where to find symbol information.  I will
assume that the log matches the kernel and modules that are running
right now and I'll use the default options above for symbol resolution.
If the current kernel and/or modules do not match the log, you can get
more accurate output by telling me the kernel version and where to find
map, modules, ksyms etc.  ksymoops -h explains the options.

Oct  4 19:23:06 (none) kernel: Unable to handle kernel paging request<1> at 00000000a000a700 RIP: [<00000000a000a700>]PML4 3ef32067 PGD 0
Oct  4 19:23:06 (none) kernel: Oops: 0010
Oct  4 19:23:06 (none) kernel: CPU 0
Oct  4 19:23:06 (none) kernel: Pid: 104, comm: modprobe Not tainted
Oct  4 19:23:06 (none) kernel: RIP: 0010:[<00000000a000a700>]
Oct  4 19:23:06 (none) kernel: RSP: 0000:000001003efddde0  EFLAGS: 00010246
Oct  4 19:23:06 (none) kernel: RAX: ffffffffa00140e0 RBX: ffffffffa0014560 RCX: 0000000000000007
Oct  4 19:23:06 (none) kernel: RDX: ffffffffa00140e0 RSI: ffffffffa00140e0 RDI: 000001000262f800
Oct  4 19:23:06 (none) kernel: RBP: 000001000262f800 R08: 0000000000001000 R09: 00000100025a2b08
Oct  4 19:23:06 (none) kernel: R10: 000000000003ef30 R11: 0000010001000048 R12: ffffffffa00140e0
Oct  4 19:23:06 (none) kernel: R13: 0000000000000000 R14: ffffff0000a11000 R15: 000001003eed9140
Oct  4 19:23:06 (none) kernel: FS:  0000000000000000(0000) GS:ffffffff8034b540(0000) knlGS:0000000000000000
Oct  4 19:23:06 (none) kernel: CS:  0010 DS: 002b ES: 002b CR0: 000000008005003b
Oct  4 19:23:06 (none) kernel: CR2: 00000000a000a700 CR3: 0000000000101000 CR4: 00000000000006e0
Oct  4 19:23:06 (none) kernel: Process modprobe (pid: 104, stackpage=1003efdd000)
Oct  4 19:23:06 (none) kernel: Stack: 000001003efddde0 0000000000000000 ffffffff80202fce 0000000000000007
Oct  4 19:23:06 (none) kernel:        000001000262f800 ffffffffa0014560 0000000000000000 00000000000000b8
Oct  4 19:23:06 (none) kernel:        ffffffff80203048 ffffffffffffffea ffffffffa0010000 0000000008086dc8
Oct  4 19:23:06 (none) kernel: Call Trace: [<ffffffff80202fce>] [<ffffffffa0014560>]
Oct  4 19:23:06 (none) kernel:        [<ffffffff80203048>] [<ffffffffa0013f4d>] [<ffffffff8012008e>]
Oct  4 19:23:06 (none) kernel:        [<ffffffff8012e21c>] [<ffffffffa00100b8>] [<ffffffff80189963>]
Oct  4 19:23:06 (none) kernel: Code:  Bad RIP value.
Oct  4 19:23:06 (none) kernel: CR2: 00000000a000a700
Warning (Oops_read): Code line not seen, dumping what data is available


>>RIP; a000a700 Before first symbol   <=====

>>RAX; ffffffffa00140e0 <[usb-uhci]uhci_pci_remove+20/e0>
>>RBX; ffffffffa0014560 <[usb-uhci]uhci_pci_probe+d0/110>
>>RDX; ffffffffa00140e0 <[usb-uhci]uhci_pci_remove+20/e0>
>>RSI; ffffffffa00140e0 <[usb-uhci]uhci_pci_remove+20/e0>
>>R12; ffffffffa00140e0 <[usb-uhci]uhci_pci_remove+20/e0>

Trace; ffffffff80202fce <pci_announce_device+3e/60>
Trace; ffffffffa0014560 <[usb-uhci]uhci_pci_probe+d0/110>
Trace; ffffffff80203048 <pci_register_driver+58/80>
Trace; ffffffffa0013f4d <[usb-uhci]uhci_interrupt+15d/180>
Trace; ffffffff8012008e <sys_init_module+62e/6f0>
Trace; ffffffff8012e21c <handle_mm_fault+bc/180>
Trace; ffffffffa00100b8 <[usbcore]hcd_data_lock+7a4/7ac>
Trace; ffffffff80189963 <ia32_syscall+67/71>


2 warnings issued.  Results may not be reliable.

--------------010102060508080901050909--

