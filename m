Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313113AbSE1IXJ>; Tue, 28 May 2002 04:23:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313087AbSE1IXJ>; Tue, 28 May 2002 04:23:09 -0400
Received: from natwar.webmailer.de ([192.67.198.70]:1141 "EHLO
	post.webmailer.de") by vger.kernel.org with ESMTP
	id <S313060AbSE1IXI>; Tue, 28 May 2002 04:23:08 -0400
Date: Tue, 28 May 2002 10:16:51 +0200
From: Kristian Peters <kristian.peters@korseby.net>
To: linux-kernel@vger.kernel.org
Subject: 2.4.18 oops
Message-Id: <20020528101651.4443636b.kristian.peters@korseby.net>
X-Mailer: Sylpheed version 0.7.1claws7 (GTK+ 1.2.10; i386-redhat-linux)
X-Operating-System: i686-redhat-linux 2.4.18
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello.

I'm using linux 2.4.18 + preempt + lowlatency and when starting xdos (dosemu) it produces an oops and will be killed.

Here's the output filtered through ksymoops:

ksymoops 2.4.4 on i686 2.4.18.  Options used
     -V (default)
     -k /proc/ksyms (default)
     -l /proc/modules (default)
     -o /lib/modules/2.4.18/ (default)
     -m /boot/System.map-2.4.18 (specified)

invalid operand: 0000
CPU:    0
EIP:    43ec:[zisofs_cleanup+9493/-1072693568]    Not tainted
EIP:    43ec:[<00002655>]    Not tainted
Using defaults from ksymoops -t elf32-i386 -a i386
EFLAGS: 00030282
eax: 00000800   ebx: 00000000   ecx: 00000001   edx: 00000000
esi: 0000b918   edi: 00006861   ebp: 0000e30c   esp: c61e9f24
ds: 0000   es: 0000   ss: 0018
Process xdos (pid: 2325, stackpage=c61e9000)
Stack: 0000e300 00003804 00000008 00002c86 00000000 00000000 00000000 00000000 
       00000003 00000000 00088108 00000000 00100000 00000000 00000000 00000000 
       000000c0 00000000 00001000 00000000 00000000 00000000 00000000 00000000 
Call Trace: [system_call+51/56] 
Call Trace: [<c01070bb>] 
Code:  Bad EIP value.

>>EIP; 00002655 Before first symbol   <=====
Trace; c01070bb <system_call+33/38>

I think that's related to the kernel and not to dosemu.

I have also applied ide.2.4.18-rc1.02152002 in case it matters. Further infos on request, I don't want to spam the list with hardware infos.

Thanks, *Kristian

  :... [snd.science] ...:
 ::                             _o)
 :: http://www.korseby.net      /\\
 :: http://gsmp.sf.net         _\_V
  :.........................:
