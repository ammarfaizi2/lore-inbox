Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280307AbRK1TUJ>; Wed, 28 Nov 2001 14:20:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280257AbRK1TUF>; Wed, 28 Nov 2001 14:20:05 -0500
Received: from ns.ithnet.com ([217.64.64.10]:53770 "HELO heather.ithnet.com")
	by vger.kernel.org with SMTP id <S280084AbRK1TSU>;
	Wed, 28 Nov 2001 14:18:20 -0500
Date: Wed, 28 Nov 2001 20:18:14 +0100
From: Stephan von Krawczynski <skraw@ithnet.com>
To: linux-kernel <linux-kernel@vger.kernel.org>
Subject: shutdown problem
Message-Id: <20011128201814.180c6986.skraw@ithnet.com>
Organization: ith Kommunikationstechnik GmbH
X-Mailer: Sylpheed version 0.6.5 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello all,

It noticed the following while shuting down a SMP system. Since it happened
twice, maybe anybody can tell me what this means. I see it only during shutdown
phase, never during "normal" run. This is kernel 2.4.16-pre1.

Nov 25 14:47:31 admin kdm[664]: Unknown session exit code 2816 from process 707
Nov 25 14:47:31 admin kernel: invalid operand: 0000
Nov 25 14:47:31 admin kernel: CPU:    1
Nov 25 14:47:31 admin kernel: EIP:    0010:[__free_pages_ok+75/508]    Not
tainted
Nov 25 14:47:31 admin kernel: EFLAGS: 00210202
Nov 25 14:47:31 admin kernel: eax: 00000040   ebx: c1d520c0   ecx: c1d520c0  
edx: 00000000
Nov 25 14:47:31 admin kernel: esi: 00000000   edi: 00000000   ebp: 00000000  
esp: f6175f24
Nov 25 14:47:31 admin kernel: ds: 0018   es: 0018   ss: 0018
Nov 25 14:47:31 admin kernel: Process kdm (pid: 707, stackpage=f6175000)
Nov 25 14:47:31 admin kernel: Stack: f7b0aee0 00000000 f54830c8 00000000
00210202 f7b0aee0 00000000 f54830c8
Nov 25 14:47:31 admin kernel:        c014d89b c012cea8 c012cec6 c014d8df
f6310920 40484000 00000000 00001000
Nov 25 14:47:31 admin kernel:        f7b0aefc 00000000 00004000 000000c8
f5483000 f55f9000 c014b180 c1e14000
Nov 25 14:47:31 admin kernel: Call Trace: [proc_pid_read_maps+443/524]
[__free_pages+28/32] [free_pages+26/28] [proc_pid_read_maps+511/524]
[pid_maps_read+40/48]
Nov 25 14:47:31 admin kernel:    [sys_read+143/196] [system_call+51/56]
Nov 25 14:47:31 admin kernel:
Nov 25 14:47:31 admin kernel: Code: 0f 0b 8b 43 18 a8 80 74 02 0f 0b b9 00 e0
ff ff 21 e1 80 63


Nov 25 15:33:04 admin kernel: invalid operand: 0000
Nov 25 15:33:04 admin kernel: CPU:    1
Nov 25 15:33:04 admin kernel: EIP:    0010:[__free_pages_ok+75/508]    Not
tainted
Nov 25 15:33:04 admin kernel: EFLAGS: 00210202
Nov 25 15:33:04 admin kernel: eax: 00000040   ebx: c1d48640   ecx: c1d48640  
edx: 00000000
Nov 25 15:33:04 admin kernel: esi: 00000000   edi: 00000000   ebp: dc072980  
esp: f5ebff24
Nov 25 15:33:04 admin kernel: ds: 0018   es: 0018   ss: 0018
Nov 25 15:33:04 admin kernel: Process kdm (pid: 713, stackpage=f5ebf000)
Nov 25 15:33:04 admin kernel: Stack: e6b9e3e0 00000000 f5219400 dc072980
c024ac48 c1040000 00200203 ffffffff
Nov 25 15:33:04 admin kernel:        0001a107 c012cea8 c012cec6 c014d8df
ed07fce0 40484000 00000000 00000400 
Nov 25 15:33:04 admin kernel:        e6b9e3fc 0000000a 00011000 00000400
f5219000 f520f000 c014b180 e8fa2000
Nov 25 15:33:04 admin kdm[669]: Unknown session exit code 2816 from process 713
 
Nov 25 15:33:04 admin kernel: Call Trace: [__free_pages+28/32]
[free_pages+26/28] [proc_pid_read_maps+511/524] [pid_maps_read+40/48]
[sys_read+143/196]
Nov 25 15:33:04 admin kernel:    [system_call+51/56]
Nov 25 15:33:04 admin kernel: 
Nov 25 15:33:04 admin kernel: Code: 0f 0b 8b 43 18 a8 80 74 02 0f 0b b9 00 e0
ff ff 21 e1 80 63

Regards,
Stephan
