Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261837AbTJRTwu (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 18 Oct 2003 15:52:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261838AbTJRTwu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 18 Oct 2003 15:52:50 -0400
Received: from 49.144-200-80.adsl.skynet.be ([80.200.144.49]:29957 "EHLO
	gw.ici") by vger.kernel.org with ESMTP id S261837AbTJRTwp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 18 Oct 2003 15:52:45 -0400
Message-ID: <3F91998E.8030802@trollprod.org>
Date: Sat, 18 Oct 2003 21:50:38 +0200
From: Olivier NICOLAS <olivn@trollprod.org>
Organization: TrollPod
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.5) Gecko/20031009
X-Accept-Language: fr, en-us, en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, "Brown, Len" <len.brown@intel.com>
Subject: Re: 2.6.0-test8: panic on boot
References: <3F917EFC.7020102@trollprod.org> <20031018112217.19841708.akpm@osdl.org>
In-Reply-To: <20031018112217.19841708.akpm@osdl.org>
X-Enigmail-Version: 0.76.7.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks


It works for 2.6.0-test8 with ACPI debug


ACPI: Subsystem revision 20031002
  tbxface-0117 [03] acpi_load_tables      : ACPI Tables successfully 
acquired
Parsing all Control 
Methods:..................................................................................
Table [DSDT](id F004) - 614 Objects with 75 Devices 173 Methods 25 Regions
ACPI Namespace successfully loaded at root c03fe6bc
evxfevnt-0093 [04] acpi_enable           : Transition to ACPI mode 
successful
evgpeblk-0748 [06] ev_create_gpe_block   : GPE 00 to 15 [_GPE] 2 regs at 
000000000000500C on int 9
evgpeblk-0221 [08] ev_save_method_info   : Unknown GPE method type: C16A 
(name not of form _Lnn or _Enn)
evgpeblk-0221 [08] ev_save_method_info   : Unknown GPE method type: C135 
(name not of form _Lnn or _Enn)
Completing Region/Field/Buffer/Package 
initialization:........................................................
Initialized 25/25 Regions 0/0 Fields 19/19 Buffers 33/33 Packages (622 
nodes)
Executing all Device _STA and_INI 
methods:....................................................................
76 Devices found containing: 76 _STA, 6 _INI methods
ACPI: Interpreter enabled
ACPI: Using PIC for interrupt routing
dsopcode-0526 [19] ds_init_buffer_field  : Field [C00C] size 1184 
exceeds Buffer [<NUL] size 1088 (bits)
  psparse-1120: *** Error: Method execution failed [\_SB_.C005.C00B] 
(Node c7f8a748), AE_AML_BUFFER_LIMIT
  psparse-1120: *** Error: Method execution failed [\_SB_.C005.C00F] 
(Node c7f8a688), AE_AML_BUFFER_LIMIT
  psparse-1120: *** Error: Method execution failed [\_SB_.C005._CRS] 
(Node c7f8a5c8), AE_AML_BUFFER_LIMIT
   uteval-0098: *** Error: Method execution failed [\_SB_.C005._CRS] 
(Node c7f8a5c8), AE_AML_BUFFER_LIMIT
ACPI: PCI Root Bridge [C005] (00:00)
PCI: Probing PCI hardware (bus 00)
ACPI: PCI Interrupt Routing Table [\_SB_.C005._PRT]
ACPI: Power Resource [C129] (on)
ACPI: Power Resource [C0DB] (on)
ACPI: PCI Interrupt Link [C142] (IRQs *11)
ACPI: PCI Interrupt Link [C148] (IRQs 11)
ACPI: PCI Interrupt Link [C149] (IRQs *11)
ACPI: PCI Interrupt Link [C14A] (IRQs *11)
ACPI: Power Resource [C15F] (off)
ACPI: Power Resource [C161] (off)
ACPI: Power Resource [C163] (off)
Linux Kernel Card Services
   options:  [pci] [cardbus] [pm]
ACPI: PCI Interrupt Link [C142] enabled at IRQ 11
ACPI: PCI Interrupt Link [C14A] enabled at IRQ 11
ACPI: PCI Interrupt Link [C149] enabled at IRQ 11
PCI: Using ACPI for IRQ routing
PCI: if you experience problems, try using option 'pci=noacpi' or even 
'acpi=off'

...
Andrew Morton wrote:
> Olivier NICOLAS <olivn@trollprod.org> wrote:
> 
>> NULL pointer dereference at virtual address 00000004
>>   printing eip:
>> c01de05e
>> *pde = 00000000
>> Oops: 0000 [#1]
>> CPU:    0
>> EIP:    0060:[<c01de05e>]    Not tainted
>> EFLAGS: 00010213
>> EIP is at vsnprintf+0x28e/0x4e0
>> eax: 00000004   ebx: 0000000a   ecx: 00000004   edx: 00000003
>> esi: c03efae7   edi: ffffffff   ebp: 00000000   esp: c114bac0
>> ds: 007b   es: 007b   ss: 0068
>> Process swapper (pid: 1, threadinfo=c114a000 task=c117b8c0)
>> Stack: c114bb08 ffffffff 000004a0 00000000 0000000a ffffffff 00000003 
>> 00000002
>>         00000004 00000004 ffffffff 00000001 c114bb68 c7f02c48 c7f02ee8 
>> c01de307
>>         c03efac0 3fc10540 c03292ea c114bb60 c01e6579 c03efac0 c03292c0 
>> c114bb54
>> Call Trace:
>>   [<c01de307>] vsprintf+0x27/0x30
>>   [<c01e6579>] acpi_os_vprintf+0x12/0x2a
>>   [<c020992b>] acpi_ut_debug_print+0x97/0x9d
>>   [<c01e91d2>] acpi_ds_init_buffer_field+0x18d/0x20c
>>   [<c01e93ac>] acpi_ds_eval_buffer_field_operands+0x15b/0x17d
>>   [<c01e9f8f>] acpi_ds_exec_end_op+0x22c/0x409
> 
> 
> Well clearly one of the strings in this debug message in
> acpi_ds_init_buffer_field() is null:
> 
> 	/* Entire field must fit within the current length of the buffer */
> 
> 	if ((bit_offset + bit_count) >
> 		(8 * (u32) buffer_desc->buffer.length)) {
> 		ACPI_DEBUG_PRINT ((ACPI_DB_ERROR,
> 			"Field [%4.4s] size %d exceeds Buffer [%4.4s] size %d (bits)\n",
> 
> 
> 
> It is perhaps desirable to make printk() a bit more robust about this sort
> of thing.
> 
> 
> diff -puN lib/vsprintf.c~printk-handle-bad-pointers lib/vsprintf.c
> --- 25/lib/vsprintf.c~printk-handle-bad-pointers	2003-10-18 11:19:05.000000000 -0700
> +++ 25-akpm/lib/vsprintf.c	2003-10-18 11:19:25.000000000 -0700
> @@ -348,7 +348,7 @@ int vsnprintf(char *buf, size_t size, co
>  
>  			case 's':
>  				s = va_arg(args, char *);
> -				if (!s)
> +				if ((unsigned long)s < PAGE_SIZE)
>  					s = "<NULL>";
>  
>  				len = strnlen(s, precision);
> 
> _
> 
> 


