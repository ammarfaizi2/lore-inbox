Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263909AbTKZQw7 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 26 Nov 2003 11:52:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264257AbTKZQw7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 26 Nov 2003 11:52:59 -0500
Received: from ferreol-1-82-66-171-16.fbx.proxad.net ([82.66.171.16]:3456 "EHLO
	diablo.hd.free.fr") by vger.kernel.org with ESMTP id S263909AbTKZQvm
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 26 Nov 2003 11:51:42 -0500
Message-ID: <3FC4DA17.4000608@free.fr>
Date: Wed, 26 Nov 2003 17:51:35 +0100
From: Vince <fuzzy77@free.fr>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.5) Gecko/20031105 Thunderbird/0.3
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: [kernel panic @ reboot] 2.6.0-test10-mm1
Content-Type: multipart/mixed;
 boundary="------------040409010103010804040306"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------040409010103010804040306
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Hi,

   I get a kernel panic each time I'm rebooting my system on all
recent 2.6.0testx kernels (cpu is an Athlon 1800XP, kernel compiled with
preempt and ACPI ; config and dmesg is attached).

   This time, I got tired of seeing this and finally installed kmsgdump
in order to collect some data, available in messages.txt (*)

For my particular case, X was not loaded: I just logged in in console
mode and did a reboot. No nvidia or other binary driver loaded. Any hint 
on tracking down this bug is appreciated (I can compile my kernel with 
additional debugging options if required).

Regards,

Vincent

(*) BTW: something like kmsgdump should really one day be included in 
mainline kernels, serial console is often not an option for people like 
me running a single machine ; writting an oops by hand is not fun... and 
often, even if the crash does not occur while running an X server, the 
beginning of the oops is not accessible on the console any more...

--------------040409010103010804040306
Content-Type: text/plain;
 name="messages.txt"
Content-Transfer-Encoding: 8bit
Content-Disposition: inline;
 filename="messages.txt"

tainted VLI
<4>EFLAGS: 00010086
<4>EIP is at show_registers+0xf3/0x1e0
<4>eax: ffedffe8   ebx: cc91a4a0   ecx: ffee02ea   edx: cc91a000
<4>esi: cc91a46c   edi: 00000068   ebp: 00000001   esp: cc91a370
<4>ds: 007b   es: 007b   ss: 0068
<1>Unable to handle kernel paging request at virtual address ffee0070
<4> printing eip:
<4>c010b543
<1>*pde = 00002067
<1>*pte = 00000000
<4>Oops: 0000 [#49]
<4>PREEMPT 
<4>CPU:    0
<4>EIP:    0060:[<c010b543>]    Not tainted VLI
<4>EFLAGS: 00010086
<4>EIP is at show_registers+0xf3/0x1e0
<4>eax: ffedffe8   ebx: cc91a370   ecx: ffee02ea   edx: cc91a000
<4>esi: cc91a33c   edi: 00000068   ebp: 00000001   esp: cc91a240
<4>ds: 007b   es: 007b   ss: 0068
<4>Process çBâD$æBâD$ãBâ$«D$ (pid: 608471316, threadinfo=cc91a000 task=c01392ec)
<4>Stack: c02b9580 0000007b 0000007b cc91a000 ffedffe8 00010086 cc91a33c cc91a000 
<4>       c011cc80 ffedffe8 c010b769 cc91a33c c02bf912 00000000 00000030 00000000 
<4>       00000000 c011ce56 c02bf912 cc91a33c 00000000 ffffffff c02b2640 000002e0 
<4>Call Trace:
<4> [<c011cc80>] do_page_fault+0x0/0x504
<4> [<c010b769>] die+0x89/0x100
<4> [<c011ce56>] do_page_fault+0x1d6/0x504
<4> [<c0122bb7>] __call_console_drivers+0x57/0x60
<4> [<c0122cb5>] call_console_drivers+0x65/0x120
<4> [<c011cc80>] do_page_fault+0x0/0x504
<4> [<c02a92af>] error_code+0x2f/0x38
<4> [<c010b543>] show_registers+0xf3/0x1e0
<4> [<c011cc80>] do_page_fault+0x0/0x504
<4> [<c010b769>] die+0x89/0x100
<4> [<c011ce56>] do_page_fault+0x1d6/0x504
<4> [<c0122bb7>] __call_console_drivers+0x57/0x60
<4> [<c0122cb5>] call_console_drivers+0x65/0x120
<4> [<c011cc80>] do_page_fault+0x0/0x504
<4> [<c02a92af>] error_code+0x2f/0x38
<4> [<c010b543>] show_registers+0xf3/0x1e0
<4> [<c011cc80>] do_page_fault+0x0/0x504
<4> [<c010b769>] die+0x89/0x100
<4> [<c011ce56>] do_page_fault+0x1d6/0x504
<4> [<c0122bb7>] __call_console_drivers+0x57/0x60
<4> [<c0122cb5>] call_console_drivers+0x65/0x120
<4> [<c011cc80>] do_page_fault+0x0/0x504
<4> [<c02a92af>] error_code+0x2f/0x38
<4> [<c010b543>] show_registers+0xf3/0x1e0
<4> [<c011cc80>] do_page_fault+0x0/0x504
<4> [<c010b769>] die+0x89/0x100
<4> [<c011ce56>] do_page_fault+0x1d6/0x504
<4> [<c0122bb7>] __call_console_drivers+0x57/0x60
<4> [<c0122cb5>] call_console_drivers+0x65/0x120
<4> [<c011cc80>] do_page_fault+0x0/0x504
<4> [<c02a92af>] error_code+0x2f/0x38
<4> [<c010b543>] show_registers+0xf3/0x1e0
<4> [<c011cc80>] do_page_fault+0x0/0x504
<4> [<c010b769>] die+0x89/0x100
<4> [<c011ce56>] do_page_fault+0x1d6/0x504
<4> [<c0122bb7>] __call_console_drivers+0x57/0x60
<4> [<c0122cb5>] call_console_drivers+0x65/0x120
<4> [<c011cc80>] do_page_fault+0x0/0x504
<4> [<c02a92af>] error_code+0x2f/0x38
<4> [<c010b543>] show_registers+0xf3/0x1e0
<4> [<c011cc80>] do_page_fault+0x0/0x504
<4> [<c010b769>] die+0x89/0x100
<4> [<c011ce56>] do_page_fault+0x1d6/0x504
<4> [<c0122bb7>] __call_console_drivers+0x57/0x60
<4> [<c0122cb5>] call_console_drivers+0x65/0x120
<4> [<c011cc80>] do_page_fault+0x0/0x504
<4> [<c02a92af>] error_code+0x2f/0x38
<4> [<c010b543>] show_registers+0xf3/0x1e0
<4> [<c011cc80>] do_page_fault+0x0/0x504
<4> [<c010b769>] die+0x89/0x100
<4> [<c011ce56>] do_page_fault+0x1d6/0x504
<4> [<c0122bb7>] __call_console_drivers+0x57/0x60
<4> [<c0122cb5>] call_console_drivers+0x65/0x120
<4> [<c011cc80>] do_page_fault+0x0/0x504
<4> [<c02a92af>] error_code+0x2f/0x38
<4> [<c010b543>] show_registers+0xf3/0x1e0
<4> [<c011cc80>] do_page_fault+0x0/0x504
<4> [<c010b769>] die+0x89/0x100
<4> [<c011ce56>] do_page_fault+0x1d6/0x504
<4> [<c0122bb7>] __call_console_drivers+0x57/0x60
<4> [<c0122cb5>] call_console_drivers+0x65/0x120
<4> [<c011cc80>] do_page_fault+0x0/0x504
<4> [<c02a92af>] error_code+0x2f/0x38
<4> [<c010b543>] show_registers+0xf3/0x1e0
<4> [<c011cc80>] do_page_fault+0x0/0x504
<4> [<c010b769>] die+0x89/0x100
<4> [<c011ce56>] do_page_fault+0x1d6/0x504
<4> [<c0122bb7>] __call_console_drivers+0x57/0x60
<4> [<c0122cb5>] call_console_drivers+0x65/0x120
<4> [<c011cc80>] do_page_fault+0x0/0x504
<4> [<c02a92af>] error_code+0x2f/0x38
<4> [<c010b543>] show_registers+0xf3/0x1e0
<4> [<c011cc80>] do_page_fault+0x0/0x504
<4> [<c010b769>] die+0x89/0x100
<4> [<c011ce56>] do_page_fault+0x1d6/0x504
<4> [<c0122bb7>] __call_console_drivers+0x57/0x60
<4> [<c0122cb5>] call_console_drivers+0x65/0x120
<4> [<c011cc80>] do_page_fault+0x0/0x504
<4> [<c02a92af>] error_code+0x2f/0x38
<4> [<c010b543>] show_registers+0xf3/0x1e0
<4> [<c011cc80>] do_page_fault+0x0/0x504
<4> [<c010b769>] die+0x89/0x100
<4> [<c011ce56>] do_page_fault+0x1d6/0x504
<4> [<c0122bb7>] __call_console_drivers+0x57/0x60
<4> [<c0122cb5>] call_console_drivers+0x65/0x120
<4> [<c011cc80>] do_page_fault+0x0/0x504
<4> [<c02a92af>] error_code+0x2f/0x38
<4> [<c010b543>] show_registers+0xf3/0x1e0
<4> [<c011cc80>] do_page_fault+0x0/0x504
<4> [<c010b769>] die+0x89/0x100
<4> [<c011ce56>] do_page_fault+0x1d6/0x504
<4> [<c0122bb7>] __call_console_drivers+0x57/0x60
<4> [<c0122cb5>] call_console_drivers+0x65/0x120
<4> [<c011cc80>] do_page_fault+0x0/0x504
<4> [<c02a92af>] error_code+0x2f/0x38
<4> [<c010b543>] show_registers+0xf3/0x1e0
<4> [<c011cc80>] do_page_fault+0x0/0x504
<4> [<c010b769>] die+0x89/0x100
<4> [<c011ce56>] do_page_fault+0x1d6/0x504
<4> [<c0122bb7>] __call_console_drivers+0x57/0x60
<4> [<c0122cb5>] call_console_drivers+0x65/0x120
<4> [<c011cc80>] do_page_fault+0x0/0x504
<4> [<c02a92af>] error_code+0x2f/0x38
<4> [<c010b543>] show_registers+0xf3/0x1e0
<4> [<c011cc80>] do_page_fault+0x0/0x504
<4> [<c010b769>] die+0x89/0x100
<4> [<c011ce56>] do_page_fault+0x1d6/0x504
<4> [<c0122bb7>] __call_console_drivers+0x57/0x60
<4> [<c0122cb5>] call_console_drivers+0x65/0x120
<4> [<c011cc80>] do_page_fault+0x0/0x504
<4> [<c02a92af>] error_code+0x2f/0x38
<4> [<c010b543>] show_registers+0xf3/0x1e0
<4> [<c011cc80>] do_page_fault+0x0/0x504
<4> [<c010b769>] die+0x89/0x100
<4> [<c011ce56>] do_page_fault+0x1d6/0x504
<4> [<c0122bb7>] __call_console_drivers+0x57/0x60
<4> [<c0122cb5>] call_console_drivers+0x65/0x120
<4> [<c011cc80>] do_page_fault+0x0/0x504
<4> [<c02a92af>] error_code+0x2f/0x38
<4> [<c010b543>] show_registers+0xf3/0x1e0
<4> [<c011cc80>] do_page_fault+0x0/0x504
<4> [<c010b769>] die+0x89/0x100
<4> [<c011ce56>] do_page_fault+0x1d6/0x504
<4> [<c0122bb7>] __call_console_drivers+0x57/0x60
<4> [<c0122cb5>] call_console_drivers+0x65/0x120
<4> [<c011cc80>] do_page_fault+0x0/0x504
<4> [<c02a92af>] error_code+0x2f/0x38
<4> [<c010b543>] show_registers+0xf3/0x1e0
<4> [<c011cc80>] do_page_fault+0x0/0x504
<4> [<c010b769>] die+0x89/0x100
<4> [<c011ce56>] do_page_fault+0x1d6/0x504
<4> [<c0122bb7>] __call_console_drivers+0x57/0x60
<4> [<c0122cb5>] call_console_drivers+0x65/0x120
<4> [<c011cc80>] do_page_fault+0x0/0x504
<4> [<c02a92af>] error_code+0x2f/0x38
<4> [<c010b543>] show_registers+0xf3/0x1e0
<4> [<c011cc80>] do_page_fault+0x0/0x504
<4> [<c010b769>] die+0x89/0x100
<4> [<c011ce56>] do_page_fault+0x1d6/0x504
<4> [<c0122bb7>] __call_console_drivers+0x57/0x60
<4> [<c0122bb7>] __call_console_drivers+0x57/0x60
<4> [<c0122cb5>] call_console_drivers+0x65/0x120
<4> [<c011cc80>] do_page_fault+0x0/0x504
<4> [<c02a92af>] error_code+0x2f/0x38
<4> [<c010b543>] show_registers+0xf3/0x1e0
<4> [<c011cc80>] do_page_fault+0x0/0x504
<4> [<c010b769>] die+0x89/0x100
<4> [<c011ce56>] do_page_fault+0x1d6/0x504
<4> [<c0122bb7>] __call_console_drivers+0x57/0x60
<4> [<c0122cb5>] call_console_drivers+0x65/0x120
<4> [<c011cc80>] do_page_fault+0x0/0x504
<4> [<c02a92af>] error_code+0x2f/0x38
<4> [<c010b543>] show_registers+0xf3/0x1e0
<4> [<c011cc80>] do_page_fault+0x0/0x504
<4> [<c010b769>] die+0x89/0x100
<4> [<c011ce56>] do_page_fault+0x1d6/0x504
<4> [<c0122bb7>] __call_console_drivers+0x57/0x60
<4> [<c0122cb5>] call_console_drivers+0x65/0x120
<4> [<c011cc80>] do_page_fault+0x0/0x504
<4> [<c02a92af>] error_code+0x2f/0x38
<4> [<c010b543>] show_registers+0xf3/0x1e0
<4> [<c011cc80>] do_page_fault+0x0/0x504
<4> [<c010b769>] die+0x89/0x100
<4> [<c011ce56>] do_page_fault+0x1d6/0x504
<4> [<c0122bb7>] __call_console_drivers+0x57/0x60
<4> [<c0122cb5>] call_console_drivers+0x65/0x120
<4> [<c011cc80>] do_page_fault+0x0/0x504
<4> [<c02a92af>] error_code+0x2f/0x38
<4> [<c010b543>] show_registers+0xf3/0x1e0
<4> [<c011cc80>] do_page_fault+0x0/0x504
<4> [<c010b769>] die+0x89/0x100
<4> [<c011ce56>] do_page_fault+0x1d6/0x504
<4> [<c0122bb7>] __call_console_drivers+0x57/0x60
<4> [<c0122cb5>] call_console_drivers+0x65/0x120
<4> [<c011cc80>] do_page_fault+0x0/0x504
<4> [<c02a92af>] error_code+0x2f/0x38
<4> [<c010b543>] show_registers+0xf3/0x1e0
<4> [<c011cc80>] do_page_fault+0x0/0x504
<4> [<c010b769>] die+0x89/0x100
<4> [<c011ce56>] do_page_fault+0x1d6/0x504
<4> [<c0122bb7>] __call_console_drivers+0x57/0x60
<4> [<c0122cb5>] call_console_drivers+0x65/0x120
<4> [<c011cc80>] do_page_fault+0x0/0x504
<4> [<c02a92af>] error_code+0x2f/0x38
<4> [<c010b543>] show_registers+0xf3/0x1e0
<4> [<c011cc80>] do_page_fault+0x0/0x504
<4> [<c010b769>] die+0x89/0x100
<4> [<c011ce56>] do_page_fault+0x1d6/0x504
<4> [<c0122bb7>] __call_console_drivers+0x57/0x60
<4> [<c0122cb5>] call_console_drivers+0x65/0x120
<4> [<c011cc80>] do_page_fault+0x0/0x504
<4> [<c02a92af>] error_code+0x2f/0x38
<4> [<c010b543>] show_registers+0xf3/0x1e0
<4> [<c011cc80>] do_page_fault+0x0/0x504
<4> [<c010b769>] die+0x89/0x100
<4> [<c011ce56>] do_page_fault+0x1d6/0x504
<4> [<c011cc80>] do_page_fault+0x0/0x504
<4> [<c02a92af>] error_code+0x2f/0x38
<4> [<c011cc80>] do_page_fault+0x0/0x504
<4> [<c011ccc4>] do_page_fault+0x44/0x504
<4>
<4>Code: 0f b7 46 1c c7 04 24 80 95 2b c0 89 44 24 04 e8 b4 78 01 00 ba 00 e0 ff ff 21 e2 8b 02 89 54 24 0c 8d 88 02 03 00 00 89 44 24 10 <8b> 80 88 00 00 00 89 4c 24 04 c7 04 24 a0 95 2b c0 89 44 24 08 
<4> <1>Unable to handle kernel paging request at virtual address 4f6269d4
<4> printing eip:
<4>c011ccc4
<1>*pde = 00000000
<4>Oops: 0000 [#50]
<4>PREEMPT 
<4>CPU:    0
<4>EIP:    0060:[<c011ccc4>]    Not tainted VLI
<4>EFLAGS: 00010893
<4>EIP is at do_page_fault+0x44/0x504
<4>eax: cc900000   ebx: 00000000   ecx: 0000007b   edx: 00000000
<4>esi: 00000000   edi: c011cc80   ebp: 4f62696c   esp: cc900074
<4>ds: 007b   es: 007b   ss: 0068
<4>Process  (pid: 1680683566, threadinfo=cc8fe000 task=c4831e74)
<4>Stack: 00000000 00000000 00000000 00000000 00000000 4f6269d4 00000000 00000000 
<4>       00030001 00000000 00000000 00000000 00000000 00000000 00000000 00000000 
<4>       00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000 
<4>Call Trace:
<4> [<c011cc80>] do_page_fault+0x0/0x504
<4> [<c02a92af>] error_code+0x2f/0x38
<4> [<c011cc80>] do_page_fault+0x0/0x504
<4> [<c011ccc4>] do_page_fault+0x44/0x504
<4> [<c011cc80>] do_page_fault+0x0/0x504
<4> [<c02a92af>] error_code+0x2f/0x38
<4> [<c011cc80>] do_page_fault+0x0/0x504
<4> [<c011ccc4>] do_page_fault+0x44/0x504
<4> [<c011cc80>] do_page_fault+0x0/0x504
<4> [<c02a92af>] error_code+0x2f/0x38
<4> [<c011cc80>] do_page_fault+0x0/0x504
<4> [<c011ccc4>] do_page_fault+0x44/0x504
<4> [<c011cc80>] do_page_fault+0x0/0x504
<4> [<c02a92af>] error_code+0x2f/0x38
<4> [<c011cc80>] do_page_fault+0x0/0x504
<4> [<c011ccc4>] do_page_fault+0x44/0x504
<4> [<c011cc80>] do_page_fault+0x0/0x504
<4> [<c02a92af>] error_code+0x2f/0x38
<4> [<c011cc80>] do_page_fault+0x0/0x504
<4> [<c011ccc4>] do_page_fault+0x44/0x504
<4> [<c011cc80>] do_page_fault+0x0/0x504
<4> [<c02a92af>] error_code+0x2f/0x38
<4> [<c011cc80>] do_page_fault+0x0/0x504
<4> [<c011ccc4>] do_page_fault+0x44/0x504
<4> [<c011cc80>] do_page_fault+0x0/0x504
<4> [<c02a92af>] error_code+0x2f/0x38
<4> [<c011cc80>] do_page_fault+0x0/0x504
<4> [<c011ccc4>] do_page_fault+0x44/0x504
<4> [<c011cc80>] do_page_fault+0x0/0x504
<4> [<c02a92af>] error_code+0x2f/0x38
<4> [<c011cc80>] do_page_fault+0x0/0x504
<4> [<c011ccc4>] do_page_fault+0x44/0x504
<4> [<c011cc80>] do_page_fault+0x0/0x504
<4> [<c02a92af>] error_code+0x2f/0x38
<4> [<c011cc80>] do_page_fault+0x0/0x504
<4> [<c011ccc4>] do_page_fault+0x44/0x504
<4> [<c011cc80>] do_page_fault+0x0/0x504
<4> [<c02a92af>] error_code+0x2f/0x38
<4> [<c011cc80>] do_page_fault+0x0/0x504
<4> [<c011ccc4>] do_page_fault+0x44/0x504
<4> [<c011cc80>] do_page_fault+0x0/0x504
<4> [<c02a92af>] error_code+0x2f/0x38
<4> [<c011cc80>] do_page_fault+0x0/0x504
<4> [<c011ccc4>] do_page_fault+0x44/0x504
<4> [<c011cc80>] do_page_fault+0x0/0x504
<4> [<c02a92af>] error_code+0x2f/0x38
<4> [<c011cc80>] do_page_fault+0x0/0x504
<4> [<c011ccc4>] do_page_fault+0x44/0x504
<4> [<c011cc80>] do_page_fault+0x0/0x504
<4> [<c02a92af>] error_code+0x2f/0x38
<4> [<c011cc80>] do_page_fault+0x0/0x504
<4> [<c011ccc4>] do_page_fault+0x44/0x504
<4> [<c011cc80>] do_page_fault+0x0/0x504
<4> [<c02a92af>] error_code+0x2f/0x38
<4> [<c011cc80>] do_page_fault+0x0/0x504
<4> [<c011ccc4>] do_page_fault+0x44/0x504
<4> [<c011cc80>] do_page_fault+0x0/0x504
<4> [<c02a92af>] error_code+0x2f/0x38
<4> [<c011cc80>] do_page_fault+0x0/0x504
<4> [<c011ccc4>] do_page_fault+0x44/0x504
<4> [<c011cc80>] do_page_fault+0x0/0x504
<4> [<c02a92af>] error_code+0x2f/0x38
<4> [<c011cc80>] do_page_fault+0x0/0x504
<4> [<c011ccc4>] do_page_fault+0x44/0x504
<4> [<c011cc80>] do_page_fault+0x0/0x504
<4> [<c02a92af>] error_code+0x2f/0x38
<4> [<c011cc80>] do_page_fault+0x0/0x504
<4> [<c011ccc4>] do_page_fault+0x44/0x504
<4> [<c011cc80>] do_page_fault+0x0/0x504
<4> [<c02a92af>] error_code+0x2f/0x38
<4> [<c011cc80>] do_page_fault+0x0/0x504
<4> [<c011ccc4>] do_page_fault+0x44/0x504
<4> [<c011cc80>] do_page_fault+0x0/0x504
<4> [<c02a92af>] error_code+0x2f/0x38
<4> [<c011cc80>] do_page_fault+0x0/0x504
<4> [<c011ccc4>] do_page_fault+0x44/0x504
<4> [<c011cc80>] do_page_fault+0x0/0x504
<4> [<c02a92af>] error_code+0x2f/0x38
<4> [<c011cc80>] do_page_fault+0x0/0x504
<4> [<c011ccc4>] do_page_fault+0x44/0x504
<4> [<c011cc80>] do_page_fault+0x0/0x504
<4> [<c02a92af>] error_code+0x2f/0x38
<4> [<c011cc80>] do_page_fault+0x0/0x504
<4> [<c011ccc4>] do_page_fault+0x44/0x504
<4> [<c011cc80>] do_page_fault+0x0/0x504
<4> [<c02a92af>] error_code+0x2f/0x38
<4> [<c011cc80>] do_page_fault+0x0/0x504
<4> [<c011ccc4>] do_page_fault+0x44/0x504
<4> [<c011cc80>] do_page_fault+0x0/0x504
<4> [<c02a92af>] error_code+0x2f/0x38
<4> [<c011cc80>] do_page_fault+0x0/0x504
<4> [<c011ccc4>] do_page_fault+0x44/0x504
<4> [<c011cc80>] do_page_fault+0x0/0x504
<4> [<c02a92af>] error_code+0x2f/0x38
<4> [<c011cc80>] do_page_fault+0x0/0x504
<4> [<c011ccc4>] do_page_fault+0x44/0x504
<4> [<c011cc80>] do_page_fault+0x0/0x504
<4> [<c02a92af>] error_code+0x2f/0x38
<4> [<c011cc80>] do_page_fault+0x0/0x504
<4> [<c011ccc4>] do_page_fault+0x44/0x504
<4> [<c011cc80>] do_page_fault+0x0/0x504
<4> [<c02a92af>] error_code+0x2f/0x38
<4> [<c011cc80>] do_page_fault+0x0/0x504
<4> [<c011ccc4>] do_page_fault+0x44/0x504
<4> [<c011cc80>] do_page_fault+0x0/0x504
<4> [<c02a92af>] error_code+0x2f/0x38
<4> [<c011cc80>] do_page_fault+0x0/0x504
<4> [<c011ccc4>] do_page_fault+0x44/0x504
<4> [<c011cc80>] do_page_fault+0x0/0x504
<4> [<c02a92af>] error_code+0x2f/0x38
<4> [<c011cc80>] do_page_fault+0x0/0x504
<4> [<c011ccc4>] do_page_fault+0x44/0x504
<4> [<c011cc80>] do_page_fault+0x0/0x504
<4> [<c02a92af>] error_code+0x2f/0x38
<4> [<c011cc80>] do_page_fault+0x0/0x504
<4> [<c011ccc4>] do_page_fault+0x44/0x504
<4> [<c011cc80>] do_page_fault+0x0/0x504
<4> [<c02a92af>] error_code+0x2f/0x38
<4> [<c011cc80>] do_page_fault+0x0/0x504
<4> [<c011ccc4>] do_page_fault+0x44/0x504
<4> [<c011cc80>] do_page_fault+0x0/0x504
<4> [<c02a92af>] error_code+0x2f/0x38
<4> [<c011cc80>] do_page_fault+0x0/0x504
<4> [<c011ccc4>] do_page_fault+0x44/0x504
<4> [<c011cc80>] do_page_fault+0x0/0x504
<4> [<c02a92af>] error_code+0x2f/0x38
<4> [<c011cc80>] do_page_fault+0x0/0x504
<4> [<c011ccc4>] do_page_fault+0x44/0x504
<4> [<c011cc80>] do_page_fault+0x0/0x504
<4> [<c02a92af>] error_code+0x2f/0x38
<4> [<c011cc80>] do_page_fault+0x0/0x504
<4> [<c011ccc4>] do_page_fault+0x44/0x504
<4> [<c011cc80>] do_page_fault+0x0/0x504
<4> [<c02a92af>] error_code+0x2f/0x38
<4> [<c011cc80>] do_page_fault+0x0/0x504
<4> [<c011ccc4>] do_page_fault+0x44/0x504
<4> [<c011cc80>] do_page_fault+0x0/0x504
<4> [<c02a92af>] error_code+0x2f/0x38
<4>
<4>Code: 42 30 00 02 02 00 74 01 fb b8 00 e0 ff ff 21 e0 81 7c 24 14 ff ff ff bf 8b 28 c7 44 24 20 01 00 03 00 0f 87 68 04 00 00 8b 50 14 <8b> 5d 68 8b 00 81 e2 ff ff ff fb 8b 40 14 f7 d0 c1 e8 1f 39 c2 
<4> <0>Kernel panic: Fatal exception in interrupt
<0>In interrupt handler - not syncing
<4> <0>Dumping messages in 0 seconds : last chance for Alt-SysRq...
--------------040409010103010804040306
Content-Type: text/plain;
 name="dmesg"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="dmesg"

rovided physical RAM map:
 BIOS-e820: 0000000000000000 - 000000000009fc00 (usable)
 BIOS-e820: 000000000009fc00 - 00000000000a0000 (reserved)
 BIOS-e820: 00000000000f0000 - 0000000000100000 (reserved)
 BIOS-e820: 0000000000100000 - 000000000fff0000 (usable)
 BIOS-e820: 000000000fff0000 - 000000000fff3000 (ACPI NVS)
 BIOS-e820: 000000000fff3000 - 0000000010000000 (ACPI data)
 BIOS-e820: 00000000fec00000 - 00000000fec01000 (reserved)
 BIOS-e820: 00000000fee00000 - 00000000fee01000 (reserved)
 BIOS-e820: 00000000ffff0000 - 0000000100000000 (reserved)
255MB LOWMEM available.
found SMP MP-table at 000f4d30
hm, page 000f4000 reserved twice.
hm, page 000f5000 reserved twice.
hm, page 000f0000 reserved twice.
hm, page 000f1000 reserved twice.
On node 0 totalpages: 65520
  DMA zone: 4096 pages, LIFO batch:1
  Normal zone: 61424 pages, LIFO batch:14
  HighMem zone: 0 pages, LIFO batch:1
DMI 2.3 present.
ACPI: RSDP (v000 GBT                                       ) @ 0x000f66a0
ACPI: RSDT (v001 GBT    AWRDACPI 0x42302e31 AWRD 0x01010101) @ 0x0fff3000
ACPI: FADT (v001 GBT    AWRDACPI 0x42302e31 AWRD 0x01010101) @ 0x0fff3040
ACPI: MADT (v001 GBT    AWRDACPI 0x42302e31 AWRD 0x01010101) @ 0x0fff6cc0
ACPI: DSDT (v001 GBT    AWRDACPI 0x00001000 MSFT 0x0100000c) @ 0x00000000
ACPI: Local APIC address 0xfee00000
ACPI: LAPIC (acpi_id[0x00] lapic_id[0x00] enabled)
Processor #0 6:6 APIC version 16
ACPI: LAPIC_NMI (acpi_id[0x00] polarity[0x0] trigger[0x0] lint[0x1])
ACPI: IOAPIC (id[0x02] address[0xfec00000] global_irq_base[0x0])
IOAPIC[0]: Assigned apic_id 2
IOAPIC[0]: apic_id 2, version 3, address 0xfec00000, IRQ 0-23
ACPI: INT_SRC_OVR (bus[0] irq[0x0] global_irq[0x2] polarity[0x0] trigger[0x0])
ACPI: INT_SRC_OVR (bus[0] irq[0x9] global_irq[0x9] polarity[0x3] trigger[0x3])
Enabling APIC mode:  Flat.  Using 1 I/O APICs
Using ACPI (MADT) for SMP configuration information
Building zonelist for node : 0
Kernel command line: root=/dev/hda1
current: c02eea60
current->thread_info: c0356000
Initializing CPU#0
PID hash table entries: 1024 (order 10: 8192 bytes)
Detected 1540.938 MHz processor.
Using tsc for high-res timesource
Console: colour VGA+ 80x25
Memory: 256044k/262080k available (1701k kernel code, 5308k reserved, 689k data, 132k init, 0k highmem)
zapping low mappings.
Calibrating delay loop... 3031.04 BogoMIPS
Dentry cache hash table entries: 32768 (order: 5, 131072 bytes)
Inode-cache hash table entries: 16384 (order: 4, 65536 bytes)
Mount-cache hash table entries: 512 (order: 0, 4096 bytes)
CPU:     After generic identify, caps: 0383fbff c1c3fbff 00000000 00000000
CPU:     After vendor identify, caps: 0383fbff c1c3fbff 00000000 00000000
CPU: L1 I Cache: 64K (64 bytes/line), D cache 64K (64 bytes/line)
CPU: L2 Cache: 256K (64 bytes/line)
CPU:     After all inits, caps: 0383fbff c1c3fbff 00000000 00000020
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#0.
CPU: AMD Athlon(tm) XP 1800+ stepping 02
Enabling fast FPU save and restore... done.
Enabling unmasked SIMD FPU exception support... done.
Checking 'hlt' instruction... OK.
POSIX conformance testing by UNIFIX
enabled ExtINT on CPU#0
ESR value before enabling vector: 00000000
ESR value after enabling vector: 00000000
ENABLING IO-APIC IRQs
init IO_APIC IRQs
 IO-APIC (apicid-pin) 2-0, 2-16, 2-17, 2-18, 2-19, 2-20, 2-21, 2-22, 2-23 not connected.
..TIMER: vector=0x31 pin1=2 pin2=-1
Using local APIC timer interrupts.
calibrating APIC timer ...
..... CPU clock speed is 1540.0195 MHz.
..... host bus clock speed is 267.0860 MHz.
NET: Registered protocol family 16
PCI: PCI BIOS revision 2.10 entry at 0xfa000, last bus=1
PCI: Using configuration type 1
mtrr: v2.0 (20020519)
ACPI: Subsystem revision 20031002
IOAPIC[0]: Set PCI routing entry (2-9 -> 0x71 -> IRQ 9 Mode:1 Active:1)
ACPI: Interpreter enabled
ACPI: Using IOAPIC for interrupt routing
ACPI: PCI Root Bridge [PCI0] (00:00)
PCI: Probing PCI hardware (bus 00)
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0._PRT]
ACPI: PCI Interrupt Link [LNKA] (IRQs 1 3 4 5 6 *7 10 11 12 14 15)
ACPI: PCI Interrupt Link [LNKB] (IRQs 1 *3 4 5 6 7 10 11 12 14 15)
ACPI: PCI Interrupt Link [LNKC] (IRQs 1 3 4 5 6 7 *10 11 12 14 15)
ACPI: PCI Interrupt Link [LNKD] (IRQs 1 3 4 5 6 7 10 *11 12 14 15)
ACPI: PCI Interrupt Link [ALKA] (IRQs 20)
ACPI: PCI Interrupt Link [ALKB] (IRQs 21)
ACPI: PCI Interrupt Link [ALKC] (IRQs 22)
ACPI: PCI Interrupt Link [ALKD] (IRQs 23)
Linux Plug and Play Support v0.97 (c) Adam Belay
PnPBIOS: Scanning system for PnP BIOS support...
PnPBIOS: Found PnP BIOS installation structure at 0xc00faa60
PnPBIOS: PnP BIOS version 1.0, entry 0xf0000:0xaa90, dseg 0xf0000
PnPBIOS: 14 nodes reported by PnP BIOS; 14 recorded by driver
IOAPIC[0]: Set PCI routing entry (2-17 -> 0xa9 -> IRQ 17 Mode:1 Active:1)
00:00:09[A] -> 2-17 -> IRQ 17
IOAPIC[0]: Set PCI routing entry (2-18 -> 0xb1 -> IRQ 18 Mode:1 Active:1)
00:00:09[B] -> 2-18 -> IRQ 18
IOAPIC[0]: Set PCI routing entry (2-19 -> 0xb9 -> IRQ 19 Mode:1 Active:1)
00:00:09[C] -> 2-19 -> IRQ 19
IOAPIC[0]: Set PCI routing entry (2-16 -> 0xc1 -> IRQ 16 Mode:1 Active:1)
00:00:09[D] -> 2-16 -> IRQ 16
Pin 2-18 already programmed
Pin 2-19 already programmed
Pin 2-16 already programmed
Pin 2-17 already programmed
Pin 2-19 already programmed
Pin 2-16 already programmed
Pin 2-17 already programmed
Pin 2-18 already programmed
Pin 2-16 already programmed
Pin 2-17 already programmed
Pin 2-18 already programmed
Pin 2-19 already programmed
Pin 2-17 already programmed
Pin 2-18 already programmed
Pin 2-19 already programmed
Pin 2-16 already programmed
Pin 2-19 already programmed
Pin 2-16 already programmed
Pin 2-17 already programmed
Pin 2-18 already programmed
Pin 2-16 already programmed
Pin 2-17 already programmed
Pin 2-18 already programmed
Pin 2-19 already programmed
Pin 2-18 already programmed
Pin 2-19 already programmed
Pin 2-16 already programmed
Pin 2-17 already programmed
Pin 2-17 already programmed
Pin 2-18 already programmed
Pin 2-19 already programmed
Pin 2-16 already programmed
_CRS returns NULL! Using IRQ 21 for device (PCI Interrupt Link [ALKB]).
ACPI: PCI Interrupt Link [ALKB] enabled at IRQ 21
IOAPIC[0]: Set PCI routing entry (2-21 -> 0xc9 -> IRQ 21 Mode:1 Active:1)
00:00:10[A] -> 2-21 -> IRQ 21
Pin 2-21 already programmed
Pin 2-21 already programmed
Pin 2-21 already programmed
_CRS returns NULL! Using IRQ 20 for device (PCI Interrupt Link [ALKA]).
ACPI: PCI Interrupt Link [ALKA] enabled at IRQ 20
IOAPIC[0]: Set PCI routing entry (2-20 -> 0xd1 -> IRQ 20 Mode:1 Active:1)
00:00:11[A] -> 2-20 -> IRQ 20
Pin 2-21 already programmed
_CRS returns NULL! Using IRQ 22 for device (PCI Interrupt Link [ALKC]).
ACPI: PCI Interrupt Link [ALKC] enabled at IRQ 22
IOAPIC[0]: Set PCI routing entry (2-22 -> 0xd9 -> IRQ 22 Mode:1 Active:1)
00:00:11[C] -> 2-22 -> IRQ 22
_CRS returns NULL! Using IRQ 23 for device (PCI Interrupt Link [ALKD]).
ACPI: PCI Interrupt Link [ALKD] enabled at IRQ 23
IOAPIC[0]: Set PCI routing entry (2-23 -> 0xe1 -> IRQ 23 Mode:1 Active:1)
00:00:11[D] -> 2-23 -> IRQ 23
Pin 2-16 already programmed
Pin 2-17 already programmed
Pin 2-18 already programmed
Pin 2-19 already programmed
Pin 2-23 already programmed
Pin 2-23 already programmed
Pin 2-23 already programmed
Pin 2-23 already programmed
number of MP IRQ sources: 15.
number of IO-APIC #2 registers: 24.
testing the IO APIC.......................
IO APIC #2......
.... register #00: 02000000
.......    : physical APIC id: 02
.......    : Delivery Type: 0
.......    : LTS          : 0
.... register #01: 00178003
.......     : max redirection entries: 0017
.......     : PRQ implemented: 1
.......     : IO APIC version: 0003
.... IRQ redirection table:
 NR Log Phy Mask Trig IRR Pol Stat Dest Deli Vect:   
 00 000 00  1    0    0   0   0    0    0    00
 01 001 01  0    0    0   0   0    1    1    39
 02 001 01  0    0    0   0   0    1    1    31
 03 001 01  0    0    0   0   0    1    1    41
 04 001 01  0    0    0   0   0    1    1    49
 05 001 01  0    0    0   0   0    1    1    51
 06 001 01  0    0    0   0   0    1    1    59
 07 001 01  0    0    0   0   0    1    1    61
 08 001 01  0    0    0   0   0    1    1    69
 09 001 01  0    1    0   1   0    1    1    71
 0a 001 01  0    0    0   0   0    1    1    79
 0b 001 01  0    0    0   0   0    1    1    81
 0c 001 01  0    0    0   0   0    1    1    89
 0d 001 01  0    0    0   0   0    1    1    91
 0e 001 01  0    0    0   0   0    1    1    99
 0f 001 01  0    0    0   0   0    1    1    A1
 10 001 01  1    1    0   1   0    1    1    C1
 11 001 01  1    1    0   1   0    1    1    A9
 12 001 01  1    1    0   1   0    1    1    B1
 13 001 01  1    1    0   1   0    1    1    B9
 14 001 01  1    1    0   1   0    1    1    D1
 15 001 01  1    1    0   1   0    1    1    C9
 16 001 01  1    1    0   1   0    1    1    D9
 17 001 01  1    1    0   1   0    1    1    E1
IRQ to pin mappings:
IRQ0 -> 0:2
IRQ1 -> 0:1
IRQ3 -> 0:3
IRQ4 -> 0:4
IRQ5 -> 0:5
IRQ6 -> 0:6
IRQ7 -> 0:7
IRQ8 -> 0:8
IRQ9 -> 0:9-> 0:9
IRQ10 -> 0:10
IRQ11 -> 0:11
IRQ12 -> 0:12
IRQ13 -> 0:13
IRQ14 -> 0:14
IRQ15 -> 0:15
IRQ16 -> 0:16
IRQ17 -> 0:17
IRQ18 -> 0:18
IRQ19 -> 0:19
IRQ20 -> 0:20
IRQ21 -> 0:21
IRQ22 -> 0:22
IRQ23 -> 0:23
.................................... done.
PCI: Using ACPI for IRQ routing
PCI: if you experience problems, try using option 'pci=noacpi' or even 'acpi=off'
Machine check exception polling timer started.
ikconfig 0.7 with /proc/config*
devfs: v1.22 (20021013) Richard Gooch (rgooch@atnf.csiro.au)
devfs: boot_options: 0x1
Initializing Cryptographic API
PCI: Via IRQ fixup for 0000:00:10.0, from 7 to 5
PCI: Via IRQ fixup for 0000:00:10.1, from 3 to 5
PCI: Via IRQ fixup for 0000:00:10.2, from 10 to 5
ACPI: Power Button (FF) [PWRF]
ACPI: Processor [CPU0] (supports C1, 2 throttling states)
pty: 256 Unix98 ptys configured
Real Time Clock Driver v1.12
8139too Fast Ethernet driver 0.9.26
eth0: RealTek RTL8139 at 0xd0807000, 00:20:ed:68:3a:db, IRQ 18
eth0:  Identified 8139 chip type 'RTL-8100B/8139D'
Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
PDC20276: IDE controller at PCI slot 0000:00:0f.0
PDC20276: chipset revision 1
PDC20276: 100% native mode on irq 19
    ide2: BM-DMA at 0xd000-0xd007, BIOS settings: hde:pio, hdf:pio
    ide3: BM-DMA at 0xd008-0xd00f, BIOS settings: hdg:pio, hdh:pio
hde: LITE-ON LTR-32123S, ATAPI CD/DVD-ROM drive
Using anticipatory io scheduler
ide2 at 0xc000-0xc007,0xc402 on irq 19
VP_IDE: IDE controller at PCI slot 0000:00:11.1
VP_IDE: chipset revision 6
VP_IDE: not 100% native mode: will probe irqs later
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
VP_IDE: VIA vt8235 (rev 00) IDE UDMA133 controller on pci0000:00:11.1
    ide0: BM-DMA at 0xe000-0xe007, BIOS settings: hda:DMA, hdb:pio
    ide1: BM-DMA at 0xe008-0xe00f, BIOS settings: hdc:DMA, hdd:DMA
hda: IC35L080AVVA07-0, ATA DISK drive
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
hdc: IBM-DTLA-307045, ATA DISK drive
hdd: IBM-DHEA-36480, ATA DISK drive
ide1 at 0x170-0x177,0x376 on irq 15
hda: max request size: 128KiB
hda: 160836480 sectors (82348 MB) w/1863KiB Cache, CHS=65535/16/63, UDMA(100)
 /dev/ide/host0/bus0/target0/lun0: p1 p2 p3 p4
hdc: max request size: 128KiB
hdc: 90069840 sectors (46115 MB) w/1916KiB Cache, CHS=65535/16/63, UDMA(100)
 /dev/ide/host0/bus1/target0/lun0: p1 p2
hdd: max request size: 128KiB
hdd: 12692736 sectors (6498 MB) w/476KiB Cache, CHS=12592/16/63, UDMA(33)
 /dev/ide/host0/bus1/target1/lun0: p1
hde: ATAPI 40X CD-ROM CD-R/RW drive, 1984kB Cache
Uniform CD-ROM driver Revision: 3.12
mice: PS/2 mouse device common for all mice
input: ImPS/2 Logitech Wheel Mouse on isa0060/serio1
serio: i8042 AUX port at 0x60,0x64 irq 12
input: AT Translated Set 2 keyboard on isa0060/serio0
serio: i8042 KBD port at 0x60,0x64 irq 1
NET: Registered protocol family 2
IP: routing cache hash table of 2048 buckets, 16Kbytes
TCP: Hash tables configured (established 16384 bind 32768)
NET: Registered protocol family 1
NET: Registered protocol family 15
NET: Registered protocol family 8
NET: Registered protocol family 20
ACPI: (supports S0 S1 S4 S5)
found reiserfs format "3.6" with standard journal
Reiserfs journal params: device hda1, size 8192, journal first block 18, max trans len 1024, max batch 900, max commit age 30, max trans age 30
reiserfs: checking transaction log (hda1) for (hda1)
reiserfs: replayed 63 transactions in 2 seconds
Using r5 hash to sort names
VFS: Mounted root (reiserfs filesystem) readonly.
Mounted devfs on /dev
Freeing unused kernel memory: 132k freed
Adding 265064k swap on /dev/hda2.  Priority:-1 extents:1
NTFS driver 2.1.5 [Flags: R/W MODULE].
NTFS volume version 3.0.
found reiserfs format "3.6" with standard journal
Reiserfs journal params: device hda4, size 8192, journal first block 18, max trans len 1024, max batch 900, max commit age 30, max trans age 30
reiserfs: checking transaction log (hda4) for (hda4)
Using r5 hash to sort names
cdrom: open failed.
found reiserfs format "3.6" with standard journal
Reiserfs journal params: device hdd1, size 8192, journal first block 18, max trans len 1024, max batch 900, max commit age 30, max trans age 30
reiserfs: checking transaction log (hdd1) for (hdd1)
Using r5 hash to sort names
drivers/usb/core/usb.c: registered new driver usbfs
drivers/usb/core/usb.c: registered new driver hub
ehci_hcd 0000:00:10.3: EHCI Host Controller
ehci_hcd 0000:00:10.3: irq 21, pci mem d0ac4000
ehci_hcd 0000:00:10.3: new USB bus registered, assigned bus number 1
ehci_hcd 0000:00:10.3: USB 2.0 enabled, EHCI 1.00, driver 2003-Jun-13
hub 1-0:1.0: USB hub found
hub 1-0:1.0: 6 ports detected
drivers/usb/host/uhci-hcd.c: USB Universal Host Controller Interface driver v2.1
uhci_hcd 0000:00:10.0: UHCI Host Controller
uhci_hcd 0000:00:10.0: irq 21, io base 0000d400
uhci_hcd 0000:00:10.0: new USB bus registered, assigned bus number 2
hub 2-0:1.0: USB hub found
hub 2-0:1.0: 2 ports detected
uhci_hcd 0000:00:10.1: UHCI Host Controller
uhci_hcd 0000:00:10.1: irq 21, io base 0000d800
uhci_hcd 0000:00:10.1: new USB bus registered, assigned bus number 3
hub 3-0:1.0: USB hub found
hub 3-0:1.0: 2 ports detected
uhci_hcd 0000:00:10.2: UHCI Host Controller
uhci_hcd 0000:00:10.2: irq 21, io base 0000dc00
uhci_hcd 0000:00:10.2: new USB bus registered, assigned bus number 4
hub 4-0:1.0: USB hub found
hub 4-0:1.0: 2 ports detected
atmsvc: no signaling demon
hub 2-0:1.0: new USB device on port 1, assigned address 2
hub 2-0:1.0: new USB device on port 2, assigned address 3
eth0: link down
blk: queue c1382c00, I/O limit 4095Mb (mask 0xffffffff)
blk: queue c1382400, I/O limit 4095Mb (mask 0xffffffff)
drivers/usb/core/usb.c: registered new driver speedtch
via82xx: Assuming DXS channels with 48k fixed sample rate.
         Please try dxs_support=1 option and report if it works on your machine.
PCI: Setting latency timer of device 0000:00:11.5 to 64
NET: Registered protocol family 17
usb 2-2: bulk timeout on ep5in
usbfs: USBDEVFS_BULK failed dev 3 ep 0x85 len 512 ret -110
ip_tables: (C) 2000-2002 Netfilter core team
ip_conntrack version 2.1 (2047 buckets, 16376 max) - 300 bytes per conntrack
usbfs: process 1094 (modem_run) did not claim interface 0 before use
HTB init, kernel part version 3.13

--------------040409010103010804040306
Content-Type: text/plain;
 name="config-2.6.0-test10-mm1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="config-2.6.0-test10-mm1"

#
# Automatically generated make config: don't edit
#
CONFIG_X86=y
CONFIG_MMU=y
CONFIG_UID16=y
CONFIG_GENERIC_ISA_DMA=y

#
# Code maturity level options
#
CONFIG_EXPERIMENTAL=y
CONFIG_CLEAN_COMPILE=y
CONFIG_STANDALONE=y
CONFIG_BROKEN_ON_SMP=y

#
# General setup
#
CONFIG_SWAP=y
CONFIG_SYSVIPC=y
CONFIG_BSD_PROCESS_ACCT=y
CONFIG_SYSCTL=y
CONFIG_LOG_BUF_SHIFT=14
CONFIG_IKCONFIG=y
CONFIG_IKCONFIG_PROC=y
# CONFIG_EMBEDDED is not set
CONFIG_KALLSYMS=y
CONFIG_FUTEX=y
CONFIG_EPOLL=y
CONFIG_IOSCHED_NOOP=y
CONFIG_IOSCHED_AS=y
CONFIG_IOSCHED_DEADLINE=y
CONFIG_IOSCHED_CFQ=y
# CONFIG_CC_OPTIMIZE_FOR_SIZE is not set

#
# Loadable module support
#
CONFIG_MODULES=y
CONFIG_MODULE_UNLOAD=y
# CONFIG_MODULE_FORCE_UNLOAD is not set
CONFIG_OBSOLETE_MODPARM=y
# CONFIG_MODVERSIONS is not set
CONFIG_KMOD=y

#
# Processor type and features
#
CONFIG_X86_PC=y
# CONFIG_X86_VOYAGER is not set
# CONFIG_X86_NUMAQ is not set
# CONFIG_X86_SUMMIT is not set
# CONFIG_X86_BIGSMP is not set
# CONFIG_X86_VISWS is not set
# CONFIG_X86_GENERICARCH is not set
# CONFIG_X86_ES7000 is not set
# CONFIG_M386 is not set
# CONFIG_M486 is not set
# CONFIG_M586 is not set
# CONFIG_M586TSC is not set
# CONFIG_M586MMX is not set
# CONFIG_M686 is not set
# CONFIG_MPENTIUMII is not set
# CONFIG_MPENTIUMIII is not set
# CONFIG_MPENTIUM4 is not set
# CONFIG_MK6 is not set
CONFIG_MK7=y
# CONFIG_MK8 is not set
# CONFIG_MELAN is not set
# CONFIG_MCRUSOE is not set
# CONFIG_MWINCHIPC6 is not set
# CONFIG_MWINCHIP2 is not set
# CONFIG_MWINCHIP3D is not set
# CONFIG_MCYRIXIII is not set
# CONFIG_MVIAC3_2 is not set
# CONFIG_X86_GENERIC is not set
CONFIG_X86_CMPXCHG=y
CONFIG_X86_XADD=y
CONFIG_X86_L1_CACHE_SHIFT=6
CONFIG_RWSEM_XCHGADD_ALGORITHM=y
CONFIG_X86_WP_WORKS_OK=y
CONFIG_X86_INVLPG=y
CONFIG_X86_BSWAP=y
CONFIG_X86_POPAD_OK=y
CONFIG_X86_GOOD_APIC=y
CONFIG_X86_INTEL_USERCOPY=y
CONFIG_X86_USE_PPRO_CHECKSUM=y
CONFIG_X86_USE_3DNOW=y
# CONFIG_X86_4G is not set
# CONFIG_X86_SWITCH_PAGETABLES is not set
# CONFIG_X86_4G_VM_LAYOUT is not set
# CONFIG_X86_UACCESS_INDIRECT is not set
# CONFIG_X86_HIGH_ENTRY is not set
CONFIG_HPET_TIMER=y
CONFIG_HPET_EMULATE_RTC=y
# CONFIG_SMP is not set
CONFIG_PREEMPT=y
CONFIG_X86_UP_APIC=y
CONFIG_X86_UP_IOAPIC=y
CONFIG_X86_LOCAL_APIC=y
CONFIG_X86_IO_APIC=y
CONFIG_X86_TSC=y
CONFIG_X86_MCE=y
CONFIG_X86_MCE_NONFATAL=y
# CONFIG_X86_MCE_P4THERMAL is not set
# CONFIG_TOSHIBA is not set
# CONFIG_I8K is not set
# CONFIG_MICROCODE is not set
# CONFIG_X86_MSR is not set
# CONFIG_X86_CPUID is not set
# CONFIG_EDD is not set
CONFIG_NOHIGHMEM=y
# CONFIG_HIGHMEM4G is not set
# CONFIG_HIGHMEM64G is not set
# CONFIG_MATH_EMULATION is not set
CONFIG_MTRR=y
# CONFIG_EFI is not set
CONFIG_HAVE_DEC_LOCK=y

#
# Power management options (ACPI, APM)
#
CONFIG_PM=y
CONFIG_SOFTWARE_SUSPEND=y
# CONFIG_PM_DISK is not set

#
# ACPI (Advanced Configuration and Power Interface) Support
#
CONFIG_ACPI=y
CONFIG_ACPI_BOOT=y
CONFIG_ACPI_INTERPRETER=y
CONFIG_ACPI_SLEEP=y
CONFIG_ACPI_SLEEP_PROC_FS=y
# CONFIG_ACPI_AC is not set
# CONFIG_ACPI_BATTERY is not set
CONFIG_ACPI_BUTTON=y
CONFIG_ACPI_FAN=y
CONFIG_ACPI_PROCESSOR=y
CONFIG_ACPI_THERMAL=y
# CONFIG_ACPI_ASUS is not set
# CONFIG_ACPI_TOSHIBA is not set
# CONFIG_ACPI_DEBUG is not set
CONFIG_ACPI_BUS=y
CONFIG_ACPI_EC=y
CONFIG_ACPI_POWER=y
CONFIG_ACPI_PCI=y
CONFIG_ACPI_SYSTEM=y
# CONFIG_ACPI_RELAXED_AML is not set
# CONFIG_X86_PM_TIMER is not set

#
# APM (Advanced Power Management) BIOS Support
#
# CONFIG_APM is not set

#
# CPU Frequency scaling
#
# CONFIG_CPU_FREQ is not set

#
# Bus options (PCI, PCMCIA, EISA, MCA, ISA)
#
CONFIG_PCI=y
# CONFIG_PCI_GOBIOS is not set
# CONFIG_PCI_GODIRECT is not set
CONFIG_PCI_GOANY=y
CONFIG_PCI_BIOS=y
CONFIG_PCI_DIRECT=y
# CONFIG_PCI_USE_VECTOR is not set
# CONFIG_PCI_LEGACY_PROC is not set
CONFIG_PCI_NAMES=y
# CONFIG_ISA is not set
# CONFIG_MCA is not set
# CONFIG_SCx200 is not set
CONFIG_HOTPLUG=y

#
# PCMCIA/CardBus support
#
# CONFIG_PCMCIA is not set

#
# PCI Hotplug Support
#
# CONFIG_HOTPLUG_PCI is not set

#
# Executable file formats
#
CONFIG_BINFMT_ELF=y
CONFIG_BINFMT_AOUT=m
CONFIG_BINFMT_MISC=m

#
# Device Drivers
#

#
# Generic Driver Options
#
# CONFIG_FW_LOADER is not set

#
# Memory Technology Devices (MTD)
#
# CONFIG_MTD is not set

#
# Parallel port support
#
CONFIG_PARPORT=m
CONFIG_PARPORT_PC=m
CONFIG_PARPORT_PC_CML1=m
# CONFIG_PARPORT_SERIAL is not set
CONFIG_PARPORT_PC_FIFO=y
# CONFIG_PARPORT_PC_SUPERIO is not set
# CONFIG_PARPORT_OTHER is not set
CONFIG_PARPORT_1284=y

#
# Plug and Play support
#
CONFIG_PNP=y
# CONFIG_PNP_DEBUG is not set

#
# Protocols
#
# CONFIG_ISAPNP is not set
CONFIG_PNPBIOS=y
# CONFIG_PNPBIOS_PROC_FS is not set

#
# Block devices
#
CONFIG_BLK_DEV_FD=m
CONFIG_PARIDE=m
CONFIG_PARIDE_PARPORT=m

#
# Parallel IDE high-level drivers
#
# CONFIG_PARIDE_PD is not set
# CONFIG_PARIDE_PCD is not set
# CONFIG_PARIDE_PF is not set
# CONFIG_PARIDE_PT is not set
# CONFIG_PARIDE_PG is not set

#
# Parallel IDE protocol modules
#
# CONFIG_PARIDE_ATEN is not set
# CONFIG_PARIDE_BPCK is not set
# CONFIG_PARIDE_BPCK6 is not set
# CONFIG_PARIDE_COMM is not set
# CONFIG_PARIDE_DSTR is not set
# CONFIG_PARIDE_FIT2 is not set
# CONFIG_PARIDE_FIT3 is not set
# CONFIG_PARIDE_EPAT is not set
# CONFIG_PARIDE_EPIA is not set
# CONFIG_PARIDE_FRIQ is not set
# CONFIG_PARIDE_FRPW is not set
# CONFIG_PARIDE_KBIC is not set
# CONFIG_PARIDE_KTTI is not set
# CONFIG_PARIDE_ON20 is not set
# CONFIG_PARIDE_ON26 is not set
# CONFIG_BLK_CPQ_DA is not set
# CONFIG_BLK_CPQ_CISS_DA is not set
# CONFIG_BLK_DEV_DAC960 is not set
# CONFIG_BLK_DEV_UMEM is not set
CONFIG_BLK_DEV_LOOP=m
CONFIG_BLK_DEV_CRYPTOLOOP=m
CONFIG_BLK_DEV_NBD=m
CONFIG_BLK_DEV_RAM=m
CONFIG_BLK_DEV_RAM_SIZE=4096
# CONFIG_BLK_DEV_INITRD is not set
# CONFIG_LBD is not set

#
# ATA/ATAPI/MFM/RLL support
#
CONFIG_IDE=y
CONFIG_BLK_DEV_IDE=y

#
# Please see Documentation/ide.txt for help/info on IDE drives
#
# CONFIG_BLK_DEV_HD_IDE is not set
CONFIG_BLK_DEV_IDEDISK=y
# CONFIG_IDEDISK_MULTI_MODE is not set
# CONFIG_IDEDISK_STROKE is not set
CONFIG_BLK_DEV_IDECD=y
# CONFIG_BLK_DEV_IDETAPE is not set
# CONFIG_BLK_DEV_IDEFLOPPY is not set
CONFIG_IDE_TASK_IOCTL=y
CONFIG_IDE_TASKFILE_IO=y

#
# IDE chipset support/bugfixes
#
# CONFIG_BLK_DEV_CMD640 is not set
# CONFIG_BLK_DEV_IDEPNP is not set
CONFIG_BLK_DEV_IDEPCI=y
CONFIG_IDEPCI_SHARE_IRQ=y
# CONFIG_BLK_DEV_OFFBOARD is not set
CONFIG_BLK_DEV_GENERIC=y
# CONFIG_BLK_DEV_OPTI621 is not set
# CONFIG_BLK_DEV_RZ1000 is not set
CONFIG_BLK_DEV_IDEDMA_PCI=y
# CONFIG_BLK_DEV_IDEDMA_FORCED is not set
CONFIG_IDEDMA_PCI_AUTO=y
# CONFIG_IDEDMA_ONLYDISK is not set
# CONFIG_IDEDMA_PCI_WIP is not set
CONFIG_BLK_DEV_ADMA=y
# CONFIG_BLK_DEV_AEC62XX is not set
# CONFIG_BLK_DEV_ALI15X3 is not set
# CONFIG_BLK_DEV_AMD74XX is not set
# CONFIG_BLK_DEV_CMD64X is not set
# CONFIG_BLK_DEV_TRIFLEX is not set
# CONFIG_BLK_DEV_CY82C693 is not set
# CONFIG_BLK_DEV_CS5520 is not set
# CONFIG_BLK_DEV_CS5530 is not set
# CONFIG_BLK_DEV_HPT34X is not set
# CONFIG_BLK_DEV_HPT366 is not set
# CONFIG_BLK_DEV_SC1200 is not set
# CONFIG_BLK_DEV_PIIX is not set
# CONFIG_BLK_DEV_NS87415 is not set
# CONFIG_BLK_DEV_PDC202XX_OLD is not set
CONFIG_BLK_DEV_PDC202XX_NEW=y
CONFIG_PDC202XX_FORCE=y
# CONFIG_BLK_DEV_SVWKS is not set
# CONFIG_BLK_DEV_SIIMAGE is not set
# CONFIG_BLK_DEV_SIS5513 is not set
# CONFIG_BLK_DEV_SLC90E66 is not set
# CONFIG_BLK_DEV_TRM290 is not set
CONFIG_BLK_DEV_VIA82CXXX=y
CONFIG_BLK_DEV_IDEDMA=y
# CONFIG_IDEDMA_IVB is not set
CONFIG_IDEDMA_AUTO=y
# CONFIG_DMA_NONPCI is not set
# CONFIG_BLK_DEV_HD is not set

#
# SCSI device support
#
# CONFIG_SCSI is not set

#
# Multi-device support (RAID and LVM)
#
# CONFIG_MD is not set

#
# Fusion MPT device support
#

#
# IEEE 1394 (FireWire) support (EXPERIMENTAL)
#
# CONFIG_IEEE1394 is not set

#
# I2O device support
#
# CONFIG_I2O is not set

#
# Networking support
#
CONFIG_NET=y

#
# Networking options
#
CONFIG_PACKET=m
CONFIG_PACKET_MMAP=y
# CONFIG_NETLINK_DEV is not set
CONFIG_UNIX=y
CONFIG_NET_KEY=y
CONFIG_INET=y
# CONFIG_IP_MULTICAST is not set
# CONFIG_IP_ADVANCED_ROUTER is not set
# CONFIG_IP_PNP is not set
# CONFIG_NET_IPIP is not set
# CONFIG_NET_IPGRE is not set
# CONFIG_ARPD is not set
CONFIG_INET_ECN=y
CONFIG_SYN_COOKIES=y
# CONFIG_INET_AH is not set
# CONFIG_INET_ESP is not set
# CONFIG_INET_IPCOMP is not set

#
# IP: Virtual Server Configuration
#
# CONFIG_IP_VS is not set
# CONFIG_IPV6 is not set
# CONFIG_DECNET is not set
# CONFIG_BRIDGE is not set
CONFIG_NETFILTER=y
# CONFIG_NETFILTER_DEBUG is not set

#
# IP: Netfilter Configuration
#
CONFIG_IP_NF_CONNTRACK=m
CONFIG_IP_NF_FTP=m
CONFIG_IP_NF_IRC=m
# CONFIG_IP_NF_TFTP is not set
# CONFIG_IP_NF_AMANDA is not set
CONFIG_IP_NF_QUEUE=m
CONFIG_IP_NF_IPTABLES=m
CONFIG_IP_NF_MATCH_LIMIT=m
CONFIG_IP_NF_MATCH_IPRANGE=m
CONFIG_IP_NF_MATCH_MAC=m
CONFIG_IP_NF_MATCH_PKTTYPE=m
CONFIG_IP_NF_MATCH_MARK=m
CONFIG_IP_NF_MATCH_MULTIPORT=m
CONFIG_IP_NF_MATCH_TOS=m
CONFIG_IP_NF_MATCH_RECENT=m
CONFIG_IP_NF_MATCH_ECN=m
CONFIG_IP_NF_MATCH_DSCP=m
CONFIG_IP_NF_MATCH_AH_ESP=m
CONFIG_IP_NF_MATCH_LENGTH=m
CONFIG_IP_NF_MATCH_TTL=m
CONFIG_IP_NF_MATCH_TCPMSS=m
CONFIG_IP_NF_MATCH_HELPER=m
CONFIG_IP_NF_MATCH_STATE=m
CONFIG_IP_NF_MATCH_CONNTRACK=m
CONFIG_IP_NF_MATCH_OWNER=m
CONFIG_IP_NF_FILTER=m
CONFIG_IP_NF_TARGET_REJECT=m
CONFIG_IP_NF_NAT=m
CONFIG_IP_NF_NAT_NEEDED=y
CONFIG_IP_NF_TARGET_MASQUERADE=m
CONFIG_IP_NF_TARGET_REDIRECT=m
CONFIG_IP_NF_TARGET_NETMAP=m
# CONFIG_IP_NF_TARGET_SAME is not set
# CONFIG_IP_NF_NAT_LOCAL is not set
# CONFIG_IP_NF_NAT_SNMP_BASIC is not set
CONFIG_IP_NF_NAT_IRC=m
CONFIG_IP_NF_NAT_FTP=m
CONFIG_IP_NF_MANGLE=m
CONFIG_IP_NF_TARGET_TOS=m
CONFIG_IP_NF_TARGET_ECN=m
CONFIG_IP_NF_TARGET_DSCP=m
CONFIG_IP_NF_TARGET_MARK=m
CONFIG_IP_NF_TARGET_CLASSIFY=m
CONFIG_IP_NF_TARGET_LOG=m
CONFIG_IP_NF_TARGET_ULOG=m
CONFIG_IP_NF_TARGET_TCPMSS=m
# CONFIG_IP_NF_ARPTABLES is not set
# CONFIG_IP_NF_COMPAT_IPCHAINS is not set
# CONFIG_IP_NF_COMPAT_IPFWADM is not set
CONFIG_XFRM=y
# CONFIG_XFRM_USER is not set

#
# SCTP Configuration (EXPERIMENTAL)
#
CONFIG_IPV6_SCTP__=y
# CONFIG_IP_SCTP is not set
CONFIG_ATM=y
CONFIG_ATM_CLIP=m
CONFIG_ATM_CLIP_NO_ICMP=y
CONFIG_ATM_LANE=m
CONFIG_ATM_MPOA=m
CONFIG_ATM_BR2684=m
# CONFIG_ATM_BR2684_IPFILTER is not set
# CONFIG_VLAN_8021Q is not set
# CONFIG_LLC2 is not set
# CONFIG_IPX is not set
# CONFIG_ATALK is not set
# CONFIG_X25 is not set
# CONFIG_LAPB is not set
# CONFIG_NET_DIVERT is not set
# CONFIG_ECONET is not set
# CONFIG_WAN_ROUTER is not set
# CONFIG_NET_FASTROUTE is not set
# CONFIG_NET_HW_FLOWCONTROL is not set

#
# QoS and/or fair queueing
#
CONFIG_NET_SCHED=y
CONFIG_NET_SCH_CBQ=m
CONFIG_NET_SCH_HTB=m
CONFIG_NET_SCH_CSZ=m
# CONFIG_NET_SCH_ATM is not set
CONFIG_NET_SCH_PRIO=m
CONFIG_NET_SCH_RED=m
CONFIG_NET_SCH_SFQ=m
CONFIG_NET_SCH_TEQL=m
CONFIG_NET_SCH_TBF=m
CONFIG_NET_SCH_GRED=m
CONFIG_NET_SCH_DSMARK=m
CONFIG_NET_SCH_INGRESS=m
CONFIG_NET_QOS=y
CONFIG_NET_ESTIMATOR=y
CONFIG_NET_CLS=y
CONFIG_NET_CLS_TCINDEX=m
CONFIG_NET_CLS_ROUTE4=m
CONFIG_NET_CLS_ROUTE=y
CONFIG_NET_CLS_FW=m
CONFIG_NET_CLS_U32=m
CONFIG_NET_CLS_RSVP=m
CONFIG_NET_CLS_RSVP6=m
CONFIG_NET_CLS_POLICE=y

#
# Network testing
#
# CONFIG_NET_PKTGEN is not set
CONFIG_NETDEVICES=y

#
# ARCnet devices
#
# CONFIG_ARCNET is not set
CONFIG_DUMMY=m
# CONFIG_BONDING is not set
# CONFIG_EQUALIZER is not set
# CONFIG_TUN is not set
# CONFIG_NET_SB1000 is not set

#
# Ethernet (10 or 100Mbit)
#
CONFIG_NET_ETHERNET=y
CONFIG_MII=y
# CONFIG_HAPPYMEAL is not set
# CONFIG_SUNGEM is not set
# CONFIG_NET_VENDOR_3COM is not set

#
# Tulip family network device support
#
# CONFIG_NET_TULIP is not set
# CONFIG_HP100 is not set
CONFIG_NET_PCI=y
# CONFIG_PCNET32 is not set
# CONFIG_AMD8111_ETH is not set
# CONFIG_ADAPTEC_STARFIRE is not set
# CONFIG_B44 is not set
# CONFIG_FORCEDETH is not set
# CONFIG_DGRS is not set
# CONFIG_EEPRO100 is not set
# CONFIG_E100 is not set
# CONFIG_FEALNX is not set
# CONFIG_NATSEMI is not set
# CONFIG_NE2K_PCI is not set
# CONFIG_8139CP is not set
CONFIG_8139TOO=y
# CONFIG_8139TOO_PIO is not set
# CONFIG_8139TOO_TUNE_TWISTER is not set
# CONFIG_8139TOO_8129 is not set
# CONFIG_8139_OLD_RX_RESET is not set
# CONFIG_SIS900 is not set
# CONFIG_EPIC100 is not set
# CONFIG_SUNDANCE is not set
# CONFIG_TLAN is not set
# CONFIG_VIA_RHINE is not set

#
# Ethernet (1000 Mbit)
#
# CONFIG_ACENIC is not set
# CONFIG_DL2K is not set
# CONFIG_E1000 is not set
# CONFIG_NS83820 is not set
# CONFIG_HAMACHI is not set
# CONFIG_YELLOWFIN is not set
# CONFIG_R8169 is not set
# CONFIG_SIS190 is not set
# CONFIG_SK98LIN is not set
# CONFIG_TIGON3 is not set

#
# Ethernet (10000 Mbit)
#
# CONFIG_IXGB is not set
# CONFIG_FDDI is not set
# CONFIG_HIPPI is not set
# CONFIG_PLIP is not set
CONFIG_PPP=m
CONFIG_PPP_MULTILINK=y
CONFIG_PPP_FILTER=y
CONFIG_PPP_ASYNC=m
CONFIG_PPP_SYNC_TTY=m
CONFIG_PPP_DEFLATE=m
CONFIG_PPP_BSDCOMP=m
CONFIG_PPPOE=m
CONFIG_PPPOATM=m
CONFIG_SLIP=m
CONFIG_SLIP_COMPRESSED=y
CONFIG_SLIP_SMART=y
# CONFIG_SLIP_MODE_SLIP6 is not set

#
# Wireless LAN (non-hamradio)
#
# CONFIG_NET_RADIO is not set

#
# Token Ring devices
#
# CONFIG_TR is not set
# CONFIG_RCPCI is not set
# CONFIG_SHAPER is not set
# CONFIG_NET_POLL_CONTROLLER is not set

#
# Wan interfaces
#
# CONFIG_WAN is not set

#
# ATM drivers
#
# CONFIG_ATM_TCP is not set
# CONFIG_ATM_LANAI is not set
# CONFIG_ATM_ENI is not set
# CONFIG_ATM_FIRESTREAM is not set
# CONFIG_ATM_ZATM is not set
# CONFIG_ATM_NICSTAR is not set
# CONFIG_ATM_IDT77252 is not set
# CONFIG_ATM_AMBASSADOR is not set
# CONFIG_ATM_HORIZON is not set
# CONFIG_ATM_IA is not set
# CONFIG_ATM_FORE200E_MAYBE is not set
# CONFIG_ATM_HE is not set

#
# Amateur Radio support
#
# CONFIG_HAMRADIO is not set

#
# IrDA (infrared) support
#
# CONFIG_IRDA is not set

#
# Bluetooth support
#
# CONFIG_BT is not set

#
# ISDN subsystem
#
# CONFIG_ISDN_BOOL is not set

#
# Telephony Support
#
# CONFIG_PHONE is not set

#
# Input device support
#
CONFIG_INPUT=y

#
# Userland interfaces
#
CONFIG_INPUT_MOUSEDEV=y
CONFIG_INPUT_MOUSEDEV_PSAUX=y
CONFIG_INPUT_MOUSEDEV_SCREEN_X=1024
CONFIG_INPUT_MOUSEDEV_SCREEN_Y=768
CONFIG_INPUT_JOYDEV=y
# CONFIG_INPUT_TSDEV is not set
# CONFIG_INPUT_EVDEV is not set
# CONFIG_INPUT_EVBUG is not set

#
# Input I/O drivers
#
# CONFIG_GAMEPORT is not set
CONFIG_SOUND_GAMEPORT=y
CONFIG_SERIO=y
CONFIG_SERIO_I8042=y
CONFIG_SERIO_SERPORT=y
# CONFIG_SERIO_CT82C710 is not set
# CONFIG_SERIO_PARKBD is not set
# CONFIG_SERIO_PCIPS2 is not set

#
# Input Device Drivers
#
CONFIG_INPUT_KEYBOARD=y
CONFIG_KEYBOARD_ATKBD=y
# CONFIG_KEYBOARD_SUNKBD is not set
# CONFIG_KEYBOARD_XTKBD is not set
# CONFIG_KEYBOARD_NEWTON is not set
CONFIG_INPUT_MOUSE=y
CONFIG_MOUSE_PS2=y
# CONFIG_MOUSE_PS2_SYNAPTICS is not set
# CONFIG_MOUSE_SERIAL is not set
# CONFIG_INPUT_JOYSTICK is not set
# CONFIG_INPUT_TOUCHSCREEN is not set
# CONFIG_INPUT_MISC is not set

#
# Character devices
#
CONFIG_VT=y
CONFIG_VT_CONSOLE=y
CONFIG_HW_CONSOLE=y
# CONFIG_SERIAL_NONSTANDARD is not set

#
# Serial drivers
#
CONFIG_SERIAL_8250=m
# CONFIG_SERIAL_8250_ACPI is not set
CONFIG_SERIAL_8250_NR_UARTS=4
# CONFIG_SERIAL_8250_EXTENDED is not set

#
# Non-8250 serial port support
#
CONFIG_SERIAL_CORE=m
CONFIG_UNIX98_PTYS=y
CONFIG_UNIX98_PTY_COUNT=256
CONFIG_PRINTER=m
# CONFIG_LP_CONSOLE is not set
# CONFIG_PPDEV is not set
# CONFIG_TIPAR is not set

#
# I2C support
#
CONFIG_I2C=m
CONFIG_I2C_CHARDEV=m

#
# I2C Algorithms
#
CONFIG_I2C_ALGOBIT=m
# CONFIG_I2C_ALGOPCF is not set

#
# I2C Hardware Bus support
#
# CONFIG_I2C_ALI1535 is not set
# CONFIG_I2C_ALI15X3 is not set
# CONFIG_I2C_AMD756 is not set
# CONFIG_I2C_AMD8111 is not set
# CONFIG_I2C_I801 is not set
# CONFIG_I2C_I810 is not set
# CONFIG_I2C_NFORCE2 is not set
# CONFIG_I2C_PHILIPSPAR is not set
# CONFIG_I2C_PIIX4 is not set
# CONFIG_I2C_PROSAVAGE is not set
# CONFIG_I2C_SAVAGE4 is not set
# CONFIG_SCx200_ACB is not set
# CONFIG_I2C_SIS5595 is not set
# CONFIG_I2C_SIS630 is not set
# CONFIG_I2C_SIS96X is not set
CONFIG_I2C_VIA=m
CONFIG_I2C_VIAPRO=m
# CONFIG_I2C_VOODOO3 is not set

#
# I2C Hardware Sensors Chip support
#
CONFIG_I2C_SENSOR=m
CONFIG_SENSORS_ADM1021=m
CONFIG_SENSORS_EEPROM=m
CONFIG_SENSORS_IT87=m
CONFIG_SENSORS_LM75=m
CONFIG_SENSORS_LM78=m
CONFIG_SENSORS_LM85=m
CONFIG_SENSORS_VIA686A=m
# CONFIG_SENSORS_W83781D is not set

#
# Linux InfraRed Controller
#
CONFIG_LIRC_ATIUSB=m
# CONFIG_LIRC_SUPPORT is not set

#
# Mice
#
# CONFIG_BUSMOUSE is not set
# CONFIG_QIC02_TAPE is not set

#
# IPMI
#
# CONFIG_IPMI_HANDLER is not set

#
# Watchdog Cards
#
# CONFIG_WATCHDOG is not set
# CONFIG_HW_RANDOM is not set
# CONFIG_NVRAM is not set
CONFIG_RTC=y
# CONFIG_DTLK is not set
# CONFIG_R3964 is not set
# CONFIG_APPLICOM is not set
# CONFIG_SONYPI is not set

#
# Ftape, the floppy tape device driver
#
# CONFIG_FTAPE is not set
CONFIG_AGP=m
# CONFIG_AGP_ALI is not set
# CONFIG_AGP_ATI is not set
# CONFIG_AGP_AMD is not set
# CONFIG_AGP_AMD64 is not set
# CONFIG_AGP_INTEL is not set
# CONFIG_AGP_NVIDIA is not set
# CONFIG_AGP_SIS is not set
# CONFIG_AGP_SWORKS is not set
CONFIG_AGP_VIA=m
# CONFIG_DRM is not set
# CONFIG_MWAVE is not set
# CONFIG_RAW_DRIVER is not set
# CONFIG_HANGCHECK_TIMER is not set

#
# Multimedia devices
#
CONFIG_VIDEO_DEV=m

#
# Video For Linux
#

#
# Video Adapters
#
CONFIG_VIDEO_BT848=m
# CONFIG_VIDEO_BWQCAM is not set
# CONFIG_VIDEO_CQCAM is not set
# CONFIG_VIDEO_W9966 is not set
# CONFIG_VIDEO_CPIA is not set
# CONFIG_VIDEO_SAA5249 is not set
# CONFIG_TUNER_3036 is not set
# CONFIG_VIDEO_STRADIS is not set
# CONFIG_VIDEO_ZORAN is not set
# CONFIG_VIDEO_SAA7134 is not set
# CONFIG_VIDEO_MXB is not set
# CONFIG_VIDEO_DPC is not set
# CONFIG_VIDEO_HEXIUM_ORION is not set
# CONFIG_VIDEO_HEXIUM_GEMINI is not set

#
# Radio Adapters
#
# CONFIG_RADIO_GEMTEK_PCI is not set
# CONFIG_RADIO_MAXIRADIO is not set
# CONFIG_RADIO_MAESTRO is not set

#
# Digital Video Broadcasting Devices
#
# CONFIG_DVB is not set
CONFIG_VIDEO_TUNER=m
CONFIG_VIDEO_BUF=m
CONFIG_VIDEO_BTCX=m
CONFIG_VIDEO_IR=m

#
# Graphics support
#
# CONFIG_FB is not set
# CONFIG_VIDEO_SELECT is not set

#
# Console display driver support
#
CONFIG_VGA_CONSOLE=y
# CONFIG_MDA_CONSOLE is not set
CONFIG_DUMMY_CONSOLE=y

#
# Sound
#
CONFIG_SOUND=m

#
# Advanced Linux Sound Architecture
#
CONFIG_SND=m
CONFIG_SND_SEQUENCER=m
# CONFIG_SND_SEQ_DUMMY is not set
CONFIG_SND_OSSEMUL=y
CONFIG_SND_MIXER_OSS=m
CONFIG_SND_PCM_OSS=m
CONFIG_SND_SEQUENCER_OSS=y
CONFIG_SND_RTCTIMER=m
# CONFIG_SND_VERBOSE_PRINTK is not set
# CONFIG_SND_DEBUG is not set

#
# Generic devices
#
# CONFIG_SND_DUMMY is not set
# CONFIG_SND_VIRMIDI is not set
# CONFIG_SND_MTPAV is not set
# CONFIG_SND_SERIAL_U16550 is not set
# CONFIG_SND_MPU401 is not set

#
# PCI devices
#
# CONFIG_SND_ALI5451 is not set
# CONFIG_SND_AZT3328 is not set
# CONFIG_SND_CS46XX is not set
# CONFIG_SND_CS4281 is not set
# CONFIG_SND_EMU10K1 is not set
# CONFIG_SND_KORG1212 is not set
# CONFIG_SND_NM256 is not set
# CONFIG_SND_RME32 is not set
# CONFIG_SND_RME96 is not set
# CONFIG_SND_RME9652 is not set
# CONFIG_SND_HDSP is not set
# CONFIG_SND_TRIDENT is not set
# CONFIG_SND_YMFPCI is not set
# CONFIG_SND_ALS4000 is not set
# CONFIG_SND_CMIPCI is not set
# CONFIG_SND_ENS1370 is not set
# CONFIG_SND_ENS1371 is not set
# CONFIG_SND_ES1938 is not set
# CONFIG_SND_ES1968 is not set
# CONFIG_SND_MAESTRO3 is not set
# CONFIG_SND_FM801 is not set
# CONFIG_SND_ICE1712 is not set
# CONFIG_SND_ICE1724 is not set
# CONFIG_SND_INTEL8X0 is not set
# CONFIG_SND_SONICVIBES is not set
CONFIG_SND_VIA82XX=m
# CONFIG_SND_VX222 is not set

#
# ALSA USB devices
#
# CONFIG_SND_USB_AUDIO is not set

#
# Open Sound System
#
# CONFIG_SOUND_PRIME is not set

#
# USB support
#
CONFIG_USB=m
# CONFIG_USB_DEBUG is not set

#
# Miscellaneous USB options
#
CONFIG_USB_DEVICEFS=y
CONFIG_USB_BANDWIDTH=y
# CONFIG_USB_DYNAMIC_MINORS is not set

#
# USB Host Controller Drivers
#
CONFIG_USB_EHCI_HCD=m
# CONFIG_USB_OHCI_HCD is not set
CONFIG_USB_UHCI_HCD=m

#
# USB Device Class drivers
#
# CONFIG_USB_AUDIO is not set
# CONFIG_USB_BLUETOOTH_TTY is not set
# CONFIG_USB_MIDI is not set
# CONFIG_USB_ACM is not set
# CONFIG_USB_PRINTER is not set

#
# SCSI support is needed for USB Storage
#
# CONFIG_USB_STORAGE is not set

#
# USB Human Interface Devices (HID)
#
# CONFIG_USB_HID is not set

#
# USB HID Boot Protocol drivers
#
# CONFIG_USB_KBD is not set
# CONFIG_USB_MOUSE is not set
# CONFIG_USB_AIPTEK is not set
# CONFIG_USB_WACOM is not set
# CONFIG_USB_KBTAB is not set
# CONFIG_USB_POWERMATE is not set
# CONFIG_USB_XPAD is not set

#
# USB Imaging devices
#
# CONFIG_USB_MDC800 is not set
# CONFIG_USB_SCANNER is not set

#
# USB Multimedia devices
#
# CONFIG_USB_DABUSB is not set
# CONFIG_USB_VICAM is not set
# CONFIG_USB_DSBR is not set
# CONFIG_USB_IBMCAM is not set
# CONFIG_USB_KONICAWC is not set
# CONFIG_USB_OV511 is not set
# CONFIG_USB_PWC is not set
# CONFIG_USB_SE401 is not set
# CONFIG_USB_STV680 is not set

#
# USB Network adaptors
#
# CONFIG_USB_CATC is not set
# CONFIG_USB_KAWETH is not set
# CONFIG_USB_PEGASUS is not set
# CONFIG_USB_RTL8150 is not set
# CONFIG_USB_USBNET is not set

#
# USB port drivers
#
# CONFIG_USB_USS720 is not set

#
# USB Serial Converter support
#
# CONFIG_USB_SERIAL is not set

#
# USB Miscellaneous drivers
#
# CONFIG_USB_TIGL is not set
# CONFIG_USB_AUERSWALD is not set
# CONFIG_USB_RIO500 is not set
# CONFIG_USB_BRLVGER is not set
# CONFIG_USB_LCD is not set
CONFIG_USB_SPEEDTOUCH=m
# CONFIG_USB_TEST is not set
# CONFIG_USB_GADGET is not set

#
# File systems
#
CONFIG_EXT2_FS=m
# CONFIG_EXT2_FS_XATTR is not set
CONFIG_EXT3_FS=m
CONFIG_EXT3_FS_XATTR=y
# CONFIG_EXT3_FS_POSIX_ACL is not set
# CONFIG_EXT3_FS_SECURITY is not set
CONFIG_JBD=m
# CONFIG_JBD_DEBUG is not set
CONFIG_FS_MBCACHE=m
CONFIG_REISERFS_FS=y
# CONFIG_REISERFS_CHECK is not set
# CONFIG_REISERFS_PROC_INFO is not set
# CONFIG_JFS_FS is not set
# CONFIG_XFS_FS is not set
# CONFIG_MINIX_FS is not set
# CONFIG_ROMFS_FS is not set
# CONFIG_QUOTA is not set
# CONFIG_AUTOFS_FS is not set
# CONFIG_AUTOFS4_FS is not set

#
# CD-ROM/DVD Filesystems
#
CONFIG_ISO9660_FS=m
CONFIG_JOLIET=y
CONFIG_ZISOFS=y
CONFIG_ZISOFS_FS=m
# CONFIG_UDF_FS is not set

#
# DOS/FAT/NT Filesystems
#
CONFIG_FAT_FS=m
# CONFIG_MSDOS_FS is not set
CONFIG_VFAT_FS=m
CONFIG_NTFS_FS=m
# CONFIG_NTFS_DEBUG is not set
CONFIG_NTFS_RW=y

#
# Pseudo filesystems
#
CONFIG_PROC_FS=y
CONFIG_PROC_KCORE=y
CONFIG_DEVFS_FS=y
CONFIG_DEVFS_MOUNT=y
# CONFIG_DEVFS_DEBUG is not set
CONFIG_DEVPTS_FS=y
# CONFIG_DEVPTS_FS_XATTR is not set
CONFIG_TMPFS=y
# CONFIG_HUGETLBFS is not set
# CONFIG_HUGETLB_PAGE is not set
CONFIG_RAMFS=y

#
# Miscellaneous filesystems
#
# CONFIG_ADFS_FS is not set
# CONFIG_AFFS_FS is not set
CONFIG_HFS_FS=m
# CONFIG_BEFS_FS is not set
# CONFIG_BFS_FS is not set
# CONFIG_EFS_FS is not set
# CONFIG_CRAMFS is not set
# CONFIG_VXFS_FS is not set
# CONFIG_HPFS_FS is not set
# CONFIG_QNX4FS_FS is not set
# CONFIG_SYSV_FS is not set
# CONFIG_UFS_FS is not set

#
# Network File Systems
#
CONFIG_NFS_FS=m
CONFIG_NFS_V3=y
# CONFIG_NFS_V4 is not set
CONFIG_NFS_DIRECTIO=y
CONFIG_NFSD=m
CONFIG_NFSD_V3=y
# CONFIG_NFSD_V4 is not set
# CONFIG_NFSD_TCP is not set
CONFIG_LOCKD=m
CONFIG_LOCKD_V4=y
CONFIG_EXPORTFS=m
CONFIG_SUNRPC=m
# CONFIG_SUNRPC_GSS is not set
CONFIG_SMB_FS=m
# CONFIG_SMB_NLS_DEFAULT is not set
# CONFIG_CIFS is not set
# CONFIG_NCP_FS is not set
# CONFIG_CODA_FS is not set
# CONFIG_INTERMEZZO_FS is not set
# CONFIG_AFS_FS is not set

#
# Partition Types
#
# CONFIG_PARTITION_ADVANCED is not set
CONFIG_MSDOS_PARTITION=y

#
# Native Language Support
#
CONFIG_NLS=y
CONFIG_NLS_DEFAULT="iso8859-1"
CONFIG_NLS_CODEPAGE_437=m
# CONFIG_NLS_CODEPAGE_737 is not set
# CONFIG_NLS_CODEPAGE_775 is not set
CONFIG_NLS_CODEPAGE_850=m
# CONFIG_NLS_CODEPAGE_852 is not set
# CONFIG_NLS_CODEPAGE_855 is not set
# CONFIG_NLS_CODEPAGE_857 is not set
# CONFIG_NLS_CODEPAGE_860 is not set
# CONFIG_NLS_CODEPAGE_861 is not set
# CONFIG_NLS_CODEPAGE_862 is not set
# CONFIG_NLS_CODEPAGE_863 is not set
# CONFIG_NLS_CODEPAGE_864 is not set
# CONFIG_NLS_CODEPAGE_865 is not set
# CONFIG_NLS_CODEPAGE_866 is not set
# CONFIG_NLS_CODEPAGE_869 is not set
# CONFIG_NLS_CODEPAGE_936 is not set
# CONFIG_NLS_CODEPAGE_950 is not set
# CONFIG_NLS_CODEPAGE_932 is not set
# CONFIG_NLS_CODEPAGE_949 is not set
# CONFIG_NLS_CODEPAGE_874 is not set
# CONFIG_NLS_ISO8859_8 is not set
# CONFIG_NLS_CODEPAGE_1250 is not set
# CONFIG_NLS_CODEPAGE_1251 is not set
CONFIG_NLS_ISO8859_1=m
# CONFIG_NLS_ISO8859_2 is not set
# CONFIG_NLS_ISO8859_3 is not set
# CONFIG_NLS_ISO8859_4 is not set
# CONFIG_NLS_ISO8859_5 is not set
# CONFIG_NLS_ISO8859_6 is not set
# CONFIG_NLS_ISO8859_7 is not set
# CONFIG_NLS_ISO8859_9 is not set
# CONFIG_NLS_ISO8859_13 is not set
# CONFIG_NLS_ISO8859_14 is not set
CONFIG_NLS_ISO8859_15=m
# CONFIG_NLS_KOI8_R is not set
# CONFIG_NLS_KOI8_U is not set
# CONFIG_NLS_UTF8 is not set

#
# Profiling support
#
# CONFIG_PROFILING is not set

#
# Kernel hacking
#
CONFIG_DEBUG_KERNEL=y
# CONFIG_DEBUG_STACKOVERFLOW is not set
# CONFIG_DEBUG_SLAB is not set
# CONFIG_DEBUG_IOVIRT is not set
CONFIG_MAGIC_SYSRQ=y
# CONFIG_DEBUG_SPINLOCK is not set
# CONFIG_DEBUG_PAGEALLOC is not set
# CONFIG_SPINLINE is not set
# CONFIG_DEBUG_INFO is not set
# CONFIG_DEBUG_SPINLOCK_SLEEP is not set
# CONFIG_KGDB is not set
# CONFIG_FRAME_POINTER is not set
CONFIG_X86_EXTRA_IRQS=y
CONFIG_X86_FIND_SMP_CONFIG=y
CONFIG_X86_MPPARSE=y
CONFIG_KMSGDUMP=y
CONFIG_KMSGDUMP_FAT=y
CONFIG_KMSGDUMP_AUTO=y
# CONFIG_KMSGDUMP_SAFE is not set

#
# Security options
#
# CONFIG_SECURITY is not set

#
# Cryptographic options
#
CONFIG_CRYPTO=y
CONFIG_CRYPTO_HMAC=y
CONFIG_CRYPTO_NULL=m
CONFIG_CRYPTO_MD4=m
CONFIG_CRYPTO_MD5=m
CONFIG_CRYPTO_SHA1=m
CONFIG_CRYPTO_SHA256=m
CONFIG_CRYPTO_SHA512=m
CONFIG_CRYPTO_DES=m
CONFIG_CRYPTO_BLOWFISH=m
CONFIG_CRYPTO_TWOFISH=m
CONFIG_CRYPTO_SERPENT=m
CONFIG_CRYPTO_AES=m
CONFIG_CRYPTO_CAST5=m
CONFIG_CRYPTO_CAST6=m
CONFIG_CRYPTO_DEFLATE=m
CONFIG_CRYPTO_TEST=m

#
# Library routines
#
CONFIG_CRC32=y
CONFIG_ZLIB_INFLATE=m
CONFIG_ZLIB_DEFLATE=m
CONFIG_X86_BIOS_REBOOT=y
CONFIG_PC=y

--------------040409010103010804040306
Content-Type: text/plain;
 name="lsmod"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="lsmod"

Module                  Size  Used by
sch_ingress             3012  1 
cls_u32                 6532  7 
sch_sfq                 4480  3 
sch_htb                22208  1 
ip_conntrack_ftp       71092  0 
ipt_MASQUERADE          2816  2 
iptable_mangle          2112  0 
iptable_nat            19500  2 ipt_MASQUERADE
ipt_REJECT              5312  8 
ipt_limit               1856  29 
ipt_state               1472  4 
ip_conntrack           27248  4 ip_conntrack_ftp,ipt_MASQUERADE,iptable_nat,ipt_state
ipt_LOG                 4928  15 
ipt_ULOG                5672  12 
iptable_filter          2176  1 
ip_tables              15616  9 ipt_MASQUERADE,iptable_mangle,iptable_nat,ipt_REJECT,ipt_limit,ipt_state,ipt_LOG,ipt_ULOG,iptable_filter
binfmt_misc             8072  1 
af_packet              17032  2 
snd_seq_oss            32000  0 
snd_seq_midi_event      6272  1 snd_seq_oss
snd_seq                51600  4 snd_seq_oss,snd_seq_midi_event
snd_pcm_oss            48164  0 
snd_mixer_oss          16768  1 snd_pcm_oss
snd_via82xx            21792  0 
snd_pcm                85668  2 snd_pcm_oss,snd_via82xx
snd_timer              21572  2 snd_seq,snd_pcm
snd_ac97_codec         51716  1 snd_via82xx
snd_page_alloc          8964  2 snd_via82xx,snd_pcm
snd_mpu401_uart         6016  1 snd_via82xx
snd_rawmidi            20384  1 snd_mpu401_uart
snd_seq_device          6600  3 snd_seq_oss,snd_seq,snd_rawmidi
snd                    43492  12 snd_seq_oss,snd_seq_midi_event,snd_seq,snd_pcm_oss,snd_mixer_oss,snd_via82xx,snd_pcm,snd_timer,snd_ac97_codec,snd_mpu401_uart,snd_rawmidi,snd_seq_device
soundcore               7168  1 snd
speedtch               12848  1 
clip                   13668  1 
uhci_hcd               29584  0 
ehci_hcd               21764  0 
usbcore                97244  5 speedtch,uhci_hcd,ehci_hcd
isofs                  31544  0 
zlib_inflate           21184  1 isofs
nls_cp437               5376  1 
vfat                   12672  1 
fat                    40512  1 vfat
nls_iso8859_1           3776  2 
ntfs                   96364  1 

--------------040409010103010804040306--

