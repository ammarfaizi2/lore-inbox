Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261422AbTFBRCw (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 2 Jun 2003 13:02:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263547AbTFBRCv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 2 Jun 2003 13:02:51 -0400
Received: from uldns1.unil.ch ([130.223.8.20]:57487 "EHLO uldns1.unil.ch")
	by vger.kernel.org with ESMTP id S261422AbTFBRCu convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 2 Jun 2003 13:02:50 -0400
Date: Mon, 2 Jun 2003 19:16:13 +0200
From: Gregoire Favre <greg@magma.unil.ch>
To: linux-kernel@vger.kernel.org, linux-dvb@linuxtv.org
Subject: Can't boot since 2.4.21-rc2-ac3 with dvb-kernel
Message-ID: <20030602171613.GA1609@magma.unil.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

with 2.4.21-rc2-ac2 I can boot with dvb-kernel (I have recompiled with
latest CVS from dvb-kernel without problem). But since 2.4.21-rc2-ac3 I
don't manage, for example with 2.4.21-rc6-ac1, I got:

ksymoops -v /usr/src/linux-2.4.21-rc6-ac1/vmlinux -K -L -l /lib/modules/2.4.21-rc6-ac1/ -m /usr/src/linux-2.4.21-rc6-ac1/System.map 2.4.21-rc6-ac1-err 
Warning (multi_opt): you specified both -l and -L.  Using '-l /lib/modules/2.4.21-rc6-ac1/'
ksymoops 2.4.8 on i686 2.4.21-rc2-ac2.  Options used
     -v /usr/src/linux-2.4.21-rc6-ac1/vmlinux (specified)
     -K (specified)
     -l /lib/modules/2.4.21-rc6-ac1/ (specified)
     -o /lib/modules/2.4.21-rc2-ac2/ (default)
     -m /usr/src/linux-2.4.21-rc6-ac1/System.map (specified)

No modules in ksyms, skipping objects
No ksyms, skipping lsmod
Unable to handle kernel NULL pointer dereference at virtual address 00000001
*pde = 34094067
Oops: 0000
CPU:    0
EIP:    0010:[<00000001>]    Not tainted
Using defaults from ksymoops -t elf32-i386 -a i386
EFLAGS: 00013202
eax: f5231880   ebx: f4d24dac   ecx: f4964b80   edx: f58dc780
esi: fac163c0   edi: fac163a0   ebp: 00000000   esp: f4923edc
ds: 0018   es: 0018   ss: 0018
Process X (pid: 1432, stackpage=f4923000)
Stack: fac15279 f5231880 f4964b80 f5162b00 f5162b00 f4922000 c0147252 f5162b00 
       f58d4c40 00000000 00000001 f5231880 f5162b00 f4964b80 f5906c80 f5231880 
       f5906c88 c016bbe9 f5231880 f4964b80 c0146952 00000003 ffffffeb f4964b80 
Call Trace:    [<fac15279>] [<c0147252>] [<c016bbe9>] [<c0146952>] [<c013b663>]
  [<c013b588>] [<c013b923>] [<c0107347>]
Code:  Bad EIP value.


>>EIP; 00000001 Before first symbol   <=====

Trace; fac15279 <END_OF_CODE+3a8239a1/????>
Trace; c0147252 <link_path_walk+4e2/6e0>
Trace; c016bbe9 <devfs_open+149/1b0>
Trace; c0146952 <vfs_permission+82/140>
Trace; c013b663 <dentry_open+d3/1d0>
Trace; c013b588 <filp_open+68/70>
Trace; c013b923 <sys_open+53/a0>
Trace; c0107347 <system_call+33/38>


1 warning issued.  Results may not be reliable.
Exit 1

Without dvb-kernel, the system boot perfectly...
I lauch the dvb at boot with initscript like:

/usr/src/CVS/dvb-kernel/driver.av7110 start

Should I provide some other infos?

	Grégoire
__________________________________________________________________
http://www-ima.unil.ch/greg ICQ:16624071 mailto:greg@magma.unil.ch
