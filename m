Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269884AbTGKKnS (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 11 Jul 2003 06:43:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269888AbTGKKnR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 11 Jul 2003 06:43:17 -0400
Received: from APlessis-Bouchard-112-1-10-191.w81-248.abo.wanadoo.fr ([81.248.146.191]:1676
	"EHLO fozzy.syrius.org") by vger.kernel.org with ESMTP
	id S269884AbTGKKmv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 11 Jul 2003 06:42:51 -0400
To: Linus Torvalds <torvalds@osdl.org>
Cc: Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Linux 2.5.75 - still can't load aha152x (isapnp) => OOPS
References: <Pine.LNX.4.44.0307101405490.4560-100000@home.osdl.org>
From: schmurtz@netcourrier.com
Date: Fri, 11 Jul 2003 12:57:23 +0200
In-Reply-To: <Pine.LNX.4.44.0307101405490.4560-100000@home.osdl.org> (Linus
 Torvalds's message of "Thu, 10 Jul 2003 14:14:15 -0700 (PDT)")
Message-ID: <wazza.87y8z5xre4.fsf@message.id>
User-Agent: Gnus/5.1002 (Gnus v5.10.2) Emacs/21.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


I'm still getting oops when loading aha152x..
(having it compiled in the kernel gives the same result)

PnPBIOS: Scanning system for PnP BIOS support...
PnPBIOS: Found PnP BIOS installation structure at 0xc00f9710
PnPBIOS: PnP BIOS version 1.0, entry 0xf2300:0x0, dseg 0xf0000
PnPBIOS: 15 nodes reported by PnP BIOS; 15 recorded by driver 
...
isapnp: Scanning for PnP cards...
isapnp: Card 'CS4237'            
isapnp: Card 'Adaptec AVA-1505AE'
isapnp: 2 Plug & Play cards detected total
...
SCSI subsystem initialized                                                     
pnp: Device 01:02.00 activated.
aha152x: found ISAPnP AVA-1505A at io=0x140, irq=10
aha152x: BIOS test: passed, detected 1 controller(s)
aha152x: resetting bus...                           
aha152x0: vital data: rev=3, io=0x140 (0x140/0x140), irq=10, scsiid=7, reconnecd
aha152x0: trying software interrupt, <1>Unable to handle kernel NULL pointer dec
 printing eip:                                                                 
c58951ea      
*pde = 00000000
Oops: 0000 [#1]
CPU:    0      
EIP:    0060:[<c58951ea>]    Not tainted
EFLAGS: 00010046                        
EIP is at swintr+0x4a/0x70 [aha152x]
eax: 00000000   ebx: c3db2800   ecx: 0000000a   edx: 00000002
esi: 24000001   edi: 00000000   ebp: c3dffecc   esp: c3dffec8
ds: 007b   es: 007b   ss: 0068                               
Process modprobe (pid: 244, threadinfo=c3dfe000 task=c4d4f300)
Stack: 0000000a c3dffeec c010a793 0000000a c3e6b800 c3dfff1c c3dfe000 0000000a 
       c02c8f00 c3dfff14 c010aac9 0000000a c3dfff1c c3db2800 c3db2800 00000500 
       c3e6b800 c3e6b9b0 00000140 c3dfff5c c01092f8 c3e6b800 c1346680 00000152 
Call Trace:                                                                    
 [<c010a793>] handle_IRQ_event+0x33/0x60
 [<c010aac9>] do_IRQ+0xb9/0x180         
 [<c01092f8>] common_interrupt+0x18/0x20
 [<c589545e>] aha152x_probe_one+0x24e/0x3d0 [aha152x]
 [<c58959ae>] aha152x_detect+0x3ce/0x810 [aha152x]   
 [<c5895df0>] aha152x_release+0x0/0x80 [aha152x]  
 [<c582703c>] init_this_scsi_driver+0x3c/0xeb [aha152x]
 [<c012d02b>] sys_init_module+0xfb/0x220               
 [<c01090d7>] syscall_call+0x7/0xb      
                                  
Code: a1 4c 00 00 00 25 ff ff 00 00 50 68 80 b6 89 c5 e8 e1 39 88 
 <0>Kernel panic: Fatal exception in interrupt                    
In interrupt handler - not syncing            


snd-cs4236 module can be loaded with no problem. (pnp soundcard)


-- 
S.
