Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316673AbSGBIJS>; Tue, 2 Jul 2002 04:09:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316674AbSGBIJR>; Tue, 2 Jul 2002 04:09:17 -0400
Received: from natpost.webmailer.de ([192.67.198.65]:41961 "EHLO
	post.webmailer.de") by vger.kernel.org with ESMTP
	id <S316673AbSGBIJR>; Tue, 2 Jul 2002 04:09:17 -0400
Date: Tue, 2 Jul 2002 10:10:13 +0200
From: Kristian Peters <kristian.peters@korseby.net>
To: lkml <linux-kernel@vger.kernel.org>
Subject: 2.4.19-rc1 oops when loading pcihpacpi
Message-Id: <20020702101013.3cb350de.kristian.peters@korseby.net>
X-Mailer: Sylpheed version 0.7.8claws (GTK+ 1.2.10; i386-redhat-linux)
X-Operating-System: i686-redhat-linux 2.4.19-rc1
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello.

I'm getting this oops while trying to load pcihpacpi. I don't think that I have such thing installed on my IBM Thinkpad. But maybe it is of interest of someone of you.

ksymoops 2.4.5 on i686 2.4.19-rc1.  Options used
     -V (default)
     -k /proc/ksyms (default)
     -l /proc/modules (default)
     -o /lib/modules/2.4.19-rc1/ (default)
     -m /boot/System.map (specified)

Unable to handle kernel NULL pointer dereference at virtual address 0000000c
c0189c37
*pde = 00000000
Oops: 0000
CPU:    0
EIP:    0010:[acpi_ns_get_next_node+23/72]    Not tainted
EFLAGS: 00010246
eax: 00000000   ebx: 00000000   ecx: c53b5e88   edx: 00000001
esi: 00000000   edi: 00000000   ebp: 00000000   esp: c53b5e90
ds: 0018   es: 0018   ss: 0018
Process modprobe (pid: 3304, stackpage=c53b5000)
Stack: 00000000 c53b5ec0 c0189cdb 00000000 00000000 00000000 c88a229c c53b5efc 
       ffffffff 00002514 00000001 0601001a 00000010 c0236987 c0236980 c018a50d 
       00000006 ffffffff ffffffff 00000001 c88a229c 00000000 00000000 00000006 
Call Trace: [acpi_ns_walk_namespace+115/392] [pcmcia_core:__insmod_pcmcia_core_S.bss_L32+350364/4255122] [acpi_walk_namespace+137/176] [pcmcia_core:__insmod_pcmcia_core_S.bss_L32+350364/4255122] [pcmcia_core:__insmod_pcmcia_core_S.bss_L32+350768/4254718] 
Code: 8b 40 0c eb 0d 8d 74 26 00 56 e8 ba ff ff ff 83 c4 04 84 db 
Using defaults from ksymoops -t elf32-i386 -a i386


>>ecx; c53b5e88 <_end+50e09d4/854eb4c>
>>esp; c53b5e90 <_end+50e09dc/854eb4c>

Code;  00000000 Before first symbol
00000000 <_EIP>:
Code;  00000000 Before first symbol
   0:   8b 40 0c                  mov    0xc(%eax),%eax
Code;  00000003 Before first symbol
   3:   eb 0d                     jmp    12 <_EIP+0x12> 00000012 Before first symbol
Code;  00000005 Before first symbol
   5:   8d 74 26 00               lea    0x0(%esi,1),%esi
Code;  00000009 Before first symbol
   9:   56                        push   %esi
Code;  0000000a Before first symbol
   a:   e8 ba ff ff ff            call   ffffffc9 <_EIP+0xffffffc9> ffffffc9 <END_OF_CODE+3775cab6/????>
Code;  0000000f Before first symbol
   f:   83 c4 04                  add    $0x4,%esp
Code;  00000012 Before first symbol
  12:   84 db                     test   %bl,%bl

*Kristian

  :... [snd.science] ...:
 ::                             _o)
 :: http://www.korseby.net      /\\
 :: http://gsmp.sf.net         _\_V
  :.........................:
