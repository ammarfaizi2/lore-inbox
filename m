Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S275552AbRJPJJR>; Tue, 16 Oct 2001 05:09:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S275571AbRJPJJI>; Tue, 16 Oct 2001 05:09:08 -0400
Received: from dvmwest.gt.owl.de ([62.52.24.140]:56070 "EHLO dvmwest.gt.owl.de")
	by vger.kernel.org with ESMTP id <S275552AbRJPJIy>;
	Tue, 16 Oct 2001 05:08:54 -0400
Date: Tue, 16 Oct 2001 11:09:25 +0200
From: Jan-Benedict Glaw <jbglaw@lug-owl.de>
To: linux-kernel@vger.kernel.org
Subject: Oops while inserting sym53c8xx.o
Message-ID: <20011016110925.B27144@lug-owl.de>
Mail-Followup-To: linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.23i
X-Operating-System: Linux mail 2.4.5 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

I received an Oops while inserting the sym53c8xx.o module. Machine is
the famous Tyan Dual-Athlon board, 2x 1G4HZ Athlon, 1GB RAM:

ksymoops 2.4.3 on i686 2.4.13-pre3.  Options used
     -v /boot/vmlinux-2.4.13-pre3--00 (specified)
     -k /proc/ksyms (default)
     -l /proc/modules (default)
     -o /lib/modules/2.4.13-pre3/ (default)
     -m /boot/System.map (specified)

Unable to handle kernel NULL pointer dereference at virtual address 0000000f
f8980d9f
*pde = 00000000
Oops: 0000
CPU:    0
EIP:    0010:[<f8980d9f>]    Not tainted
Using defaults from ksymoops -t elf32-i386 -a i386
EFLAGS: 00010246
eax: 00000002   ebx: f8986654   ecx: 00000200   edx: 00000001
esi: 00000000   edi: 00000000   ebp: f793bbac   esp: f793bb78
ds: 0018   es: 0018   ss: 0018
Process modprobe (pid: 51, stackpage=f793b000)
Stack: 00000000 f791c000 f7df9800 00000000 e8008800 00000010 f7df9800 00010001 
       40100200 00070200 00000000 e8008800 00001000 f791c000 f8980a04 f89867a0 
       f7df9800 f791c000 f89867a0 00000000 00000002 0000e824 f8982fde f793bd58 
Call Trace: [<f8980a04>] [<f89867a0>] [<f89867a0>] [<f8982fde>] [<c01145a7>] 
   [<c01143b0>] [<c012c192>] [<c012c192>] [<c012d450>] [<c012d492>] [<c010765c>] 
   [<c022392e>] [<c01637bc>] [<c01647f5>] [<c0163eb0>] [<c013974b>] [<c0223bca>] 
   [<c0223d46>] [<c012b924>] [<c012ba1f>] [<c012bbf1>] [<c013974b>] [<c0223bca>] 
   [<c0223d46>] [<c012b924>] [<c012ba1f>] [<c01abebe>] [<f89867a0>] [<f89867a0>] 
   [<f897806a>] [<c013974b>] [<f897806a>] [<c01ac9bd>] [<f89867a0>] [<f8982a86>] 
   [<f89867a0>] [<c011b05d>] [<f8978060>] [<c010756b>] 
Code: f6 47 0f 01 74 27 a1 b8 4a 98 f8 8b 15 bc 4a 98 f8 52 50 8b 

>>EIP; f8980d9e <[sym53c8xx]sym53c8xx_pci_init+1ae/520>   <=====
Trace; f8980a04 <[sym53c8xx]sym53c8xx_detect+184/370>
Trace; f89867a0 <[sym53c8xx]driver_template+0/7e>
Trace; f89867a0 <[sym53c8xx]driver_template+0/7e>
Trace; f8982fde <[sym53c8xx].rodata.start+45e/223e>
Trace; c01145a6 <do_page_fault+1f6/550>
Trace; c01143b0 <do_page_fault+0/550>
Trace; c012c192 <__vma_link+62/b0>
Trace; c012c192 <__vma_link+62/b0>
Trace; c012d450 <do_brk+1e0/260>
Trace; c012d492 <do_brk+222/260>
Trace; c010765c <error_code+34/3c>
Trace; c022392e <clear_user+2e/40>
Trace; c01637bc <padzero+1c/20>
Trace; c01647f4 <load_elf_binary+944/aa0>
Trace; c0163eb0 <load_elf_binary+0/aa0>
Trace; c013974a <__alloc_pages+4a/1c0>
Trace; c0223bca <fast_clear_page+a/50>
Trace; c0223d46 <mmx_clear_page+36/40>
Trace; c012b924 <do_anonymous_page+d4/1a0>
Trace; c012ba1e <do_no_page+2e/160>
Trace; c012bbf0 <handle_mm_fault+a0/150>
Trace; c013974a <__alloc_pages+4a/1c0>
Trace; c0223bca <fast_clear_page+a/50>
Trace; c0223d46 <mmx_clear_page+36/40>
Trace; c012b924 <do_anonymous_page+d4/1a0>
Trace; c012ba1e <do_no_page+2e/160>
Trace; c01abebe <scsi_register_host+fe/380>
Trace; f89867a0 <[sym53c8xx]driver_template+0/7e>
Trace; f89867a0 <[sym53c8xx]driver_template+0/7e>
Trace; f897806a <[sym53c8xx]pci_get_base_cookie+a/20>
Trace; c013974a <__alloc_pages+4a/1c0>
Trace; f897806a <[sym53c8xx]pci_get_base_cookie+a/20>
Trace; c01ac9bc <scsi_register_module+2c/60>
Trace; f89867a0 <[sym53c8xx]driver_template+0/7e>
Trace; f8982a86 <[sym53c8xx]init_this_scsi_driver+16/40>
Trace; f89867a0 <[sym53c8xx]driver_template+0/7e>
Trace; c011b05c <sys_init_module+55c/670>
Trace; f8978060 <[sym53c8xx]pci_get_base_cookie+0/20>
Trace; c010756a <system_call+32/38>
Code;  f8980d9e <[sym53c8xx]sym53c8xx_pci_init+1ae/520>
00000000 <_EIP>:
Code;  f8980d9e <[sym53c8xx]sym53c8xx_pci_init+1ae/520>   <=====
   0:   f6 47 0f 01               testb  $0x1,0xf(%edi)   <=====
Code;  f8980da2 <[sym53c8xx]sym53c8xx_pci_init+1b2/520>
   4:   74 27                     je     2d <_EIP+0x2d> f8980dca <[sym53c8xx]sym53c8xx_pci_init+1da/520>
Code;  f8980da4 <[sym53c8xx]sym53c8xx_pci_init+1b4/520>
   6:   a1 b8 4a 98 f8            mov    0xf8984ab8,%eax
Code;  f8980da8 <[sym53c8xx]sym53c8xx_pci_init+1b8/520>
   b:   8b 15 bc 4a 98 f8         mov    0xf8984abc,%edx
Code;  f8980dae <[sym53c8xx]sym53c8xx_pci_init+1be/520>
  11:   52                        push   %edx
Code;  f8980db0 <[sym53c8xx]sym53c8xx_pci_init+1c0/520>
  12:   50                        push   %eax
Code;  f8980db0 <[sym53c8xx]sym53c8xx_pci_init+1c0/520>
  13:   8b 00                     mov    (%eax),%eax


MfG, JBG

-- 
Jan-Benedict Glaw . jbglaw@lug-owl.de . +49-172-7608481
