Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265135AbTFULTv (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 21 Jun 2003 07:19:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265136AbTFULTu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 21 Jun 2003 07:19:50 -0400
Received: from APlessis-Bouchard-112-1-10-46.w81-248.abo.wanadoo.fr ([81.248.146.46]:11912
	"EHLO fozzy.syrius.org") by vger.kernel.org with ESMTP
	id S265135AbTFULTt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 21 Jun 2003 07:19:49 -0400
To: linux-kernel@vger.kernel.org
Subject: 2.5.72-bk3 oops when loading aha152X(isapnp)
From: schmurtz@netcourrier.com
Date: Sat, 21 Jun 2003 13:33:50 +0200
Message-ID: <wazza.87wuffacm9.fsf@message.id>
User-Agent: Gnus/5.1002 (Gnus v5.10.2) Emacs/21.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Using 2.4 kernels, everything is ok.


SCSI subsystem initialized
pnp: Device 01:02.00 activated.
aha152x: found ISAPnP AVA-1505A at io=0x140, irq=10
aha152x: BIOS test: passed, detected 1 controller(s)
aha152x: resetting bus...                           
aha152x0: vital data: rev=3, io=0x140 (0x140/0x140), irq=10, scsiid=7, reconnecd
aha152x0: trying software interrupt, <1>Unable to handle kernel NULL pointer dec
 printing eip:                                                                 
c58a01ea      
*pde = 00000000
Oops: 0000 [#1]
CPU:    0      
EIP:    0060:[<c58a01ea>]    Not tainted
EFLAGS: 00010046                        
EIP is at swintr+0x4a/0x70 [aha152x]
eax: 00000000   ebx: c4201340   ecx: 0000000a   edx: 00000002
esi: 24000001   edi: 00000000   ebp: c3f75ecc   esp: c3f75ec8
ds: 007b   es: 007b   ss: 0068                               
Process modprobe (pid: 240, threadinfo=c3f74000 task=c40cad00)
Stack: 0000000a c3f75eec c010a713 0000000a c4102800 c3f75f1c c3f74000 0000000a 
       c02c1f00 c3f75f14 c010aa49 0000000a c3f75f1c c4201340 c4201340 00000500 
       c4102800 c41029b0 00000140 c3f75f5c c0109288 c4102800 c4699280 00000152 
Call Trace:                                                                    
 [<c010a713>] handle_IRQ_event+0x33/0x60
 [<c010aa49>] do_IRQ+0xb9/0x180         
 [<c0109288>] common_interrupt+0x18/0x20
 [<c58a6805>] +0x125/0x1304 [aha152x]   
 [<c58a045e>] aha152x_probe_one+0x24e/0x3d0 [aha152x]
 [<c58a0060>] +0x60/0x80 [aha152x]                   
 [<c58aa020>] setup+0x0/0x50 [aha152x]
 [<c58a09ae>] aha152x_detect+0x3ce/0x810 [aha152x]
 [<c58aa020>] setup+0x0/0x50 [aha152x]            
 [<c58a0df0>] aha152x_release+0x0/0x80 [aha152x]
 [<c58a9900>] +0x0/0x200 [aha152x]              
 [<c582503c>] +0x3c/0xec [aha152x]
 [<c58a9860>] aha152x_driver_template+0x0/0xa0 [aha152x]
 [<c012c6ab>] sys_init_module+0xfb/0x210                
 [<c0109067>] syscall_call+0x7/0xb      
                                  
Code: a1 4c 00 00 00 25 ff ff 00 00 50 68 e0 66 8a c5 e8 61 86 87 
 <0>Kernel panic: Fatal exception in interrupt                    
In interrupt handler - not syncing            


-- 
S.
