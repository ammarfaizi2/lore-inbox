Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129847AbQLJHop>; Sun, 10 Dec 2000 02:44:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130036AbQLJHog>; Sun, 10 Dec 2000 02:44:36 -0500
Received: from monster.Stanford.EDU ([171.64.38.79]:27149 "EHLO
	monster.stanford.edu") by vger.kernel.org with ESMTP
	id <S129847AbQLJHoV>; Sun, 10 Dec 2000 02:44:21 -0500
Date: Sat, 9 Dec 2000 23:13:53 -0800
From: Peter Blomgren <blomgren@monster.Stanford.EDU>
To: Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: OOPS 2.4.0.test12.pre7
Message-ID: <20001209231353.A7639@monster.Stanford.EDU>
Reply-To: blomgren@math.Stanford.EDU
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2i
Organization: High Latency R Us
X-OS: Linux 2.2.17-1smp
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

FWIW, I got the following oops while trying to play an mpeg stream
from a loop-back mounted iso9660 file system:

ksymoops 0.7c on i586 2.4.0-test12.pre7.1.  Options used
     -V (default)
     -k /proc/ksyms (default)
     -l /proc/modules (default)
     -o /lib/modules/2.4.0-test12.pre7.1/ (default)
     -m /boot/System.map-2.4.0-test12.pre7.1 (specified)

Dec  9 23:02:40 A kernel: invalid operand: 0000 
Dec  9 23:02:40 A kernel: CPU:    0 
Dec  9 23:02:40 A kernel: EIP:    0010:[end_buffer_io_async+199/244] 
Dec  9 23:02:40 A kernel: EFLAGS: 00010082 
Dec  9 23:02:40 A kernel: eax: 0000001c   ebx: c10867e4   ecx: 00000000   edx: 00000006 
Dec  9 23:02:40 A kernel: esi: c1b83120   edi: 00000002   ebp: c1b83168   esp: c1303d9c 
Dec  9 23:02:40 A kernel: ds: 0018   es: 0018   ss: 0018 
Dec  9 23:02:40 A kernel: Process mtvp (pid: 939, stackpage=c1303000) 
Dec  9 23:02:40 A kernel: Stack: c0230472 c023079a 0000033b c1b83120 c17eb910 00000004 00000001 c017b303  
Dec  9 23:02:40 A kernel:        c1b83120 00000001 c17eb910 c10fd260 c17eb910 c17eb910 c325d952 c17eb910  
Dec  9 23:02:40 A kernel:        00000001 c325e9b4 000f4240 00000007 c17eb910 c02ee2f8 00000000 85048bd2  
Dec  9 23:02:40 A kernel: Call Trace: [tvecs+15038/110668] [tvecs+15846/110668] [end_that_request_first+95/184] [<c325d952>] [<c325e9b4>] [__make_request+1609/1724] [generic_make_request+177/272]  
Dec  9 23:02:40 A kernel: Code: 0f 0b 83 c4 0c 8d 73 28 8d 43 2c 39 43 2c 74 15 b9 01 00 00  
Using defaults from ksymoops -t elf32-i386 -a i386

Code;  00000000 Before first symbol
00000000 <_EIP>:
Code;  00000000 Before first symbol
   0:   0f 0b                     ud2a   
Code;  00000002 Before first symbol
   2:   83 c4 0c                  add    $0xc,%esp
Code;  00000005 Before first symbol
   5:   8d 73 28                  lea    0x28(%ebx),%esi
Code;  00000008 Before first symbol
   8:   8d 43 2c                  lea    0x2c(%ebx),%eax
Code;  0000000b Before first symbol
   b:   39 43 2c                  cmp    %eax,0x2c(%ebx)
Code;  0000000e Before first symbol
   e:   74 15                     je     25 <_EIP+0x25> 00000025 Before first symbol
Code;  00000010 Before first symbol
  10:   b9 01 00 00 00            mov    $0x1,%ecx


-- 
\Peter.
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
