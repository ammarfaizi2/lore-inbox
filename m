Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313254AbSDJPlq>; Wed, 10 Apr 2002 11:41:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313255AbSDJPlp>; Wed, 10 Apr 2002 11:41:45 -0400
Received: from quattro-eth.sventech.com ([205.252.89.20]:41234 "EHLO
	quattro.sventech.com") by vger.kernel.org with ESMTP
	id <S313254AbSDJPlo>; Wed, 10 Apr 2002 11:41:44 -0400
Date: Wed, 10 Apr 2002 11:41:44 -0400
From: Johannes Erdfelt <johannes@erdfelt.com>
To: Duncan Sands <duncan.sands@math.u-psud.fr>
Cc: Kernel List <linux-kernel@vger.kernel.org>, rml@tech9.net,
        linux-usb-devel@lists.sourceforge.net
Subject: Re: 2.5.8-pre3: kernel BUG at usb.c:849! (preempt_count 1)
Message-ID: <20020410114144.N8314@sventech.com>
In-Reply-To: <E16vHsQ-0000Jy-00@baldrick>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 10, 2002, Duncan Sands <duncan.sands@math.u-psud.fr> wrote:
> UP x86 K6 system running 2.5.8-pre3 with preemption.
> Using usb-uhci.  I got the following bug when powering off:
> 
> usb.c: USB disconnect on device 3
> kernel BUG at usb.c:849!
> invalid operand: 0000
> CPU:    0
> EIP:    0010:[<cc8babe2>]    Not tainted
> EFLAGS: 00010246
> eax: 00000000   ebx: cb8e2800   ecx: cb8e2550   edx: 00000002
> esi: cbc75d88   edi: cc8c7a20   ebp: ffffffff   esp: cab5ff24
> ds: 0018   es: 0018   ss: 0018
> Process rmmod (pid: 1787, threadinfo=cab5e000 task=c952a6a0)
> Stack: cb8e29f8 cc8bbafe cb8e2800 cb8e25bc cb796180 cc8c79a0 0000000e 0000024c
>        cb8e2800 cc8bbaad cb8e25bc cb796080 cc8ce600 c71a5000 cc8c9000 000000c4
>        cb8e2400 cc8ccc7a cab5ff74 c12dc800 00000000 c01cf07f c12dc800 cc8c9000
> Call Trace: [<cc8bbafe>] [<cc8c79a0>] [<cc8bbaad>] [<cc8ce600>] [<cc8ccc7a>]
>    [pci_unregister_driver+51/76] [<cc8cd176>] [<cc8ce600>] [free_module+23/192] [sys_delete_module+292/628] [syscall_call+7/11]
> Code: 0f 0b 51 03 94 42 8c cc 8b 83 cc 00 00 00 8b 40 18 53 8b 40

Could you run this through ksymoops?

>  <3>error: rmmod[1787] exited with preempt_count 1

I don't like the looks of that.

JE

