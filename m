Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264058AbSIQLZX>; Tue, 17 Sep 2002 07:25:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264060AbSIQLZX>; Tue, 17 Sep 2002 07:25:23 -0400
Received: from employees.nextframe.net ([212.169.100.200]:14586 "EHLO
	sexything.nextframe.net") by vger.kernel.org with ESMTP
	id <S264058AbSIQLZV>; Tue, 17 Sep 2002 07:25:21 -0400
Date: Tue, 17 Sep 2002 13:33:38 +0200
From: Morten Helgesen <morten.helgesen@nextframe.net>
To: linux-kernel@vger.kernel.org
Subject: [OOPS 2.4.19] Unable to handle kernel paging request at virtual address 7ec64585
Message-ID: <20020917133338.B762@sexything>
Reply-To: morten.helgesen@nextframe.net
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.22.1i
X-Editor: VIM - Vi IMproved 6.0
X-Keyboard: PFU Happy Hacking Keyboard
X-Operating-System: Slackware Linux (of course)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hey guys, 

got the following on one of my machines :

Sep 17 11:41:14 sql kernel:  <1>Unable to handle kernel paging request at virtual address 7ec64585
Sep 17 11:41:14 sql kernel: c0141edc
Sep 17 11:41:14 sql kernel: *pde = 00000000
Sep 17 11:41:14 sql kernel: Oops: 0000
Sep 17 11:41:14 sql kernel: CPU:    0
Sep 17 11:41:14 sql kernel: EIP:    0010:[<c0141edc>]    Not tainted
Sep 17 11:41:14 sql kernel: EFLAGS: 00010206
Sep 17 11:41:14 sql kernel: eax: 00000000   ebx: c762f820   ecx: c7e2f830   edx: c7e2f830
Sep 17 11:41:14 sql kernel: esi: 7ec64565   edi: 00000000   ebp: 00000039   esp: cc985d14
Sep 17 11:41:14 sql kernel: ds: 0018   es: 0018   ss: 0018
Sep 17 11:41:14 sql kernel: Process mysqld (pid: 6715, stackpage=cc985000)
Sep 17 11:41:14 sql kernel: Stack: c35d8638 c35d8620 c762f820 c01400b6 c762f820 00000001 000001d2 00000020
Sep 17 11:41:14 sql kernel:        00000006 c014037b 000019b5 c0129f40 00000006 000001d2 00000006 000001d2
Sep 17 11:41:14 sql kernel:        c02794f4 c02794f4 c02794f4 c0129f8f 00000020 cc984000 00000000 00000010
Sep 17 11:41:14 sql kernel: Call Trace:    [<c01400b6>] [<c014037b>] [<c0129f40>] [<c0129f8f>] [<c012a8ac>]
Sep 17 11:41:14 sql kernel:   [<c012ab1c>] [<c012a856>] [<c0121d50>] [<c0121e23>] [<c0121fbe>] [<c0112254>]
Sep 17 11:41:14 sql kernel:   [<c01120f4>] [<c020132c>] [<c01f4fdd>] [<c01190fa>] [<c0109952>] [<c010863c>]
Sep 17 11:41:14 sql kernel:   [<c0124b46>] [<c01246e3>] [<c0124bf6>] [<c0124aec>] [<c0130006>] [<c010854b>]
Sep 17 11:41:14 sql kernel: Code: 8b 7e 20 85 ff 74 0d 8b 47 10 85 c0 74 06 53 ff d0 83 c4 04


>>EIP; c0141edc <iput+2c/19c>   <=====

>>ebx; c762f820 <END_OF_CODE+73393ac/????>
>>ecx; c7e2f830 <END_OF_CODE+7b393bc/????>
>>edx; c7e2f830 <END_OF_CODE+7b393bc/????>
>>esi; 7ec64565 Before first symbol
>>esp; cc985d14 <END_OF_CODE+c68f8a0/????>

Trace; c01400b6 <prune_dcache+c6/138>
Trace; c014037b <shrink_dcache_memory+1b/34>
Trace; c0129f40 <shrink_caches+68/80>
Trace; c0129f8f <try_to_free_pages+37/58>
Trace; c012a8ac <balance_classzone+54/1ac>
Trace; c012ab1c <__alloc_pages+118/178>
Trace; c012a856 <_alloc_pages+16/18>
Trace; c0121d50 <do_anonymous_page+34/d4>
Trace; c0121e23 <do_no_page+33/17c>
Trace; c0121fbe <handle_mm_fault+52/b0>
Trace; c0112254 <do_page_fault+160/490>
Trace; c01120f4 <do_page_fault+0/490>
Trace; c020132c <ip_rcv_finish+0/1a4>
Trace; c01f4fdd <net_rx_action+139/214>
Trace; c01190fa <do_softirq+5a/a4>
Trace; c0109952 <do_IRQ+96/a8>
Trace; c010863c <error_code+34/3c>
Trace; c0124b46 <file_read_actor+5a/8c>
Trace; c01246e3 <do_generic_file_read+1d7/404>
Trace; c0124bf6 <generic_file_read+7e/130>
Trace; c0124aec <file_read_actor+0/8c>
Trace; c0130006 <sys_read+96/f0>
Trace; c010854b <system_call+33/38>

Code;  c0141edc <iput+2c/19c>
00000000 <_EIP>:
Code;  c0141edc <iput+2c/19c>   <=====
   0:   8b 7e 20                  mov    0x20(%esi),%edi   <=====
Code;  c0141edf <iput+2f/19c>
   3:   85 ff                     test   %edi,%edi
Code;  c0141ee1 <iput+31/19c>
   5:   74 0d                     je     14 <_EIP+0x14> c0141ef0 <iput+40/19c>
Code;  c0141ee3 <iput+33/19c>
   7:   8b 47 10                  mov    0x10(%edi),%eax
Code;  c0141ee6 <iput+36/19c>
   a:   85 c0                     test   %eax,%eax
Code;  c0141ee8 <iput+38/19c>
   c:   74 06                     je     14 <_EIP+0x14> c0141ef0 <iput+40/19c>
Code;  c0141eea <iput+3a/19c>
   e:   53                        push   %ebx
Code;  c0141eeb <iput+3b/19c>
   f:   ff d0                     call   *%eax
Code;  c0141eed <iput+3d/19c>
  11:   83 c4 04                  add    $0x4,%esp


[13:39][admin@sql:~]$ uname -a
Linux sql 2.4.19 #1 Wed Aug 14 04:49:14 CEST 2002 i686 unknown

[13:39][admin@sql:~]$ cat /proc/cpuinfo
processor       : 0
vendor_id       : GenuineIntel
cpu family      : 6
model           : 8
model name      : Celeron (Coppermine)
stepping        : 6
cpu MHz         : 601.386
cache size      : 128 KB
fdiv_bug        : no
hlt_bug         : no
f00f_bug        : no
coma_bug        : no
fpu             : yes
fpu_exception   : yes
cpuid level     : 2
wp              : yes
flags           : fpu vme de pse tsc msr pae mce cx8 sep mtrr pge mca cmov pat pse36 mmx fxsr sse
bogomips        : 1199.30


Any ideas ?

== Morten

-- 

"Livet er ikke for nybegynnere" - sitat fra en klok person.

mvh
Morten Helgesen 
UNIX System Administrator & C Developer 
Nextframe AS
admin@nextframe.net / 93445641
http://www.nextframe.net
