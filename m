Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262932AbUGXWwY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262932AbUGXWwY (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 24 Jul 2004 18:52:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263001AbUGXWwY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 24 Jul 2004 18:52:24 -0400
Received: from web53004.mail.yahoo.com ([206.190.39.194]:54625 "HELO
	web53004.mail.yahoo.com") by vger.kernel.org with SMTP
	id S262932AbUGXWwS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 24 Jul 2004 18:52:18 -0400
Message-ID: <20040724225218.72005.qmail@web53004.mail.yahoo.com>
Date: Sat, 24 Jul 2004 15:52:18 -0700 (PDT)
From: Niranjan <niranjan_cs2905@yahoo.com>
Subject: kernel bug at sched.c:564! + linux kernel 2.4.25
To: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
I am working on Linux Kernel 2.4.25. I am trying to
add cryptoapi (cryptoapi-0.1.0) support to wireless
lan driver (linux-wlan-ng-0.2.1.pre14) of prism-based
cards. Cardctl version is 3.1.31.
When I am using "null" as a encryption cipher to check
the coding sequence, everything is working fine. But
when I change it to any other cipher for e.g.
"blowfish" or "rc5", it is giving kernel panic. I have
included Ksymoops extract from the kernel Ooops
reports below.
Can anyone please help me in what can be possible
error by looking at the log ? 
I will greatly appreciate any help in this matter.

Regards,
-Niranjan
Research Assistant, UMASS.


Ksymoops extract from the kernel Ooops reports:
===============================================
ksymoops 2.4.8 on i686 2.4.25.  Options used
     -V (default)
     -k log4_ksyms (specified)
     -l log4_modules (specified)
     -o /lib/modules/2.4.25/ (specified)
     -m /boot/System.map-2.4.25 (specified)

kernel bug at sched.c:564!
CPU: 0
EIP: 0010:[<c0117be6>] Not tainted
Using defaults from ksymoops -t elf32-i386 -a i386
EFLAGS: 00010286
eax: 00000018 ebx: 00000000 ecx: cf244000 edx:
cf245f7c
esi: c6d44000 edi: 00000000 ebp: c6d45af4 esp:
c6d45ac8
ds: 0018 es: 0018 ss: 0018
Process ping (pid:2814, stackpage=c6d45000)
Stack: c02f10aa 00000000 c5d77e00 d08fd0b9 c6d45aec
c6d44000 cb846034 3acbc7bc
       c6d45b18 d08390c6 00000000 c5d77e08 d08fd93b
cd577e00 c6d45b18 00000000
       00000008 00000000 00000001 c6d44000 bcc7cb3a
c698f6d0 00000000 cb846000
Call Trace:   [<d08fd0b9>] [<d08e90c6>] [<d08fd93b>]
[<d08390be>] [<d08e06b6>]
 [<d08e90be>] [<d08fd0b9>] [<d08e90be>] [<d08e5c79>]
[<d08e90be>] [<d08e3240>]
 [<d08e93c0>] [<d08e8394>] [<d08e6826>] [<c0116630>]
[<c028c4e3>] [<c0281f80>]
 [<c02b7975>] [<c02b7365>] [<c02879d6>] [<c028831c>]
[<c027d0de>] [<c029882d>]
 [<c0297ff7>] [<c02b476a>] [<c02b4460>] [<c02b776b>]
[<c02bd7f2>] [<c027a445>]
 [<c027bb57>] [<c012c1af>] [<c012c105>] [<c012c381>]
[<c01167b8>] [<c01bf87a>]
 [<c02bb84d>] [<c027c056>] [<c01075ff>]
Code: 0f 0b 34 02 a2 10 2f c0 e9 b7 fb ff ff 0f 0b 2d
02 a2 10 2f


>>EIP; c0117be6 <schedule+486/4b0>   <=====

>>ecx; cf244000 <_end+ee33c9c/104c1cfc>
>>edx; cf245f7c <_end+ee35c18/104c1cfc>
>>esi; c6d44000 <_end+6933c9c/104c1cfc>
>>ebp; c6d45af4 <_end+6935790/104c1cfc>
>>esp; c6d45ac8 <_end+6935764/104c1cfc>

Trace; d08fd0b9
<[cipher-blowfish]blowfish_encrypt+59/70>
Trace; d08e90c6 <[p80211].rodata.end+233/f2d>
Trace; d08fd93b
<[cipher-blowfish]blowfish_cbc_encrypt+11b/120>
Trace; d08390be <_end+10428d5a/104c1cfc>
Trace; d08e06b6 <[cryptoapi]default_encrypt+36/40>
Trace; d08e90be <[p80211].rodata.end+22b/f2d>
Trace; d08fd0b9
<[cipher-blowfish]blowfish_encrypt+59/70>
Trace; d08e90be <[p80211].rodata.end+22b/f2d>
Trace; d08e5c79 <[p80211]run_cipher+99/160>
Trace; d08e90be <[p80211].rodata.end+22b/f2d>
Trace; d08e3240 <[p80211].text.start+1e0/450>
Trace; d08e93c0 <[p80211].rodata.end+52d/f2d>
Trace; d08e8394 <[p80211]bf_sbox+5d4/10d3>
Trace; d08e6826
<[p80211]p80211knetdev_hard_start_xmit+276/290>
Trace; c0116630 <do_page_fault+0/534>
Trace; c028c4e3 <qdisc_restart+73/1b0>
Trace; c0281f80 <dev_queue_xmit+220/310>
Trace; c02b7975 <arp_send+1d5/250>
Trace; c02b7365 <arp_solicit+a5/140>
Trace; c02879d6 <__neigh_event_send+116/250>
Trace; c028831c <neigh_resolve_output+20c/240>
Trace; c027d0de <sock_alloc_send_pskb+ce/1d0>
Trace; c029882d <ip_finish_output2+dd/120>
Trace; c0297ff7 <ip_build_xmit+2b7/3b0>
Trace; c02b476a <raw_sendmsg+20a/320>
Trace; c02b4460 <raw_getfrag+0/20>
Trace; c02b776b <arp_bind_neighbour+6b/a0>
Trace; c02bd7f2 <inet_sendmsg+42/50>
Trace; c027a445 <sock_sendmsg+75/c0>
Trace; c027bb57 <sys_sendmsg+1b7/210>
Trace; c012c1af <do_no_page+8f/1e0>
Trace; c012c105 <do_anonymous_page+115/130>
Trace; c012c381 <handle_mm_fault+81/120>
Trace; c01167b8 <do_page_fault+188/534>
Trace; c01bf87a <n_tty_ioctl+5a/3e0>
Trace; c02bb84d <inet_fill_ifaddr+5d/2c0>
Trace; c027c056 <sys_socketcall+246/270>
Trace; c01075ff <system_call+33/38>

Code;  c0117be6 <schedule+486/4b0>
00000000 <_EIP>:
Code;  c0117be6 <schedule+486/4b0>   <=====
   0:   0f 0b                     ud2a      <=====
Code;  c0117be8 <schedule+488/4b0>
   2:   34 02                     xor    $0x2,%al
Code;  c0117bea <schedule+48a/4b0>
   4:   a2 10 2f c0 e9            mov   
%al,0xe9c02f10
Code;  c0117bef <schedule+48f/4b0>
   9:   b7 fb                     mov    $0xfb,%bh
Code;  c0117bf1 <schedule+491/4b0>
   b:   ff                        (bad)  
Code;  c0117bf2 <schedule+492/4b0>
   c:   ff 0f                     decl   (%edi)
Code;  c0117bf4 <schedule+494/4b0>
   e:   0b 2d 02 a2 10 2f         or    
0x2f10a202,%ebp

 <0> Kernel Panic: Aieee, killing interrupt handler!


		
__________________________________
Do you Yahoo!?
Yahoo! Mail Address AutoComplete - You start. We finish.
http://promotions.yahoo.com/new_mail 
