Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272434AbTGZHDH (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 26 Jul 2003 03:03:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272435AbTGZHDG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 26 Jul 2003 03:03:06 -0400
Received: from imap.gmx.net ([213.165.64.20]:24486 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S272434AbTGZHC4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 26 Jul 2003 03:02:56 -0400
Date: Sat, 26 Jul 2003 12:48:01 +0530
From: Apurva Mehta <apurva@gmx.net>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Random Oopses on 2.6.0-test1-mm2
Message-ID: <20030726071801.GB1358@home.woodlands>
Mail-Followup-To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="bg08WKrSYDhXBjb5"
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--bg08WKrSYDhXBjb5
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi, 

I get random oopses while using 2.6.0-test1-mm2. I have attached the
oops message and also the ksymoops output. I get the same behaviour
with the 08int patch applied also. The OOPs message attached was
obtained on a 2.6.0-test1-mm2-08int.

Basically, the system just freezes while performing random
tasks. Sometimes it happes just after loading xmms and starting to
play a song. Sometimes I can do that and open my browser and surf a
bit before it freezes. However, every session ends in a
freeze. AFAICS, there is no discernible pattern of usage that leads to
a freeze. It may occur while processing the startup scripts or while
starting X or at any moment during an X session. 

Once the system is frozen, I can still move the mouse or switch to a
virtual console. But I cannot run any programs. If the freeze occurs
in X, I do not see the oops message. So the oops message I have
attached happened just after I typed `startx` at the console after a
fresh reboot.

	- Apurva
--bg08WKrSYDhXBjb5
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="oops.txt"

Unable to handle kernel NULL pointer dereference at virtual address
00000014

print eip:
*pde=00000000
Oops: 0000 [#1]
PREEMPT
CPU : 0
EIP : 0060 " [<c0197ad8>] Not tainted VLI
EFLAGS : 00010202
EIP is at journal_dirty_metadata+0x38/0x210
eax : c7aac000 ebx : 00000000 ecx : 00000000 edx : cb4c0e20
esi : cadfd180 edi : cbd37bc0 ebp : cb070220 esp : c7aade78
ds : 007b es : 007b ss : 0068

Process X (pid: 1322, threadinfo = c7aac000 task = c7b34d60 )

Stack: 
cbd4c660 c7abd148 c0152c6b c015127f cb4c0e20 cb4c0e20 cb070220 00000001
c7abd148 c01896c7 cb070220 cb4c0e20 00001000 c7aadebc 00000001 00000001
00000000 00000030 00000001 00000001 000006c6 00075081 cbd4a3a0 00004000

Call Trace:
[<c0152c6b>] __getblk+0x2b/0x60
[<c015127f>] wake_up_buffer+0xf/0x30
[<c01896c7>] ext3_getblk+0x107/0x2a0
[<c0189893>] ext3_bread+0x33/0xc0
[<c018f707>] ext3_mkdir+0x107/0x2e0
[<c018f600>] ext3_mkdir+0x0/0x2e0
[<c01601aa>] vfs_mkdir+0x6a/0xc0
[<c01602c6>] sys_mkdir+0xc6/0x100
[<c01292bc>] sys_newuname+0x86/0x90
[<c0109359>] sysenter_past_esp+0x52/0x71

Code: 24 2c 8b 75 00 8b 5a 24 f6 45 18 04 8b 3e 0f 84 df 01 00 00 b8 01 00 00 00
85 c0 0f 85 d1 00 00 00 b8 00 e0 ff ff 21 e0 ff 40 14 <8b> 43 14 3b 45 00 0f 84
6c 01 00 b8 00 e0 ff ff 21 e0 ff 40

<6>note: x[1322] exited with preempt_count 1
giving up

--bg08WKrSYDhXBjb5
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="ksymoops.output"

ksymoops 2.4.9 on i686 2.6.0-test1-mm2.  Options used
     -v /plan9/linux_kernel_builds/linux-2.6.0-test1/vmlinux (specified)
     -k /proc/kallsyms (specified)
     -l /sbin/lsmod (specified)
     -o /lib/modules/2.6.0-test1-mm2/ (default)
     -m /boot/System.map-2.6.0-test1-mm2 (specified)

Warning (read_ksyms): no kernel symbols in ksyms, is /proc/kallsyms a valid ksyms file?
No modules in ksyms, skipping objects
No ksyms, skipping lsmod
Unable to handle kernel NULL pointer dereference at virtual address
00000014
Oops: 0000 [#1]
Stack: 
cbd4c660 c7abd148 c0152c6b c015127f cb4c0e20 cb4c0e20 cb070220 00000001
c7abd148 c01896c7 cb070220 cb4c0e20 00001000 c7aadebc 00000001 00000001
00000000 00000030 00000001 00000001 000006c6 00075081 cbd4a3a0 00004000
Call Trace:
[<c0152c6b>] __getblk+0x2b/0x60
[<c015127f>] wake_up_buffer+0xf/0x30
[<c01896c7>] ext3_getblk+0x107/0x2a0
[<c0189893>] ext3_bread+0x33/0xc0
[<c018f707>] ext3_mkdir+0x107/0x2e0
[<c018f600>] ext3_mkdir+0x0/0x2e0
[<c01601aa>] vfs_mkdir+0x6a/0xc0
[<c01602c6>] sys_mkdir+0xc6/0x100
[<c01292bc>] sys_newuname+0x86/0x90
[<c0109359>] sysenter_past_esp+0x52/0x71
Code: 24 2c 8b 75 00 8b 5a 24 f6 45 18 04 8b 3e 0f 84 df 01 00 00 b8 01 00 00 00
Using defaults from ksymoops -t elf32-i386 -a i386


Trace; c0152c6b <__getblk+2b/60>
Trace; c015127f <wake_up_buffer+f/30>
Trace; c01896c7 <ext3_getblk+107/2a0>
Trace; c0189893 <ext3_bread+33/c0>
Trace; c018f707 <ext3_mkdir+107/2e0>
Trace; c018f600 <ext3_mkdir+0/2e0>
Trace; c01601aa <vfs_mkdir+6a/c0>
Trace; c01602c6 <sys_mkdir+c6/100>
Trace; c01292bc <sys_newuname+8c/90>
Trace; c0109359 <sysenter_past_esp+52/71>

Code;  00000000 Before first symbol
00000000 <_EIP>:
Code;  00000000 Before first symbol
   0:   24 2c                     and    $0x2c,%al
Code;  00000002 Before first symbol
   2:   8b 75 00                  mov    0x0(%ebp),%esi
Code;  00000005 Before first symbol
   5:   8b 5a 24                  mov    0x24(%edx),%ebx
Code;  00000008 Before first symbol
   8:   f6 45 18 04               testb  $0x4,0x18(%ebp)
Code;  0000000c Before first symbol
   c:   8b 3e                     mov    (%esi),%edi
Code;  0000000e Before first symbol
   e:   0f 84 df 01 00 00         je     1f3 <_EIP+0x1f3>
Code;  00000014 Before first symbol
  14:   b8 01 00 00 00            mov    $0x1,%eax


1 warning issued.  Results may not be reliable.

--bg08WKrSYDhXBjb5--
