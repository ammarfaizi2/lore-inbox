Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132332AbQKSIrM>; Sun, 19 Nov 2000 03:47:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132349AbQKSIrC>; Sun, 19 Nov 2000 03:47:02 -0500
Received: from adonis.lbl.gov ([128.3.5.144]:55812 "EHLO adonis.lbl.gov")
	by vger.kernel.org with ESMTP id <S132339AbQKSIqv>;
	Sun, 19 Nov 2000 03:46:51 -0500
To: linux-kernel@vger.kernel.org
Subject: Re: [oops] pppd in kernel 2.4.0-test11-pre7
In-Reply-To: <87pujsgz86.fsf@adonis.lbl.gov>
From: Alex Romosan <romosan@adonis.lbl.gov>
Date: 19 Nov 2000 00:16:51 -0800
In-Reply-To: <87pujsgz86.fsf@adonis.lbl.gov> (message from Alex Romosan on 19 Nov 2000 00:09:13 -0800)
Message-ID: <87lmuggyvg.fsf@adonis.lbl.gov>
User-Agent: Gnus/5.0807 (Gnus v5.8.7) Emacs/20.7
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alex Romosan <romosan@adonis.lbl.gov> writes:

> i forgot to bring up eth0 before attempting to connect to my dsl
> provider using ppp over ethernet and i got the following oops:
> 

i hate it when i do this. the correct oops follows:

ksymoops 2.3.4 on i686 2.4.0-test11.  Options used
     -V (default)
     -k /proc/ksyms (default)
     -l /proc/modules (default)
     -o /lib/modules/2.4.0-test11/ (default)
     -m /boot/System.map-2.4.0-test11 (specified)

Nov 18 23:47:34 prospero kernel: Unable to handle kernel NULL pointer dereference at virtual address 00000008
Nov 18 23:47:34 prospero kernel: c0115bcc
Nov 18 23:47:34 prospero kernel: *pde = 00000000
Nov 18 23:47:34 prospero kernel: Oops: 0000
Nov 18 23:47:34 prospero kernel: CPU:    0
Nov 18 23:47:34 prospero kernel: EIP:    0010:[exec_usermodehelper+668/872]
Nov 18 23:47:34 prospero kernel: EFLAGS: 00010246
Nov 18 23:47:34 prospero kernel: eax: c3688a64   ebx: c3936000   ecx: c3fcb3a0   edx: 00000000
Nov 18 23:47:34 prospero kernel: esi: 00000006   edi: 00000000   ebp: c3fcb3a0   esp: c3937fb8
Nov 18 23:47:34 prospero kernel: ds: 0018   es: 0018   ss: 0018
Nov 18 23:47:34 prospero kernel: Process pppd (pid: 21272, stackpage=c3937000)
Nov 18 23:47:34 prospero kernel: Stack: 00000100 c375de1c c375de4c c1918f40 c3fcb3a0 c3fcb3a0 c3f96ca0 c3f96ca0 
Nov 18 23:47:34 prospero kernel:        c3f96ca0 c3f96ca0 c0115ec0 c022c6a0 c375dedc c375dec8 c0108c24 c375de4c 
Nov 18 23:47:34 prospero kernel:        00000078 c375dedc 
Nov 18 23:47:34 prospero kernel: Call Trace: [exec_helper+20/24] [kernel_thread+40/56] 
Nov 18 23:47:34 prospero kernel: Code: 8b 4f 08 39 ca 7d 22 8b 47 14 83 3c 90 00 74 14 89 f0 89 d3 
Using defaults from ksymoops -t elf32-i386 -a i386

Code;  00000000 Before first symbol
00000000 <_EIP>:
Code;  00000000 Before first symbol
   0:   8b 4f 08                  mov    0x8(%edi),%ecx
Code;  00000003 Before first symbol
   3:   39 ca                     cmp    %ecx,%edx
Code;  00000005 Before first symbol
   5:   7d 22                     jge    29 <_EIP+0x29> 00000029 Before first symbol
Code;  00000007 Before first symbol
   7:   8b 47 14                  mov    0x14(%edi),%eax
Code;  0000000a Before first symbol
   a:   83 3c 90 00               cmpl   $0x0,(%eax,%edx,4)
Code;  0000000e Before first symbol
   e:   74 14                     je     24 <_EIP+0x24> 00000024 Before first symbol
Code;  00000010 Before first symbol
  10:   89 f0                     mov    %esi,%eax
Code;  00000012 Before first symbol
  12:   89 d3                     mov    %edx,%ebx
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
