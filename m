Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261342AbSIWNKS>; Mon, 23 Sep 2002 09:10:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261346AbSIWNJ7>; Mon, 23 Sep 2002 09:09:59 -0400
Received: from mail.uklinux.net ([80.84.72.21]:16144 "EHLO s1.uklinux.net")
	by vger.kernel.org with ESMTP id <S261291AbSIWNJc>;
	Mon, 23 Sep 2002 09:09:32 -0400
Envelope-To: <linux-kernel@vger.kernel.org>
From: Mark Hindley <mark@hindley.uklinux.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15758.54657.414420.758939@titan.home.hindley.uklinux.net>
Date: Mon, 23 Sep 2002 09:49:05 +0100 (BST)
To: Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: 2.4.19 Oops
X-Mailer: VM 6.72 under 21.1 (patch 10) "Capitol Reef" XEmacs Lucid
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Got this oops on 2.4.19 today.

Let me know if you need more info.

Mark


--- working directory: /home/mark/
% ksymoops -m /boot/System.map -k /var/log/ksymoops/20020923090002.ksyms -l /var/log/ksymoops/20020923090002.modules  /var/log/syslog
ksymoops 2.3.7 on i586 2.4.19.  Options used
     -V (default)
     -k /var/log/ksymoops/20020923090002.ksyms (specified)
     -l /var/log/ksymoops/20020923090002.modules (specified)
     -o /lib/modules/2.4.19/ (default)
     -m /boot/System.map (specified)

Sep 23 09:33:01 titan kernel: >Unable to handle kernel NULL pointer dereference at virtual address 00000006
Sep 23 09:33:01 titan kernel: c013890f
Sep 23 09:33:01 titan kernel: *pde = 00000000
Sep 23 09:33:01 titan kernel: Oops: 0000
Sep 23 09:33:01 titan kernel: CPU:    0
Sep 23 09:33:02 titan kernel: EIP:    0010:[do_select+251/472]    Not tainted
Sep 23 09:33:02 titan kernel: EFLAGS: 00010202
Sep 23 09:33:02 titan kernel: eax: c34d5700   ebx: 00000000   ecx: 00000006   edx: 00000355
Sep 23 09:33:02 titan kernel: esi: c35d4c40   edi: 00000000   ebp: c335ff6c   esp: c335ff3c
Sep 23 09:33:02 titan kernel: ds: 0018   es: 0018   ss: 0018
Sep 23 09:33:02 titan kernel: Process kdeinit (pid: 1954, stackpage=c335f000)
Sep 23 09:33:02 titan kernel: Stack: 00000001 00000004 c1b46318 00000355 00000010 c335e000 00000050 00000004 
Sep 23 09:33:02 titan kernel:        c335ff64 c1508000 c335ffbc c1508000 c335ffbc c335ffa4 c335ffa0 00000006 
Sep 23 09:33:02 titan kernel:        00000000 c335e000 00000000 40bb1848 00000286 00000025 00000004 00000000 
Sep 23 09:33:02 titan kernel: Call Trace:    [system_call+51/64]
Sep 23 09:33:02 titan kernel: Code: 8b 11 8b 45 e0 23 04 9a 74 11 8b 41 0c 8b 55 e0 47 09 14 98 
Using defaults from ksymoops -t elf32-i386 -a i386

Code;  00000000 Before first symbol
00000000 <_EIP>:
Code;  00000000 Before first symbol
   0:   8b 11                     mov    (%ecx),%edx
Code;  00000002 Before first symbol
   2:   8b 45 e0                  mov    0xffffffe0(%ebp),%eax
Code;  00000005 Before first symbol
   5:   23 04 9a                  and    (%edx,%ebx,4),%eax
Code;  00000008 Before first symbol
   8:   74 11                     je     1b <_EIP+0x1b> 0000001b Before first symbol
Code;  0000000a Before first symbol
   a:   8b 41 0c                  mov    0xc(%ecx),%eax
Code;  0000000d Before first symbol
   d:   8b 55 e0                  mov    0xffffffe0(%ebp),%edx
Code;  00000010 Before first symbol
  10:   47                        inc    %edi
Code;  00000011 Before first symbol
  11:   09 14 98                  or     %edx,(%eax,%ebx,4)


Done 09:46:57
