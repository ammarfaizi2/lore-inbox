Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316677AbSHJIpX>; Sat, 10 Aug 2002 04:45:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316682AbSHJIpX>; Sat, 10 Aug 2002 04:45:23 -0400
Received: from daimi.au.dk ([130.225.16.1]:43947 "EHLO daimi.au.dk")
	by vger.kernel.org with ESMTP id <S316677AbSHJIpW>;
	Sat, 10 Aug 2002 04:45:22 -0400
Message-ID: <3D54D381.793D796C@daimi.au.dk>
Date: Sat, 10 Aug 2002 10:49:05 +0200
From: Kasper Dupont <kasperd@daimi.au.dk>
Organization: daimi.au.dk
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.9-31smp i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Linux-Kernel <linux-kernel@vger.kernel.org>
Subject: [RFC] vm86 bugs in 2.5.30
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I'm trying to port the vm86 bugfixes from 2.4.19 to 2.5.30.
A premature patch is available at:
http://www.daimi.au.dk/~kasperd/linux_kernel/vm86.2.5.30.patch
The second chunk in mark_screen_rdonly had to be applied by
hand, so I'd appreachiate if whoever made that bugfix would
verify I got the patch applied correctly.

I am however currently fighting with another vm86 problem.
I get this oops on 2.5.30:

<4> invalid operand: 0000
<4>CPU:    0
<4>EIP:    0000:[<00000000>]    Not tainted
<4>EFLAGS: 00030282
<4>eax: 00000000   ebx: 00000000   ecx: 00000000   edx: 00000000
<4>esi: 00000000   edi: 00000000   ebp: 00000000   esp: cb5dbf24
<4>ds: 0000   es: 0000   ss: 0018
<4>Stack: 00007c00 00000000 00000000 00000000 00000000 00000000 00000000 00000000 
<4>       00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000 
<4>       00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000 
<4>Call Trace: [<c0108c87>] 
<4>Code:  Bad EIP value.

>>EIP; 00000000 Before first symbol
Trace; c0108c87 <syscall_call+7/b>

It happens during the vm86 system call, but it is not fixed
by any of the changes in vm86.c. Who remember which patch
fixed this problem?

-- 
Kasper Dupont -- der bruger for meget tid på usenet.
For sending spam use mailto:razrep@daimi.au.dk
or mailto:mcxumhvenwblvtl@skrammel.yaboo.dk
