Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264945AbTA2HFP>; Wed, 29 Jan 2003 02:05:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264956AbTA2HFP>; Wed, 29 Jan 2003 02:05:15 -0500
Received: from pop.gmx.de ([213.165.64.20]:1806 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id <S264945AbTA2HFK>;
	Wed, 29 Jan 2003 02:05:10 -0500
Date: Wed, 29 Jan 2003 08:14:23 +0100
From: Marc Giger <gigerstyle@gmx.ch>
To: Marc Giger <gigerstyle@gmx.ch>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.4.20 and scp
Message-Id: <20030129081423.00fc2095.gigerstyle@gmx.ch>
In-Reply-To: <20030128213435.0597df5e.gigerstyle@gmx.ch>
References: <20030128213435.0597df5e.gigerstyle@gmx.ch>
X-Mailer: Sylpheed version 0.8.5claws (GTK+ 1.2.10; )
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Sorry I have forgotten to mention two things:

I use a cisco pcmcia aironet card.

Logging info's attached..


First oops:

ksymoops 2.4.8 on i686 2.4.20.  Options used
     -V (default)
     -k /proc/ksyms (default)
     -l /proc/modules (default)
     -o /lib/modules/2.4.20/ (default)
     -m /boot/System.map (specified)

Jan 23 09:11:20 vaio kernel: Warning: kfree_skb passed an skb still on a list (from c0121fca).
Jan 23 09:11:20 vaio kernel: kernel BUG at skbuff.c:315!
Jan 23 09:11:20 vaio kernel: invalid operand: 0000
Jan 23 09:11:20 vaio kernel: CPU:    0
Jan 23 09:11:21 vaio kernel: EIP:    0010:[__kfree_skb+324/352]    Not tainted
Jan 23 09:11:21 vaio kernel: EIP:    0010:[<c026cd54>]    Not tainted
Using defaults from ksymoops -t elf32-i386 -a i386
Jan 23 09:11:21 vaio kernel: EFLAGS: 00010286
Jan 23 09:11:21 vaio kernel: eax: 00000045   ebx: c84e41a0   ecx: cd924000   edx: cd925f7c
Jan 23 09:11:21 vaio kernel: esi: c1339f84   edi: 00000000   ebp: c1338000   esp: c1339f6c
Jan 23 09:11:21 vaio kernel: ds: 0018   es: 0018   ss: 0018
Jan 23 09:11:21 vaio kernel: Process keventd (pid: 2, stackpage=c1339000)
Jan 23 09:11:21 vaio kernel: Stack: c0314840 c0121fca 00000000 c1339f84 c0121fca c84e41a0 c4b202e4 c4b202e4
Jan 23 09:11:21 vaio kernel:        00000000 00000000 c012ac83 c032abd0 c1339fb0 00000000 c1338560 c1338570
Jan 23 09:11:21 vaio kernel:        c1338000 00000001 00000000 cffe5f90 00010000 00000000 00000700 c012ab50
Jan 23 09:11:21 vaio kernel: Call Trace:    [__run_task_queue+90/112] [__run_task_queue+90/112] [context_thread+307/448] [context_thread+0/448] [rest_init+0/64]
Jan 23 09:11:21 vaio kernel: Call Trace:    [<c0121fca>] [<c0121fca>] [<c012ac83>] [<c012ab50>] [<c0105000>]
Jan 23 09:11:21 vaio kernel:   [<c010749e>] [<c012ab50>]
Jan 23 09:11:21 vaio kernel: Code: 0f 0b 3b 01 cf 2d 31 c0 8b 5c 24 14 e9 be fe ff ff 90 8d 76


>>EIP; c026cd54 <__kfree_skb+144/160>   <=====

>>ebx; c84e41a0 <_end+81375d4/10826494>
>>ecx; cd924000 <_end+d577434/10826494>
>>edx; cd925f7c <_end+d5793b0/10826494>
>>esi; c1339f84 <_end+f8d3b8/10826494>
>>ebp; c1338000 <_end+f8b434/10826494>
>>esp; c1339f6c <_end+f8d3a0/10826494>

Trace; c0121fca <__run_task_queue+5a/70>
Trace; c0121fca <__run_task_queue+5a/70>
Trace; c012ac83 <context_thread+133/1c0>
Trace; c012ab50 <context_thread+0/1c0>
Trace; c0105000 <_stext+0/0>
Trace; c010749e <kernel_thread+2e/40>
Trace; c012ab50 <context_thread+0/1c0>

Code;  c026cd54 <__kfree_skb+144/160>
00000000 <_EIP>:
Code;  c026cd54 <__kfree_skb+144/160>   <=====
   0:   0f 0b                     ud2a      <=====
Code;  c026cd56 <__kfree_skb+146/160>
   2:   3b 01                     cmp    (%ecx),%eax
Code;  c026cd58 <__kfree_skb+148/160>
   4:   cf                        iret   
Code;  c026cd59 <__kfree_skb+149/160>
   5:   2d 31 c0 8b 5c            sub    $0x5c8bc031,%eax
Code;  c026cd5e <__kfree_skb+14e/160>
   a:   24 14                     and    $0x14,%al
Code;  c026cd60 <__kfree_skb+150/160>
   c:   e9 be fe ff ff            jmp    fffffecf <_EIP+0xfffffecf>
Code;  c026cd65 <__kfree_skb+155/160>
  11:   90                        nop    
Code;  c026cd66 <__kfree_skb+156/160>
  12:   8d 76 00                  lea    0x0(%esi),%esi


Second oops:

ksymoops 2.4.8 on i686 2.4.20.  Options used
     -V (default)
     -k /proc/ksyms (default)
     -l /proc/modules (default)
     -o /lib/modules/2.4.20/ (default)
     -m /boot/System.map (specified)

Jan 28 10:51:43 vaio kernel: Warning: kfree_skb passed an skb still on a list (from c0121fca).
Jan 28 10:51:43 vaio kernel: kernel BUG at skbuff.c:315!
Jan 28 10:51:43 vaio kernel: invalid operand: 0000
Jan 28 10:51:43 vaio kernel: CPU:    0
Jan 28 10:51:44 vaio kernel: EIP:    0010:[__kfree_skb+324/352]    Not tainted
Jan 28 10:51:44 vaio kernel: EIP:    0010:[<c026cd54>]    Not tainted
Using defaults from ksymoops -t elf32-i386 -a i386
Jan 28 10:51:44 vaio kernel: EFLAGS: 00010286
Jan 28 10:51:44 vaio kernel: eax: 00000045   ebx: c9d18aa0   ecx: cce04000   edx: cce05f7c
Jan 28 10:51:44 vaio kernel: esi: c1339f84   edi: 00000000   ebp: c1338000   esp: c1339f6c
Jan 28 10:51:44 vaio kernel: ds: 0018   es: 0018   ss: 0018
Jan 28 10:51:44 vaio kernel: Process keventd (pid: 2, stackpage=c1339000)
Jan 28 10:51:44 vaio kernel: Stack: c0314840 c0121fca 00000000 c1339f84 c0121fca c9d18aa0 c59242e4 c59242e4
Jan 28 10:51:44 vaio kernel:        00000000 00000000 c012ac83 c032abd0 c1339fb0 00000000 c1338560 c1338570
Jan 28 10:51:44 vaio kernel:        c1338000 00000001 00000000 cffe5f90 00010000 00000000 00000700 c012ab50
Jan 28 10:51:44 vaio kernel: Call Trace:    [__run_task_queue+90/112] [__run_task_queue+90/112] [context_thread+307/448] [context_thread+0/448] [rest_init+0/64]
Jan 28 10:51:44 vaio kernel: Call Trace:    [<c0121fca>] [<c0121fca>] [<c012ac83>] [<c012ab50>] [<c0105000>]
Jan 28 10:51:44 vaio kernel:   [<c010749e>] [<c012ab50>]
Jan 28 10:51:44 vaio kernel: Code: 0f 0b 3b 01 cf 2d 31 c0 8b 5c 24 14 e9 be fe ff ff 90 8d 76


>>EIP; c026cd54 <__kfree_skb+144/160>   <=====

>>ebx; c9d18aa0 <_end+996bed4/10826494>
>>ecx; cce04000 <_end+ca57434/10826494>
>>edx; cce05f7c <_end+ca593b0/10826494>
>>esi; c1339f84 <_end+f8d3b8/10826494>
>>ebp; c1338000 <_end+f8b434/10826494>
>>esp; c1339f6c <_end+f8d3a0/10826494>

Trace; c0121fca <__run_task_queue+5a/70>
Trace; c0121fca <__run_task_queue+5a/70>
Trace; c012ac83 <context_thread+133/1c0>
Trace; c012ab50 <context_thread+0/1c0>
Trace; c0105000 <_stext+0/0>
Trace; c010749e <kernel_thread+2e/40>
Trace; c012ab50 <context_thread+0/1c0>

Code;  c026cd54 <__kfree_skb+144/160>
00000000 <_EIP>:
Code;  c026cd54 <__kfree_skb+144/160>   <=====
   0:   0f 0b                     ud2a      <=====
Code;  c026cd56 <__kfree_skb+146/160>
   2:   3b 01                     cmp    (%ecx),%eax
Code;  c026cd58 <__kfree_skb+148/160>
   4:   cf                        iret   
Code;  c026cd59 <__kfree_skb+149/160>
   5:   2d 31 c0 8b 5c            sub    $0x5c8bc031,%eax
Code;  c026cd5e <__kfree_skb+14e/160>
   a:   24 14                     and    $0x14,%al
Code;  c026cd60 <__kfree_skb+150/160>
   c:   e9 be fe ff ff            jmp    fffffecf <_EIP+0xfffffecf>
Code;  c026cd65 <__kfree_skb+155/160>
  11:   90                        nop    
Code;  c026cd66 <__kfree_skb+156/160>
  12:   8d 76 00                  lea    0x0(%esi),%esi


ver_linux:

If some fields are empty or look unusual you may have an old version.
Compare to the current minimal requirements in Documentation/Changes.
 
Linux vaio.gigerstyle.ch 2.4.20 #6 Fri Nov 29 14:00:10 CET 2002 i686 Pentium III (Coppermine) GenuineIntel GNU/Linux
 
Gnu C                  3.2.1
Gnu make               3.80
util-linux             2.11y
mount                  2.11y
modutils               2.4.22
e2fsprogs              1.32
reiserfsprogs          3.6.4
pcmcia-cs              3.2.1
Linux C Library        2.3.1
Dynamic linker (ldd)   2.3.1
Procps                 2.0.10
Net-tools              1.60
Kbd                    1.06
Sh-utils               2.0.15
Modules Loaded         airo_cs airo ohci1394 ieee1394 neofb 8139too mii snd-pcm-oss snd-mixer-oss snd-ymfpci snd-pcm snd-opl3-lib snd-hwdep snd-timer snd-mpu401-uart snd-rawmidi snd-seq-device snd-ac97-codec snd soundcore parport_pc lp parport af_packet nls_iso8859-1 nls_cp437 vfat fat keybdev mousedev hid input usb-uhci usbcore ds yenta_socket pcmcia_core microcode
