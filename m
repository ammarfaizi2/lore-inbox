Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S310769AbSDISwj>; Tue, 9 Apr 2002 14:52:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S310806AbSDISwi>; Tue, 9 Apr 2002 14:52:38 -0400
Received: from out004slb.verizon.net ([206.46.170.16]:58104 "EHLO
	out004.verizon.net") by vger.kernel.org with ESMTP
	id <S310769AbSDISwh>; Tue, 9 Apr 2002 14:52:37 -0400
Date: Tue, 9 Apr 2002 14:54:04 -0400
From: Steve Lion <s.lion@verizon.net>
To: linux-kernel@vger.kernel.org
Subject: 2.4.19-pre5-ac3 + 00_lowlatency-fixes-5 Oops
Message-ID: <20020409145404.A844@verizon.net>
Mail-Followup-To: Steve Lion <s.lion@verizon.net>,
	linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="azLHFNyN32YCQGCU"
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--azLHFNyN32YCQGCU
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hello lkml,
   Oops occured while doing dd if=/dev/hda1 of=/dev/hdb1.  The system was
somewhat usable after the Oops, but then things started to crash.  XMMS went as
soo as it occured.  There was no info in syslog about the programs crashing. 
I've attached the kysmoops output.

-steve
 ps.  Im not anywhere near a kernel hacker, but will try whatever people suggest

--azLHFNyN32YCQGCU
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=ksymoops-output

ksymoops 2.4.3 on i586 2.4.19-pre5-ac3.  Options used
     -V (default)
     -k /proc/ksyms (default)
     -l /proc/modules (default)
     -o /lib/modules/2.4.19-pre5-ac3/ (default)
     -m /boot/System.map-2.4.19-pre5-ac3 (default)

Warning: You did not tell me where to find symbol information.  I will
assume that the log matches the kernel and modules that are running
right now and I'll use the default options above for symbol resolution.
If the current kernel and/or modules do not match the log, you can get
more accurate output by telling me the kernel version and where to find
map, modules, ksyms etc.  ksymoops -h explains the options.

Unable to handle kernel NULL pointer dereference at virtual address 00000030
c018f4c7
*pde = 00000000
Oops: 0002
CPU:    0
EIP:    0010:[__make_request+1399/1552]    Not tainted
EIP:    0010:[<c018f4c7>]    Not tainted
Using defaults from ksymoops -t elf32-i386 -a i386
EFLAGS: 00010003
eax: 00000020   ebx: d7f699e0   ecx: 00000030   edx: 00000000
esi: 00000000   edi: 00000008   ebp: c02974a4   esp: cf445db0
ds: 0018   es: 0018   ss: 0018
Process dd (pid: 1557, stackpage=cf445000)
Stack: 00002000 c02974c4 d7f69560 00000080 00000000 00000000 00000008 0002b2d8 
d7f699e0 00000000 00000000 00000000 d7f56c00 502975ec 00000246 0002b18f 
c02975ec 0002b18f c02975ec 00000000 00000000 00000301 00000008 cf858da0 
Call Trace: [<c018f692>] [<c018f6f6>] [<c01376ac>] [<c0125e40>] [<c0125ef1>] 
[<c013a1d0>] [<c0126621>] [<c0126880>] [<c0126e4d>] [<c0126d40>] [<c0134b08>] 
[<c0109f52>] [<c0109f71>] [<c0108873>] 
Code: c0 01 b8 2c 9e 27 c0 eb 1c 4e 75 0e ff 80 

>>EIP; c018f4c6 <__make_request+576/610>   <=====
Trace; c018f692 <generic_make_request+132/150>
Trace; c018f6f6 <submit_bh+46/60>
Trace; c01376ac <block_read_full_page+22c/240>
Trace; c0125e40 <add_to_page_cache_unique+70/80>
Trace; c0125ef0 <page_cache_read+a0/d0>
Trace; c013a1d0 <blkdev_get_block+0/50>
Trace; c0126620 <generic_file_readahead+110/160>
Trace; c0126880 <do_generic_file_read+210/4f0>
Trace; c0126e4c <generic_file_read+7c/140>
Trace; c0126d40 <file_read_actor+0/90>
Trace; c0134b08 <sys_read+98/e0>
Trace; c0109f52 <do_IRQ+62/a0>
Trace; c0109f70 <do_IRQ+80/a0>
Trace; c0108872 <system_call+32/40>
Code;  c018f4c6 <__make_request+576/610>
00000000 <_EIP>:
Code;  c018f4c6 <__make_request+576/610>   <=====
   0:   c0 01 b8                  rolb   $0xb8,(%ecx)   <=====
Code;  c018f4c8 <__make_request+578/610>
   3:   2c 9e                     sub    $0x9e,%al
Code;  c018f4ca <__make_request+57a/610>
   5:   27                        daa    
Code;  c018f4cc <__make_request+57c/610>
   6:   c0 eb 1c                  shr    $0x1c,%bl
Code;  c018f4ce <__make_request+57e/610>
   9:   4e                        dec    %esi
Code;  c018f4d0 <__make_request+580/610>
   a:   75 0e                     jne    1a <_EIP+0x1a> c018f4e0 <__make_request+590/610>
Code;  c018f4d2 <__make_request+582/610>
   c:   ff 80 00 00 00 00         incl   0x0(%eax)


1 warning issued.  Results may not be reliable.

--azLHFNyN32YCQGCU--
