Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263770AbUFKIGt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263770AbUFKIGt (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 11 Jun 2004 04:06:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262045AbUFKIEG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 11 Jun 2004 04:04:06 -0400
Received: from cicero1.cybercity.dk ([212.242.40.4]:40715 "EHLO
	cicero1.cybercity.dk") by vger.kernel.org with ESMTP
	id S262060AbUFKH17 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 11 Jun 2004 03:27:59 -0400
Subject: Kernel oops
From: tmp <skrald@amossen.dk>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain
Message-Id: <1086938877.1224.3.camel@debian>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Fri, 11 Jun 2004 09:27:57 +0200
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I got the following oops in my kernel 2.6.6. No modules has been
added/removed ahead of the crash:

Jun 10 00:19:59 debian kernel: Oops: 0002 [#1]
Jun 10 00:19:59 debian kernel: CPU:    0
Jun 10 00:19:59 debian kernel: EIP:    0060:[d_instantiate+44/80]    Not
tainted
Jun 10 00:19:59 debian kernel: EFLAGS: 00010286   (2.6.6)
Jun 10 00:19:59 debian kernel: EIP is at d_instantiate+0x2c/0x50
Jun 10 00:19:59 debian kernel: eax: 00814834   ebx: cd814824   ecx:
d8387700   edx: cd814834
Jun 10 00:19:59 debian kernel: esi: d83876dc   edi: d7895f2b   ebp:
00000022   esp: d7895f08
Jun 10 00:19:59 debian kernel: ds: 007b   es: 007b   ss: 0068
Jun 10 00:19:59 debian kernel: Process netspeed_applet (pid: 755,
threadinfo=d7894000 task=d91fc8f0)
Jun 10 00:19:59 debian kernel: Stack: d83876dc ddf093c0 c027d19a
d83876dc cd814824 00001a7e cd814824 3837365b
Jun 10 00:19:59 debian kernel:        cd005d32 ffffff9f d7894000
c027df17 cd814800 00000000 00000001 d7895f24
Jun 10 00:19:59 debian kernel:        00000006 00001a7e 00000002
00000000 080d76c0 00000005 d7894000 c027e0bd
Jun 10 00:19:59 debian kernel: Call Trace:
Jun 10 00:19:59 debian kernel:  [sock_map_fd+170/320]
sock_map_fd+0xaa/0x140
Jun 10 00:19:59 debian kernel:  [__sock_create+167/400]
__sock_create+0xa7/0x190
Jun 10 00:19:59 debian kernel:  [sys_socket+61/96] sys_socket+0x3d/0x60
Jun 10 00:19:59 debian kernel:  [sys_socketcall+104/608]
sys_socketcall+0x68/0x260
Jun 10 00:19:59 debian kernel:  [syscall_call+7/11] syscall_call+0x7/0xb





ksymoops 2.4.9 on i686 2.6.6.  Options used
     -V (default)
     -k /proc/ksyms (default)
     -l /proc/modules (default)
     -o /lib/modules/2.6.6/ (default)
     -m /boot/System.map-2.6.6 (default)

Warning: You did not tell me where to find symbol information.  I will
assume that the log matches the kernel and modules that are running
right now and I'll use the default options above for symbol resolution.
If the current kernel and/or modules do not match the log, you can get
more accurate output by telling me the kernel version and where to find
map, modules, ksyms etc.  ksymoops -h explains the options.

Error (regular_file): read_ksyms stat /proc/ksyms failed
ksymoops: No such file or directory
No modules in ksyms, skipping objects
No ksyms, skipping lsmod

Jun 10 00:19:59 debian kernel: Oops: 0002 [#1]
Jun 10 00:19:59 debian kernel: CPU:    0
Jun 10 00:19:59 debian kernel: EIP:    0060:[d_instantiate+44/80]    Not
tainted
Jun 10 00:19:59 debian kernel: EFLAGS: 00010286   (2.6.6)
Jun 10 00:19:59 debian kernel: eax: 00814834   ebx: cd814824   ecx:
d8387700   edx: cd814834
Jun 10 00:19:59 debian kernel: esi: d83876dc   edi: d7895f2b   ebp:
00000022   esp: d7895f08
Jun 10 00:19:59 debian kernel: ds: 007b   es: 007b   ss: 0068
Jun 10 00:19:59 debian kernel: Stack: d83876dc ddf093c0 c027d19a
d83876dc cd814824 00001a7e cd814824 3837365b
Jun 10 00:19:59 debian kernel:        cd005d32 ffffff9f d7894000
c027df17 cd814800 00000000 00000001 d7895f24
Jun 10 00:19:59 debian kernel:        00000006 00001a7e 00000002
00000000 080d76c0 00000005 d7894000 c027e0bd
Jun 10 00:19:59 debian kernel: Call Trace:
Warning (Oops_read): Code line not seen, dumping what data is available


>>ebx; cd814824 <pg0+d423824/3fc0d000>
>>ecx; d8387700 <pg0+17f96700/3fc0d000>
>>edx; cd814834 <pg0+d423834/3fc0d000>
>>esi; d83876dc <pg0+17f966dc/3fc0d000>
>>edi; d7895f2b <pg0+174a4f2b/3fc0d000>
>>esp; d7895f08 <pg0+174a4f08/3fc0d000>



