Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S275097AbTHLGmY (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Aug 2003 02:42:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S275125AbTHLGmY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Aug 2003 02:42:24 -0400
Received: from odpn1.odpn.net ([212.40.96.53]:53405 "EHLO odpn1.odpn.net")
	by vger.kernel.org with ESMTP id S275097AbTHLGmV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Aug 2003 02:42:21 -0400
To: linux-kernel@vger.kernel.org
From: "Gabor Z. Papp" <gzp@papp.hu>
Subject: PPPoE Oops with 2.4.22-rc
Organization: Who, me?
User-Agent: tin/1.5.19-20030610 ("Darts") (UNIX) (Linux/2.4.22-rc2-gzp1 (i686))
Message-ID: <5ff3.3f388c4b.4453f@gzp1.gzp.hu>
Date: Tue, 12 Aug 2003 06:42:19 -0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I'm getting Oopses at reboots while pppoe module loaded.

Linux 2.4.22-pre* and -rc*
pppd version 2.4.2b3

The ksymoops output attached, more details at
http://gzp.odpn.net/tmp/linux-pppoe-oops/

ksymoops 2.4.9 on i686 2.4.22-rc2-gzp1.  Options used
     -V (default)
     -k /proc/ksyms (default)
     -l /proc/modules (default)
     -o /lib/modules/2.4.22-rc2-gzp1/ (default)
     -m /usr/src/linux/System.map (default)

Warning: You did not tell me where to find symbol information.  I will
assume that the log matches the kernel and modules that are running
right now and I'll use the default options above for symbol resolution.
If the current kernel and/or modules do not match the log, you can get
more accurate output by telling me the kernel version and where to find
map, modules, ksyms etc.  ksymoops -h explains the options.

Oops: 0002
CPU:    0
EIP:    0010:[<e0ed9bce>]    Tainted: PF
Using defaults from ksymoops -t elf32-i386 -a i386
EFLAGS: 00010286
eax: ddf0ba20   ebx: ddf843c0   ecx: c02747a8   edx: 00000000
esi: ddf0ba20   edi: 00000000   ebp: dd697ef4   esp: dd697ebc
ds: 0018   es: 0018   ss: 0018
Process pppd (pid: 387, stackpage=dd697000)
Stack: 00008229 ddf0ba4a dd697ef4 0000001e dd6a1980 dd697ef4 0000001e bffffd28 
       c01cb4cd dd6a1980 dd697ef4 0000001e 00000002 00000000 00000018 00000000 
       ecc10400 74658784 fc003168 00004015 04090000 dd790000 08086094 00000001 
Call Trace:    [<c01cb4cd>] [<c01495bd>] [<c01cbfc5>] [<c010744f>]
Code: ff 8a e8 00 00 00 0f 94 c0 84 c0 75 24 c7 44 24 08 60 00 00 


>>EIP; e0ed9bce <[pppoe]pppoe_connect+1ce/220>   <=====

>>eax; ddf0ba20 <_end+1dc76630/20610c70>
>>ebx; ddf843c0 <_end+1dceefd0/20610c70>
>>ecx; c02747a8 <irq_stat+8/20>
>>esi; ddf0ba20 <_end+1dc76630/20610c70>
>>ebp; dd697ef4 <_end+1d402b04/20610c70>
>>esp; dd697ebc <_end+1d402acc/20610c70>

Trace; c01cb4cd <sys_connect+7d/b0>
Trace; c01495bd <fcntl_setlk+8d/1d0>
Trace; c01cbfc5 <sys_socketcall+b5/270>
Trace; c010744f <system_call+33/38>

Code;  e0ed9bce <[pppoe]pppoe_connect+1ce/220>
00000000 <_EIP>:
Code;  e0ed9bce <[pppoe]pppoe_connect+1ce/220>   <=====
   0:   ff 8a e8 00 00 00         decl   0xe8(%edx)   <=====
Code;  e0ed9bd4 <[pppoe]pppoe_connect+1d4/220>
   6:   0f 94 c0                  sete   %al
Code;  e0ed9bd7 <[pppoe]pppoe_connect+1d7/220>
   9:   84 c0                     test   %al,%al
Code;  e0ed9bd9 <[pppoe]pppoe_connect+1d9/220>
   b:   75 24                     jne    31 <_EIP+0x31> e0ed9bff <[pppoe]pppoe_connect+1ff/220>
Code;  e0ed9bdb <[pppoe]pppoe_connect+1db/220>
   d:   c7 44 24 08 60 00 00      movl   $0x60,0x8(%esp,1)
Code;  e0ed9be2 <[pppoe]pppoe_connect+1e2/220>
  14:   00 


1 warning issued.  Results may not be reliable.

