Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313060AbSFAPLC>; Sat, 1 Jun 2002 11:11:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315481AbSFAPLB>; Sat, 1 Jun 2002 11:11:01 -0400
Received: from tibet.patternbook.com ([216.254.75.59]:11012 "EHLO
	free.transpect.com") by vger.kernel.org with ESMTP
	id <S313060AbSFAPK6>; Sat, 1 Jun 2002 11:10:58 -0400
Date: Sat, 1 Jun 2002 11:09:28 -0400
From: Whit Blauvelt <whit@transpect.com>
To: linux-kernel@vger.kernel.org
Subject: PROBLEM: Oops in 2.4.19-pre8 - "kernel BUG at page_alloc.c:106!"
Message-ID: <20020601110928.A916@free.transpect.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[1.] One line summary of the problem:

Oops - kernel BUG at page_alloc.c:106!

[2.] Full description of the problem/report:

System did not fully crash (continued to work as gateway for systems behind
it) but most daemons stopped functioning usefully

[3.] Keywords (i.e., modules, networking, kernel):
[4.] Kernel version (from /proc/version):

Linux version 2.4.19-pre8 (root@china.patternbook.com) (gcc version 2.95.3
20010315 (release)) #5 Wed May 22 11:31:22 EDT 2002

[5.] Output of Oops.. message (if applicable) with symbolic information
     resolved (see Documentation/oops-tracing.txt)

ksymoops 2.4.5 on i586 2.4.19-pre8.  Options used
     -V (default)
     -k /proc/ksyms (default)
     -l /proc/modules (default)
     -o /lib/modules/2.4.19-pre8/ (default)
     -m /usr/src/linux/System.map (default)

Warning: You did not tell me where to find symbol information.  I will
assume that the log matches the kernel and modules that are running [YES]
right now and I'll use the default options above for symbol resolution.
If the current kernel and/or modules do not match the log, you can get
more accurate output by telling me the kernel version and where to find
map, modules, ksyms etc.  ksymoops -h explains the options.

Jun  1 05:02:02 china kernel: kernel BUG at page_alloc.c:106! 
Jun  1 05:02:02 china kernel: invalid operand: 0000 
Jun  1 05:02:02 china kernel: CPU:    0 
Jun  1 05:02:02 china kernel: EIP:    0010:[__free_pages_ok+34/752]    Not tainted 
Jun  1 05:02:02 china kernel: EFLAGS: 00010286 
Jun  1 05:02:02 china kernel: eax: c12b1e60   ebx: c12b6b18   ecx: c12b6b18   edx: c14010e0 
Jun  1 05:02:02 china kernel: esi: 0fc9d025   edi: 0000b000   ebp: 00000000   esp: dd557ee0 
Jun  1 05:02:02 china kernel: ds: 0018   es: 0018   ss: 0018 
Jun  1 05:02:02 china kernel: Process sendmail (pid: 32584, stackpage=dd557000) 
Jun  1 05:02:02 china kernel: Stack: c12b6b18 0fc9d025 0000b000 0fc9d025 d38bf31c 0be89045 de645640 c0287ad4  
Jun  1 05:02:02 china kernel:        c102c01c c0287aec 00000213 ffffffff 00002eb6 c0129c85 c012a04b c12b6b18  
Jun  1 05:02:02 china kernel:        c011f6b2 c12b6b18 000ed000 c12b6b18 c011fac9 0fc9d025 c0bff240 de645640  
Jun  1 05:02:02 china kernel: Call Trace: [__free_pages+29/32] [free_page_and_swap_cache+51/56] [__free_pte+98/104] [zap_page_range+433/612] [exit_mmap+182/284]  
Jun  1 05:02:03 china kernel: Code: 0f 0b 6a 00 b3 4d 24 c0 8b 73 08 85 f6 74 08 0f 0b 6c 00 b3  
Using defaults from ksymoops -t elf32-i386 -a i386


>>eax; c12b1e60 <_end+fcfffc/207e219c>
>>ebx; c12b6b18 <_end+fd4cb4/207e219c>
>>ecx; c12b6b18 <_end+fd4cb4/207e219c>
>>edx; c14010e0 <_end+111f27c/207e219c>
>>esi; 0fc9d025 Before first symbol
>>edi; 0000b000 Before first symbol
>>esp; dd557ee0 <_end+1d27607c/207e219c>

Code;  00000000 Before first symbol
00000000 <_EIP>:
Code;  00000000 Before first symbol
   0:   0f 0b                     ud2a   
Code;  00000002 Before first symbol
   2:   6a 00                     push   $0x0
Code;  00000004 Before first symbol
   4:   b3 4d                     mov    $0x4d,%bl
Code;  00000006 Before first symbol
   6:   24 c0                     and    $0xc0,%al
Code;  00000008 Before first symbol
   8:   8b 73 08                  mov    0x8(%ebx),%esi
Code;  0000000b Before first symbol
   b:   85 f6                     test   %esi,%esi
Code;  0000000d Before first symbol
   d:   74 08                     je     17 <_EIP+0x17> 00000017 Before first symbol
Code;  0000000f Before first symbol
   f:   0f 0b                     ud2a   
Code;  00000011 Before first symbol
  11:   6c                        insb   (%dx),%es:(%edi)
Code;  00000012 Before first symbol
  12:   00 b3 00 00 00 00         add    %dh,0x0(%ebx)

Jun  1 05:02:10 china kernel: Unable to handle kernel NULL pointer dereference at virtual address 00000000 
Jun  1 05:02:10 china kernel: c013e5f0 
Jun  1 05:02:10 china kernel: *pde = 00000000 
Jun  1 05:02:10 china kernel: Oops: 0000 
Jun  1 05:02:10 china kernel: CPU:    0 
Jun  1 05:02:10 china kernel: EIP:    0010:[d_lookup+96/256]    Not tainted 
Jun  1 05:02:10 china kernel: EFLAGS: 00010207 
Jun  1 05:02:10 china kernel: eax: dff6c9d0   ebx: fffffff0   ecx: 00000010   edx: 08e341af 
Jun  1 05:02:10 china kernel: esi: 00000000   edi: dd557fa4   ebp: 00000000   esp: dd557f14 
Jun  1 05:02:10 china kernel: ds: 0018   es: 0018   ss: 0018 
Jun  1 05:02:10 china kernel: Process razor-check (pid: 32614, stackpage=dd557000) 
Jun  1 05:02:10 china kernel: Stack: dd557f74 00000000 dd557fa4 dda1b600 dff6c9d0 d2f9701f 08e341af 00000005  
Jun  1 05:02:11 china kernel:        c0136734 ddb2a760 dd557f74 dd557f74 c0136b80 ddb2a760 dd557f74 00000004  
Jun  1 05:02:11 china kernel:        d2f97000 00000000 dd557fa4 00000009 c013654e 00000009 d2f97025 00000000  
Jun  1 05:02:12 china kernel: Call Trace: [cached_lookup+16/84] [link_path_walk+600/2132] [getname+94/156] [path_walk+26/28] [__user_walk+53/80]  
Jun  1 05:02:13 china kernel: Code: 8b 6d 00 8b 54 24 18 39 53 44 75 7c 8b 44 24 24 39 43 0c 75  


>>eax; dff6c9d0 <_end+1fc8ab6c/207e219c>
>>ebx; fffffff0 <END_OF_CODE+1f4db8e9/????>
>>edx; 08e341af Before first symbol
>>edi; dd557fa4 <_end+1d276140/207e219c>
>>esp; dd557f14 <_end+1d2760b0/207e219c>

Code;  00000000 Before first symbol
00000000 <_EIP>:
Code;  00000000 Before first symbol
   0:   8b 6d 00                  mov    0x0(%ebp),%ebp
Code;  00000003 Before first symbol
   3:   8b 54 24 18               mov    0x18(%esp,1),%edx
Code;  00000007 Before first symbol
   7:   39 53 44                  cmp    %edx,0x44(%ebx)
Code;  0000000a Before first symbol
   a:   75 7c                     jne    88 <_EIP+0x88> 00000088 Before first symbol
Code;  0000000c Before first symbol
   c:   8b 44 24 24               mov    0x24(%esp,1),%eax
Code;  00000010 Before first symbol
  10:   39 43 0c                  cmp    %eax,0xc(%ebx)
Code;  00000013 Before first symbol
  13:   75 00                     jne    15 <_EIP+0x15> 00000015 Before first symbol


1 warning issued.  Results may not be reliable. [WARNING NOT PERTINENT]

[6.] A small shell script or example program which triggers the
     problem (if possible)
[7.] Environment
[7.1.] Software (add the output of the ver_linux script here)

Linux china.patternbook.com 2.4.19-pre8 #5 Wed May 22 11:31:22 EDT 2002 i586
unknown
 
Gnu C                  2.95.3
Gnu make               3.79
binutils               2.9.4.0.6
util-linux             2.11m
mount                  2.9o
modutils               2.4.12
e2fsprogs              1.25
pcmcia-cs              3.0.9
PPP                    2.3.11
Linux C Library        2.1.3
Dynamic linker (ldd)   2.1.3
Procps                 2.0.2
Net-tools              1.52
Console-tools          1999.03.02
Sh-utils               1.16
Modules Loaded         ipt_TOS ipt_psd ipt_limit ipt_REJECT ip_nat_ftp
ipt_state ipt_LOG iptable_mangle iptable_nat iptable_filter ip_tables
ip_conntrack_ftp ip_conntrack

[7.2.] Processor information (from /proc/cpuinfo):

processor       : 0
vendor_id       : AuthenticAMD
cpu family      : 5
model           : 8
model name      : AMD-K6(tm) 3D processor
stepping        : 12
cpu MHz         : 451.035
cache size      : 64 KB
fdiv_bug        : no
hlt_bug         : no
f00f_bug        : no
coma_bug        : no
fpu             : yes
fpu_exception   : yes
cpuid level     : 1
wp              : yes
flags           : fpu vme de pse tsc msr mce cx8 pge mmx syscall 3dnow
k6_mtrr
bogomips        : 897.84

[7.3.] Module information (from /proc/modules):   

ipt_TOS                 1016  16 (autoclean)
ipt_psd                42760   8 (autoclean)
ipt_limit                952   1 (autoclean)
ipt_REJECT              2776   2 (autoclean)
ip_nat_ftp              2928   0 (unused)
ipt_state                568 187 (autoclean)
ipt_LOG                 3160   2 (autoclean)
iptable_mangle          2100   1 (autoclean)
iptable_nat            12664   2 (autoclean) [ip_nat_ftp]
iptable_filter          1672   1 (autoclean)
ip_tables              10392  11 [ipt_TOS ipt_psd ipt_limit ipt_REJECT
ipt_state ipt_LOG iptable_mangle iptable_nat iptable_filter]
ip_conntrack_ftp        3168   0 (unused)
ip_conntrack           12860   3 [ip_nat_ftp ipt_state iptable_nat
ip_conntrack_ftp]

[7.4.] Loaded driver and hardware information (/proc/ioports, /proc/iomem)

0000-001f : dma1
0020-003f : pic1
0040-005f : timer
0060-006f : keyboard
0080-008f : dma page reg
00a0-00bf : pic2
00c0-00df : dma2
00f0-00ff : fpu
01f0-01f7 : ide0
02f8-02ff : serial(auto)
03c0-03df : vga+
03f6-03f6 : ide0
03f8-03ff : serial(auto)
0cf8-0cff : PCI conf1
6000-60ff : PCI device 1106:3040
9000-9fff : PCI Bus #01
  9000-907f : PCI device 1039:6326
b400-b40f : PCI device 1106:0571
  b400-b407 : ide0
  b408-b40f : ide1
b800-b87f : PCI device 10b7:9200
  b800-b87f : 00:08.0
bc00-bc7f : PCI device 10b7:9200
  bc00-bc7f : 00:09.0
c000-c0ff : PCI device 1000:000f
  c000-c07f : sym53c8xx

00000000-0009ffff : System RAM
000a0000-000bffff : Video RAM area
000c0000-000c7fff : Video ROM
000c8000-000c9fff : Extension ROM
000f0000-000fffff : System ROM
00100000-1ffeffff : System RAM
  00100000-0023ea64 : Kernel code
  0023ea65-00299613 : Kernel data
1fff0000-1fff07ff : ACPI Non-volatile Storage
1fff0800-1fffffff : ACPI Tables
e0000000-e3ffffff : PCI device 1106:0597
e4000000-e5ffffff : PCI Bus #01
  e5000000-e500ffff : PCI device 1039:6326
e9000000-e97fffff : PCI Bus #01
  e9000000-e97fffff : PCI device 1039:6326
e9800000-e980007f : PCI device 10b7:9200
e9801000-e98010ff : PCI device 1000:000f
e9802000-e9802fff : PCI device 1000:000f
e9803000-e980307f : PCI device 10b7:9200
ffff0000-ffffffff : reserved

[7.5.] PCI information ('lspci -vvv' as root)

[Don't have lspci.]

[7.6.] SCSI information (from /proc/scsi/scsi)

Attached devices: 
Host: scsi0 Channel: 00 Id: 00 Lun: 00
  Vendor: IBM      Model: DORS-32160       Rev: WA6A
  Type:   Direct-Access                    ANSI SCSI revision: 02
Host: scsi0 Channel: 00 Id: 03 Lun: 00
  Vendor: NEC      Model: CD-ROM DRIVE:222 Rev: 3.0i
  Type:   CD-ROM                           ANSI SCSI revision: 02
Host: scsi0 Channel: 00 Id: 04 Lun: 00
  Vendor: SEAGATE  Model: ST39236LW        Rev: 0010
  Type:   Direct-Access                    ANSI SCSI revision: 03

[7.7.] Other information that might be relevant to the problem
       (please look in /proc and include all information that you
       think to be relevant):
[X.] Other notes, patches, fixes, workarounds:

When there's a fix for this, would appreciate an e-mail.

Thanks,
Whit
whit@transpect.com
