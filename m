Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312403AbSDEIsG>; Fri, 5 Apr 2002 03:48:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312410AbSDEIr4>; Fri, 5 Apr 2002 03:47:56 -0500
Received: from [203.199.83.30] ([203.199.83.30]:24546 "HELO
	mailweb18.rediffmail.com") by vger.kernel.org with SMTP
	id <S312403AbSDEIrm>; Fri, 5 Apr 2002 03:47:42 -0500
Date: 5 Apr 2002 08:42:00 -0000
Message-ID: <20020405084200.13305.qmail@mailweb18.rediffmail.com>
MIME-Version: 1.0
From: "Umaid Singh Rajpurohit" <sunadm@rediffmail.com>
Reply-To: "Umaid Singh Rajpurohit" <sunadm@rediffmail.com>
To: linux-kernel@vger.kernel.org
Subject: Kernel BUG at inode.c:384!
Content-type: text/plain;
	format=flowed
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello all,

we are running clearcase,sun grid engine on RedHat Linux 7.1 
(kernel 2.4.2-2smp) on IBM Xseries one U servers that has
two CPU's and we mount all the files to be processed using 
autofs.
Here is uname -a
Linux  2.4.2-2smp #1 SMP Sun Apr 8 20:21:34 EDT 2001 i686 
unknown

I have more then sufficient physical memory and swap space
Here is some swap space detail form top

Mem:  1543868K av,  507684K used, 1036184K free, 0K shrd, 317576K 
buff Swap: 5116576K av,0K used, 5116576K free 33076K  cached


we are running n number of IBM X Series server every one or 
another day I get this error.

   The /var/log/messages says something like:

kernel: kernel BUG at inode.c:384!
linfarm022 kernel: invalid operand: 0000
linfarm022 kernel: CPU:    1
linfarm022 kernel: EIP:    0010:[clear_inode+130/384]
linfarm022 kernel: EIP:    0010:[<c0150402>]
linfarm022 kernel: EFLAGS: 00010286
linfarm022 kernel: eax: 0000001b   ebx: 00000000   ecx:    edx: 
01000000
linfarm022 kernel: esi: f60d9860   edi: c4dd7f68   ebp: c4dd7ee8   
esp: c4dd7e88
linfarm022 kernel: ds: 0018   es: 0018   ss: 0018
linfarm022 kernel: Process tmspath (pid: 20774, 
stackpage=c4dd7000)
linfarm022 kernel: Stack: c0230d7b c0230e9e 00000180 f8a25f80 
c4dd7f68 00005126 f60d9860 f60d9860
linfarm022 kernel:        f8a25f80 c0150ef2 f60d9860 00000000 
c4dd7ee8 f89f880c 00000002 df1a4a00
linfarm022 kernel:        decdbba0 f8a15b1d f60d9860 decdbba0 
c4dd7f38 f89ed9b8 f8a2b764 00000000
linfarm022 kernel: Call Trace: [error_table+60707/64248] 
[error_table+60998/64248] [<f8a25f80>]
[<f8a25f80>] [iput+354/368] [<f89f880c>] [<f8a15b1d>]
Mar 29 10:10:31 linfarm022 kernel: Call Trace: [<c0230d7b>] 
[<c0230e9e>] [<f8a25f80>] [<f8a25f80>] [<c0150ef2>]
[<f89f880c>] [<f8a15b1d>]
Mar 29 10:10:31 linfarm022 kernel:        [<f89ed9b8>] 
[<f8a2b764>] [<f89eda7e>] [<f89ed9c8>] [<f8a1142a>] [<f8a10cb3>] 
[sys_fstat64+49/96] [system_call+51/56]
Mar 29 10:10:31 linfarm022 kernel:        [<f89ed9b8>] 
[<f8a2b764>] [<f89eda7e>] [<f89ed9c8>] [<f8a1142a>] [<f8a10cb3>] 
[<c0143241>] [<c01091cb>]
Mar 29 10:10:31 linfarm022 kernel:
Mar 29 10:10:31 linfarm022 kernel: Code: 0f 0b 8b 86 f8 00 00 00 
83 c4 0c 83 e0 08 74 07 56 e8 98 f9



  I am unable to find any information on it.Can any one help me 
out.If you need any other information please mail I will be very 
thankfull to you all if you can CC me any progress.


Warm Regard
umaid
linux support (TI india)
