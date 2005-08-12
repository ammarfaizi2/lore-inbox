Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750733AbVHLR5z@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750733AbVHLR5z (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 12 Aug 2005 13:57:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750820AbVHLR5t
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 Aug 2005 13:57:49 -0400
Received: from mail.gmx.de ([213.165.64.20]:54993 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S1750805AbVHLR5b (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 Aug 2005 13:57:31 -0400
X-Authenticated: #1189245
Message-ID: <42FCE37F.7070606@gmx.net>
Date: Fri, 12 Aug 2005 19:59:27 +0200
From: Carsten Menke <bootsy52@gmx.net>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.8b) Gecko/20050217
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Re: 2.6.12.3 Kernel Oops using ISDN capi (c2faxsend)
References: <42FCD58B.5010702@gmx.net>
In-Reply-To: <42FCD58B.5010702@gmx.net>
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
X-Y-GMX-Trusted: 0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Carsten Menke wrote:

using 2.4.12.4 and disabling Preemption makes the problem even worse
now c2faxsend is marked defunct and could not be killed producing this stack trace:




Aug 12 19:40:45 localhost kernel: c011ba8a 

Aug 12 19:40:45 localhost kernel: SMP
Aug 12 19:40:45 localhost kernel: Modules linked in: ipv6 piix ide_generic b1pci 
b1dma b1 n_hdlc tun capi capifs kernelcapi evdev pcspkr parpo
Aug 12 19:40:45 localhost kernel: CPU:    1
Aug 12 19:40:45 localhost kernel: EIP:    0060:[mm_release+58/144]    Not 
tainted VLI
Aug 12 19:40:45 localhost kernel: EFLAGS: 00010282   (2.6.12.4) 

Aug 12 19:40:45 localhost kernel: EIP is at mm_release+0x3a/0x90
Aug 12 19:40:45 localhost kernel: eax: 00000000   ebx: df96f020   ecx: b7c3abf8 
   edx: df96f000
Aug 12 19:40:45 localhost kernel: esi: 00000000   edi: df96f020   ebp: 0000000b 
   esp: dd05a7c8
Aug 12 19:40:45 localhost kernel: ds: 007b   es: 007b   ss: 0068
Aug 12 19:40:45 localhost kernel: Process c2faxsend (pid: 3245, 
threadinfo=dd05a000 task=df96f020)
Aug 12 19:40:45 localhost kernel: Stack: c0448388 c04890c0 00000001 c0122e46 
c0448388 0000000a 00000000 df96f020
Aug 12 19:40:45 localhost kernel:        c011fb1a df96f020 00000000 dd05a000 
df96f020 df96f4cc 0000000b c012053f
Aug 12 19:40:45 localhost kernel:        df96f020 c037a677 00000000 c03c0c0c 
00000000 dd05a000 dd05a944 c037a677
Aug 12 19:40:45 localhost kernel: Call Trace:
Aug 12 19:40:45 localhost kernel:  [__do_softirq+214/240] __do_softirq+0xd6/0xf0
Aug 12 19:40:45 localhost kernel:  [exit_mm+26/304] exit_mm+0x1a/0x130
Aug 12 19:40:45 localhost kernel:  [do_exit+191/832] do_exit+0xbf/0x340
Aug 12 19:40:45 localhost kernel:  [die+380/384] die+0x17c/0x180
Aug 12 19:40:45 localhost kernel:  [do_page_fault+739/1465] 
do_page_fault+0x2e3/0x5b9
Aug 12 19:40:45 localhost kernel:  [load_balance+359/384] 
load_balance+0x167/0x180
Aug 12 19:40:45 localhost kernel:  [__mod_timer+249/320] __mod_timer+0xf9/0x140
Aug 12 19:40:45 localhost kernel:  [do_page_fault+0/1465] do_page_fault+0x0/0x5b9
Aug 12 19:40:45 localhost kernel:  [error_code+79/84] error_code+0x4f/0x54
Aug 12 19:40:45 localhost kernel:  [mm_release+58/144] mm_release+0x3a/0x90
Aug 12 19:40:45 localhost kernel:  [__do_softirq+214/240] __do_softirq+0xd6/0xf0
Aug 12 19:40:45 localhost kernel:  [exit_mm+26/304] exit_mm+0x1a/0x130
Aug 12 19:40:45 localhost kernel:  [do_exit+191/832] do_exit+0xbf/0x340
Aug 12 19:40:45 localhost kernel:  [die+380/384] die+0x17c/0x180
Aug 12 19:40:45 localhost kernel:  [do_page_fault+739/1465] 
do_page_fault+0x2e3/0x5b9
Aug 12 19:40:45 localhost kernel:  [load_balance+359/384] 
load_balance+0x167/0x180
Aug 12 19:40:45 localhost kernel:  [__mod_timer+249/320] __mod_timer+0xf9/0x140 

Aug 12 19:40:45 localhost kernel:  [do_page_fault+0/1465] 
do_page_fault+0x0/0x5b9
Aug 12 19:40:45 localhost kernel:  [error_code+79/84] error_code+0x4f/0x54
Aug 12 19:40:45 localhost kernel:  [mm_release+58/144] mm_release+0x3a/0x90
Aug 12 19:40:45 localhost kernel:  [__do_softirq+214/240] __do_softirq+0xd6/0xf0
Aug 12 19:40:45 localhost kernel:  [exit_mm+26/304] exit_mm+0x1a/0x130
Aug 12 19:40:45 localhost kernel:  [do_exit+191/832] do_exit+0xbf/0x340
Aug 12 19:40:45 localhost kernel:  [die+380/384] die+0x17c/0x180
Aug 12 19:40:45 localhost kernel:  [do_page_fault+739/1465] 
do_page_fault+0x2e3/0x5b9
Aug 12 19:40:45 localhost kernel:  [load_balance+359/384] 
load_balance+0x167/0x180
Aug 12 19:40:45 localhost kernel:  [__mod_timer+249/320] __mod_timer+0xf9/0x140 

Aug 12 19:40:45 localhost kernel:  [neigh_periodic_timer+232/384] 
neigh_periodic_timer+0xe8/0x180
Aug 12 19:40:45 localhost kernel:  [do_page_fault+0/1465] do_page_fault+0x0/0x5b9
Aug 12 19:40:45 localhost kernel:  [error_code+79/84] error_code+0x4f/0x54
Aug 12 19:40:45 localhost kernel:  [mm_release+58/144] mm_release+0x3a/0x90
Aug 12 19:40:45 localhost kernel:  [__do_softirq+214/240] __do_softirq+0xd6/0xf0
Aug 12 19:40:45 localhost kernel:  [exit_mm+26/304] exit_mm+0x1a/0x130
Aug 12 19:40:45 localhost kernel:  [do_exit+191/832] do_exit+0xbf/0x340
Aug 12 19:40:45 localhost kernel:  [die+380/384] die+0x17c/0x180
Aug 12 19:40:45 localhost kernel:  [do_page_fault+739/1465] 
do_page_fault+0x2e3/0x5b9
Aug 12 19:40:45 localhost kernel:  [load_balance+359/384] 
load_balance+0x167/0x180
Aug 12 19:40:45 localhost kernel:  [__mod_timer+249/320] __mod_timer+0xf9/0x140 

Aug 12 19:40:45 localhost kernel:  [do_page_fault+0/1465] 
do_page_fault+0x0/0x5b9
Aug 12 19:40:45 localhost kernel:  [error_code+79/84] error_code+0x4f/0x54
Aug 12 19:40:45 localhost kernel:  [mm_release+58/144] mm_release+0x3a/0x90
Aug 12 19:40:45 localhost kernel:  [__do_softirq+214/240] __do_softirq+0xd6/0xf0
Aug 12 19:40:45 localhost kernel:  [exit_mm+26/304] exit_mm+0x1a/0x130
Aug 12 19:40:45 localhost kernel:  [do_exit+191/832] do_exit+0xbf/0x340
Aug 12 19:40:45 localhost kernel:  [die+380/384] die+0x17c/0x180
Aug 12 19:40:45 localhost kernel:  [do_page_fault+739/1465] 
do_page_fault+0x2e3/0x5b9
Aug 12 19:40:45 localhost kernel:  [load_balance+359/384] 
load_balance+0x167/0x180
Aug 12 19:40:45 localhost kernel:  [__mod_timer+249/320] __mod_timer+0xf9/0x140 

Aug 12 19:40:45 localhost kernel:  [__mod_timer+249/320] __mod_timer+0xf9/0x140 

Aug 12 19:40:45 localhost kernel:  [do_page_fault+0/1465] 
do_page_fault+0x0/0x5b9
Aug 12 19:40:45 localhost kernel:  [error_code+79/84] error_code+0x4f/0x54
Aug 12 19:40:45 localhost kernel:  [mm_release+58/144] mm_release+0x3a/0x90
Aug 12 19:40:45 localhost kernel:  [__do_softirq+214/240] __do_softirq+0xd6/0xf0
Aug 12 19:40:45 localhost kernel:  [exit_mm+26/304] exit_mm+0x1a/0x130
Aug 12 19:40:45 localhost kernel:  [do_exit+191/832] do_exit+0xbf/0x340
Aug 12 19:40:45 localhost kernel:  [die+380/384] die+0x17c/0x180
Aug 12 19:40:45 localhost kernel:  [do_page_fault+739/1465] 
do_page_fault+0x2e3/0x5b9
Aug 12 19:40:45 localhost kernel:  [recalc_task_prio+136/336] 
recalc_task_prio+0x88/0x150
Aug 12 19:40:45 localhost kernel:  [activate_task+144/176] activate_task+0x90/0xb0
Aug 12 19:40:45 localhost kernel:  [try_to_wake_up+658/736] 
try_to_wake_up+0x292/0x2e0
Aug 12 19:40:45 localhost kernel:  [do_page_fault+0/1465] do_page_fault+0x0/0x5b9

[ .. ]

Aug 12 19:40:45 localhost kernel:  [mm_release+58/144] mm_release+0x3a/0x90
Aug 12 19:40:45 localhost kernel:  [__do_softirq+214/240] __do_softirq+0xd6/0xf0
Aug 12 19:40:45 localhost kernel:  [exit_mm+26/304] exit_mm+0x1a/0x130
Aug 12 19:40:45 localhost kernel:  [do_exit+191/832] do_exit+0xbf/0x340
Aug 12 19:40:45 localhost kernel:  [die+380/384] die+0x17c/0x180
Aug 12 19:40:45 localhost kernel:  [do_page_fault+739/1465] 
do_page_fault+0x2e3/0x5b9
Aug 12 19:40:45 localhost kernel:  [__wake_up_common+65/112] 
__wake_up_common+0x41/0x70
Aug 12 19:40:45 localhost kernel:  [__wake_up+62/96] __wake_up+0x3e/0x60
Aug 12 19:40:45 localhost kernel:  [__queue_work+83/112] __queue_work+0x53/0x70
Aug 12 19:40:45 localhost kernel:  [do_page_fault+0/1465] do_page_fault+0x0/0x5b9
Aug 12 19:40:45 localhost kernel:  [error_code+79/84] error_code+0x4f/0x54
Aug 12 19:40:45 localhost kernel:  [mm_release+58/144] mm_release+0x3a/0x90
Aug 12 19:40:45 localhost kernel:  [__do_softirq+214/240] __do_softirq+0xd6/0xf0
Aug 12 19:40:45 localhost kernel:  [exit_mm+26/304] exit_mm+0x1a/0x130
Aug 12 19:40:45 localhost kernel:  [do_exit+191/832] do_exit+0xbf/0x340
Aug 12 19:40:45 localhost kernel:  [die+380/384] die+0x17c/0x180
Aug 12 19:40:45 localhost kernel:  [do_page_fault+739/1465] 
do_page_fault+0x2e3/0x5b9
Aug 12 19:40:45 localhost kernel:  [__wake_up+62/96] __wake_up+0x3e/0x60
Aug 12 19:40:45 localhost kernel:  [release_console_sem+185/192] 
release_console_sem+0xb9/0xc0
Aug 12 19:40:45 localhost kernel:  [vprintk+413/592] vprintk+0x19d/0x250
Aug 12 19:40:45 localhost kernel:  [xfs_log_move_tail+70/416] 
xfs_log_move_tail+0x46/0x1a0
Aug 12 19:40:45 localhost kernel:  [do_page_fault+0/1465] do_page_fault+0x0/0x5b9
Aug 12 19:40:45 localhost kernel:  [error_code+79/84] error_code+0x4f/0x54
Aug 12 19:40:45 localhost kernel:  [pg0+541760898/1068758016] 
capilib_release_appl+0x52/0x70 [kernelcapi]
Aug 12 19:40:45 localhost kernel:  [pg0+541727529/1068758016] 
b1dma_release_appl+0x29/0xe0 [b1dma]
Aug 12 19:40:45 localhost kernel:  [pg0+541749418/1068758016] 
release_appl+0x1a/0x60 [kernelcapi]
Aug 12 19:40:45 localhost kernel:  [pg0+541752528/1068758016] 
capi20_release+0xc0/0xd0 [kernelcapi]
Aug 12 19:40:45 localhost kernel:  [pg0+541537843/1068758016] 
capidev_free+0x93/0xa0 [capi]
Aug 12 19:40:45 localhost kernel:  [pg0+541542169/1068758016] 
capi_release+0x19/0x30 [capi]
Aug 12 19:40:45 localhost kernel:  [__fput+270/288] __fput+0x10e/0x120
Aug 12 19:40:45 localhost kernel:  [filp_close+89/144] filp_close+0x59/0x90
Aug 12 19:40:45 localhost kernel:  [put_files_struct+100/208] 
put_files_struct+0x64/0xd0
Aug 12 19:40:45 localhost kernel:  [do_exit+238/832] do_exit+0xee/0x340
Aug 12 19:40:45 localhost kernel:  [do_group_exit+64/176] do_group_exit+0x40/0xb0
Aug 12 19:40:45 localhost kernel:  [get_signal_to_deliver+560/832] 
get_signal_to_deliver+0x230/0x340
Aug 12 19:40:45 localhost kernel:  [do_signal+155/304] do_signal+0x9b/0x130
Aug 12 19:40:45 localhost kernel:  [wake_up_state+24/32] wake_up_state+0x18/0x20
Aug 12 19:40:45 localhost kernel:  [signal_wake_up+46/80] signal_wake_up+0x2e/0x50
Aug 12 19:40:45 localhost kernel:  [force_sig_info+113/176] force_sig_info+0x71/0xb0
Aug 12 19:40:45 localhost kernel:  [force_sig+32/48] force_sig+0x20/0x30
Aug 12 19:40:45 localhost kernel:  [do_general_protection+135/416] 
do_general_protection+0x87/0x1a0
Aug 12 19:40:45 localhost kernel:  [sys_gettimeofday+60/144] 
sys_gettimeofday+0x3c/0x90
Aug 12 19:40:45 localhost kernel:  [do_general_protection+0/416] 
do_general_protection+0x0/0x1a0
Aug 12 19:40:45 localhost kernel:  [do_notify_resume+55/60] 
do_notify_resume+0x37/0x3c
Aug 12 19:40:45 localhost kernel:  [work_notifysig+19/21] work_notifysig+0x13/0x15
Aug 12 19:40:45 localhost kernel: Code: 31 f6 8b 83 0c 01 00 00 8e e6 8e ee 85 
c0 74 0d 31 d2 89 93 0c 01 00 00 e8 44 dc ff ff 8b 8b 14 01 00 00 85 c9 74 0a 8b 
44 24 28 <8b> 40 20 48 7f 10 8b 5c 24 18 8b 74 24 1c 83 c4 20 c3 8d 74 26
tual address 00000020
Aug 12 19:40:45 localhost kernel:  <1>Unable to handle kernel NULL pointer 
dereference at virtual address 00000020
-- 
"There are two major products that came out of Berkeley: LSD and UNIX.
   We don't believe this to be a coincidence." --Jeremy S. Anderson
