Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130440AbRBLVFT>; Mon, 12 Feb 2001 16:05:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130453AbRBLVFJ>; Mon, 12 Feb 2001 16:05:09 -0500
Received: from smtp9.xs4all.nl ([194.109.127.135]:22261 "EHLO smtp9.xs4all.nl")
	by vger.kernel.org with ESMTP id <S130440AbRBLVFG>;
	Mon, 12 Feb 2001 16:05:06 -0500
Date: Mon, 12 Feb 2001 21:02:41 +0000
From: "Roeland Th. Jansen" <roel@grobbebol.xs4all.nl>
To: linux-kernel@vger.kernel.org
Subject: oops 2.4.1 (sound)
Message-ID: <20010212210241.A665@grobbebol.xs4all.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
X-OS: Linux grobbebol 2.4.1 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I was busy with X, sound, bcast2000 and slab :


Feb 12 20:46:57 grobbebol kernel: audio: Buffer error 3 (fe01bf00,16384), (fe00ff00, -16777216)
Feb 12 20:46:58 grobbebol kernel: Unable to handle kernel paging request at virtual address 0000c100
Feb 12 20:46:58 grobbebol kernel:  printing eip:
Feb 12 20:46:58 grobbebol kernel: c0202de8
Feb 12 20:46:58 grobbebol kernel: *pde = 00000000
Feb 12 20:46:58 grobbebol kernel: Oops: 0002
Feb 12 20:46:58 grobbebol kernel: CPU:    1
Feb 12 20:46:58 grobbebol kernel: EIP:    0010:[memparse+6292/6348]
Feb 12 20:46:58 grobbebol kernel: EFLAGS: 00010246
Feb 12 20:46:58 grobbebol kernel: eax: 00000000   ebx: 00000000   ecx: 00004000   edx: 08236408
Feb 12 20:46:58 grobbebol kernel: esi: 08232408   edi: 0000c100   ebp: 00000000   esp: c7b7bee0
Feb 12 20:46:58 grobbebol kernel: ds: 0018   es: 0018   ss: 0018
Feb 12 20:46:58 grobbebol kernel: Process bcast2000 (pid: 12487, stackpage=c7b7b000)
Feb 12 20:46:58 grobbebol kernel: Stack: 00000000 00004000 ff00ff00 08232408 00004000 d0855320 0000c100 08232408
Feb 12 20:46:58 grobbebol kernel:        00004000 d085d108 0000c100 08232408 00004000 00000003 00004000 08232408
Feb 12 20:46:59 grobbebol kernel:        c7b7bf90 0000c100 c02a7900 c15fe350 08232408 d086e568 00004000 00000000
Feb 12 20:46:59 grobbebol kernel: Call Trace: [<ff00ff00>] [ne2k-pci:__insmod_ne2k-pci_S.bss_L96+238208/17926576] [ne2k-pci:__insmodFeb 12 20:46:59 grobbebol kernel: [system_call+51/56] [startup_32+43/203]
Feb 12 20:46:59 grobbebol kernel:
Feb 12 20:46:59 grobbebol kernel: Code: f3 aa 58 59 e9 31 d9 ff ff ba f2 ff ff ff e9 4c d9 ff ff ba

fed into ksymoops :


ksymoops 0.7c on i686 2.4.1.  Options used
     -V (default)
     -k /proc/ksyms (default)
     -l /proc/modules (default)
     -o /lib/modules/2.4.1/ (default)
     -m /usr/src/linux/System.map (default)

Warning: You did not tell me where to find symbol information.  I will
assume that the log matches the kernel and modules that are running
right now and I'll use the default options above for symbol resolution.
If the current kernel and/or modules do not match the log, you can get
more accurate output by telling me the kernel version and where to find
map, modules, ksyms etc.  ksymoops -h explains the options.

Feb 12 20:46:58 grobbebol kernel: Unable to handle kernel paging request at virtual address 0000c100
Feb 12 20:46:58 grobbebol kernel: c0202de8
Feb 12 20:46:58 grobbebol kernel: *pde = 00000000
Feb 12 20:46:58 grobbebol kernel: Oops: 0002
Feb 12 20:46:58 grobbebol kernel: CPU:    1
Feb 12 20:46:58 grobbebol kernel: EIP:    0010:[memparse+6292/6348]
Feb 12 20:46:58 grobbebol kernel: EFLAGS: 00010246
Feb 12 20:46:58 grobbebol kernel: eax: 00000000   ebx: 00000000   ecx: 00004000   edx: 08236408
Feb 12 20:46:58 grobbebol kernel: esi: 08232408   edi: 0000c100   ebp: 00000000   esp: c7b7bee0
Feb 12 20:46:58 grobbebol kernel: ds: 0018   es: 0018   ss: 0018
Feb 12 20:46:58 grobbebol kernel: Process bcast2000 (pid: 12487, stackpage=c7b7b000)
Feb 12 20:46:58 grobbebol kernel: Stack: 00000000 00004000 ff00ff00 08232408 00004000 d0855320 0000c100 08232408 
Feb 12 20:46:58 grobbebol kernel:        00004000 d085d108 0000c100 08232408 00004000 00000003 00004000 08232408 
Feb 12 20:46:59 grobbebol kernel:        c7b7bf90 0000c100 c02a7900 c15fe350 08232408 d086e568 00004000 00000000 
Feb 12 20:46:59 grobbebol kernel: Call Trace: [<ff00ff00>] [ne2k-pci:__insmod_ne2k-pci_S.bss_L96+238208/17926576] [ne2k-pci:__insmod_ne2k-pci_S.bss_L96+270440/17894344] [ne2k-pci:__insmod_ne2k-pci_S.bss_L96+341192/17823592] [ne2k-pci:__insmod_ne2k-pci_S.bss_L96+284014/17880770] [ne2k-pci:__insmod_ne2k-pci_S.bss_L96+254111/17910673] [sys_write+143/196] 
Feb 12 20:46:59 grobbebol kernel: Code: f3 aa 58 59 e9 31 d9 ff ff ba f2 ff ff ff e9 4c d9 ff ff ba 
Using defaults from ksymoops -t elf32-i386 -a i386

Trace; ff00ff00 <END_OF_CODE+2e72cd89/????>
Code;  00000000 Before first symbol
00000000 <_EIP>:
Code;  00000000 Before first symbol
   0:   f3 aa                     repz stos %al,%es:(%edi)
Code;  00000002 Before first symbol
   2:   58                        pop    %eax
Code;  00000003 Before first symbol
   3:   59                        pop    %ecx
Code;  00000004 Before first symbol
   4:   e9 31 d9 ff ff            jmp    ffffd93a <_EIP+0xffffd93a> ffffd93a <END_OF_CODE+2f71a7c3/????>
Code;  00000009 Before first symbol
   9:   ba f2 ff ff ff            mov    $0xfffffff2,%edx
Code;  0000000e Before first symbol
   e:   e9 4c d9 ff ff            jmp    ffffd95f <_EIP+0xffffd95f> ffffd95f <END_OF_CODE+2f71a7e8/????>
Code;  00000013 Before first symbol
  13:   ba 00 00 00 00            mov    $0x0,%edx


1 warning issued.  Results may not be reliable.

hope somebody ca decypher this.

-- 
Grobbebol's Home                   |  Don't give in to spammers.   -o)
http://www.xs4all.nl/~bengel       | Use your real e-mail address   /\
Linux 2.2.16 SMP 2x466MHz / 256 MB |        on Usenet.             _\_v  
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
Please read the FAQ at  http://vger.kernel.org/lkml/
