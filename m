Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264035AbTKSMx7 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 19 Nov 2003 07:53:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264038AbTKSMx7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 19 Nov 2003 07:53:59 -0500
Received: from eik.ii.uib.no ([129.177.16.3]:23469 "EHLO mail.ii.uib.no")
	by vger.kernel.org with ESMTP id S264035AbTKSMxz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 19 Nov 2003 07:53:55 -0500
Subject: Re: 2.6.0-test9-mm4 - kernel BUG at arch/i386/mm/fault.c:357!
From: "Ronny V. Vindenes" <s864@ii.uib.no>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: multipart/mixed; boundary="=-wTi4wbiSWS6TYopjQDL2"
Message-Id: <1069246427.5257.12.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 (1.4.5-7) 
Date: Wed, 19 Nov 2003 13:53:47 +0100
X-Spam-Score: 1.9 (+)
X-Scanner: exiscan for exim4 (http://duncanthrax.net/exiscan/) *1AMRqB-0003jS-00*zaeNLX4yleY*
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-wTi4wbiSWS6TYopjQDL2
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

Running the game Enemy Territory triggers this (log is from running it 3
times in a row) every time. Haven't been able to trigger it with any
other programs. Machine is athlon64 running all 32bit.

On a happier note, interactivity problems are gone with the new acpi pm
timer patch.

-- 
Ronny V. Vindenes <s864@ii.uib.no>

--=-wTi4wbiSWS6TYopjQDL2
Content-Disposition: attachment; filename=bug2
Content-Type: text/plain; name=bug2; charset=UTF-8
Content-Transfer-Encoding: 7bit

------------[ cut here ]------------
kernel BUG at arch/i386/mm/fault.c:357!
invalid operand: 0000 [#1]
PREEMPT 
CPU:    0
EIP:    0060:[<c011c509>]    Not tainted VLI
EFLAGS: 00010212
EIP is at do_page_fault+0x389/0x504
eax: 00029400   ebx: f7d42280   ecx: f64bbf40   edx: 00029400
esi: f7d422a0   edi: c1da5e40   ebp: f75fc040   esp: eb0c9f10
ds: 007b   es: 007b   ss: 0068
Process et.x86 (pid: 4509, threadinfo=eb0c8000 task=f75fc040)
Stack: f7d42280 c1da5e40 575364e4 00000001 00000001 575364e4 00000000 0240d793 
       00030002 00001000 eb0c8000 c0000000 e2eb9400 00000000 f89e6868 f780ec80 
       80044121 eb0c9f70 bffef4e4 e2eb9400 f8e325b2 bffef4e4 eb0c9f74 0000000c 
Call Trace:
 [<f89e6868>] snd_pcm_kernel_playback_ioctl+0x38/0x50 [snd_pcm]
 [<f8e325b2>] snd_pcm_oss_get_ptr+0x82/0x1e0 [snd_pcm_oss]
 [<c01727e0>] sys_ioctl+0xe0/0x2c0
 [<c011c180>] do_page_fault+0x0/0x504
 [<c035050f>] error_code+0x2f/0x38

Code: eb a8 8d 85 02 03 00 00 c7 04 24 fa 72 36 c0 89 44 24 04 e8 5a 6c 00 00 f6 84 24 b0 00 00 00 04 0f 84 7c fd ff ff e9 59 fe ff ff <0f> 0b 65 01 12 73 36 c0 8b 94 24 ac 00 00 00 f6 42 32 02 74 1f 
 ------------[ cut here ]------------
kernel BUG at arch/i386/mm/fault.c:357!
invalid operand: 0000 [#2]
PREEMPT 
CPU:    0
EIP:    0060:[<c011c509>]    Not tainted VLI
EFLAGS: 00010212
EIP is at do_page_fault+0x389/0x504
eax: 00008c00   ebx: f1d094c0   ecx: f6d4b180   edx: 00008c00
esi: f1d094e0   edi: e2de0640   ebp: f75fc040   esp: eb0c9f10
ds: 007b   es: 007b   ss: 0068
Process et.x86 (pid: 4518, threadinfo=eb0c8000 task=f75fc040)
Stack: f1d094c0 e2de0640 575348e4 00000001 00000001 575348e4 bffff700 eb0c9f44 
       00030002 f89fa000 eb0c8000 c0000000 dd715000 00000000 f89e6868 f780ec80 
       80044121 eb0c9f70 bffff7d4 dd715000 f8e325b2 bffff7d4 eb0c9f74 0000000c 
Call Trace:
 [<f89e6868>] snd_pcm_kernel_playback_ioctl+0x38/0x50 [snd_pcm]
 [<f8e325b2>] snd_pcm_oss_get_ptr+0x82/0x1e0 [snd_pcm_oss]
 [<c01727e0>] sys_ioctl+0xe0/0x2c0
 [<c011c180>] do_page_fault+0x0/0x504
 [<c035050f>] error_code+0x2f/0x38

Code: eb a8 8d 85 02 03 00 00 c7 04 24 fa 72 36 c0 89 44 24 04 e8 5a 6c 00 00 f6 84 24 b0 00 00 00 04 0f 84 7c fd ff ff e9 59 fe ff ff <0f> 0b 65 01 12 73 36 c0 8b 94 24 ac 00 00 00 f6 42 32 02 74 1f 
 ------------[ cut here ]------------
kernel BUG at arch/i386/mm/fault.c:357!
invalid operand: 0000 [#3]
PREEMPT 
CPU:    0
EIP:    0060:[<c011c509>]    Not tainted VLI
EFLAGS: 00010212
EIP is at do_page_fault+0x389/0x504
eax: 00008a00   ebx: f1d09940   ecx: eee00840   edx: 00008a00
esi: f1d09960   edi: e2e89940   ebp: f75fc040   esp: e57cff10
ds: 007b   es: 007b   ss: 0068
Process et.x86 (pid: 4535, threadinfo=e57ce000 task=f75fc040)
Stack: f1d09940 e2e89940 57533e64 00000001 00000001 57533e64 bffff700 e57cff44 
       00030002 f89fa000 e57ce000 c0000000 e2eb9c00 00000000 f89e6868 f780ec80 
       80044121 e57cff70 bffff7d4 e2eb9c00 f8e325b2 bffff7d4 e57cff74 0000000c 
Call Trace:
 [<f89e6868>] snd_pcm_kernel_playback_ioctl+0x38/0x50 [snd_pcm]
 [<f8e325b2>] snd_pcm_oss_get_ptr+0x82/0x1e0 [snd_pcm_oss]
 [<c01727e0>] sys_ioctl+0xe0/0x2c0
 [<c011c180>] do_page_fault+0x0/0x504
 [<c035050f>] error_code+0x2f/0x38

Code: eb a8 8d 85 02 03 00 00 c7 04 24 fa 72 36 c0 89 44 24 04 e8 5a 6c 00 00 f6 84 24 b0 00 00 00 04 0f 84 7c fd ff ff e9 59 fe ff ff <0f> 0b 65 01 12 73 36 c0 8b 94 24 ac 00 00 00 f6 42 32 02 74 1f 

--=-wTi4wbiSWS6TYopjQDL2--

