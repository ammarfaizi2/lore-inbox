Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130517AbRCLRhp>; Mon, 12 Mar 2001 12:37:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130516AbRCLRhg>; Mon, 12 Mar 2001 12:37:36 -0500
Received: from idefix.linkvest.com ([194.209.53.99]:13581 "EHLO
	idefix.linkvest.com") by vger.kernel.org with ESMTP
	id <S130515AbRCLRh0>; Mon, 12 Mar 2001 12:37:26 -0500
Message-ID: <B45465FD9C23D21193E90000F8D0F3DF683A35@mailsrv.linkvest.com>
From: Jean-Eric Cuendet <Jean-Eric.Cuendet@linkvest.com>
To: "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>
Subject: [NFS] Oops in 2.4.2 - please give advice
Date: Mon, 12 Mar 2001 18:36:33 +0100
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2650.21)
List-Help: <mailto:nfs-request@lists.sourceforge.net?subject=help>
List-Subscribe: <http://lists.sourceforge.net/lists/listinfo/nfs>,<mailto:nfs-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <http://lists.sourceforge.net/lists/listinfo/nfs>,<mailto:nfs-request@lists.sourceforge.net?subject=unsubscribe>
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi,
I have this Oops with the following config:
- Stock 2.4.2 (no patch)
- I have LVM volumes (0.9.1b5)
- I have Raid0 + Raid5 volumes (v0.90)
- Filesystems are ext2
- The machine is a PII 733 with SCSI and IDE disks.
- The chipset is a VIA but DMA is disabled (for IDE disks).
Thanks for any help
-jec


ksymoops 2.4.0 on i686 2.4.2-lb5-n3-6.  Options used
     -V (default)
     -k /proc/ksyms (default)
     -l /proc/modules (default)
     -o /lib/modules/2.4.2-lb5-n3-6/ (default)
     -m /boot/System.map-2.4.2-lb5-n3-6 (specified)

Warning (compare_maps): mismatch on symbol partition_name  , ksyms_base says
c02086c0, System.map says c014f200.  Ignoring ksyms_base entry
Mar 12 10:00:02 fatboy kernel: Unable to handle kernel paging request at
virtual address 00b50008
Mar 12 10:00:02 fatboy kernel: c0124407
Mar 12 10:00:02 fatboy kernel: *pde = 00000000
Mar 12 10:00:02 fatboy kernel: Oops: 0000
Mar 12 10:00:02 fatboy kernel: CPU:    0
Mar 12 10:00:02 fatboy kernel: EIP:    0010:[generic_file_readahead+415/708]
Mar 12 10:00:02 fatboy kernel: EFLAGS: 00010206
Mar 12 10:00:02 fatboy kernel: eax: c7fa0000   ebx: 00b50000   ecx: 0000000f
edx: c7fb25e0
Mar 12 10:00:02 fatboy kernel: esi: 0000022b   edi: c2f9e8a0   ebp: c200bea4
esp: c377fef8
Mar 12 10:00:02 fatboy kernel: ds: 0018   es: 0018   ss: 0018
Mar 12 10:00:02 fatboy kernel: Process tar (pid: 20695, stackpage=c377f000)
Mar 12 10:00:02 fatboy kernel: Stack: c10f36a8 00000001 c2f9e8a0 00000600
c119c9e8 00000124 c7fb25e0 0000001f
Mar 12 10:00:02 fatboy kernel:        00000111 00000013 00000020 000000f2
0000022b c0124753 00000001 c2f9e8a0
Mar 12 10:00:02 fatboy kernel:        c200be00 c10f36a8 00002800 0806d9c0
00000000 bffffaac c10f36a8 00000000
Mar 12 10:00:02 fatboy kernel: Call Trace: [do_generic_file_read+551/1412]
[generic_file_read+99/128] [file_read_actor+0/84] [sys_read+142/196]
[system_call+51/56]
Mar 12 10:00:02 fatboy kernel: Code: 39 6b 08 75 f4 8b 74 24 14 39 73 0c 75
eb 53 e8 c9 4e 00 00
Using defaults from ksymoops -t elf32-i386 -a i386

Code;  00000000 Before first symbol
00000000 <_EIP>:
Code;  00000000 Before first symbol
   0:   39 6b 08                  cmp    %ebp,0x8(%ebx)
Code;  00000003 Before first symbol
   3:   75 f4                     jne    fffffff9 <_EIP+0xfffffff9> fffffff9
<END_OF_CODE+37764c3a/???
Code;  00000005 Before first symbol
   5:   8b 74 24 14               mov    0x14(%esp,1),%esi
Code;  00000009 Before first symbol
   9:   39 73 0c                  cmp    %esi,0xc(%ebx)
Code;  0000000c Before first symbol
   c:   75 eb                     jne    fffffff9 <_EIP+0xfffffff9> fffffff9
<END_OF_CODE+37764c3a/???
Code;  0000000e Before first symbol
   e:   53                        push   %ebx
Code;  0000000f Before first symbol
   f:   e8 c9 4e 00 00            call   4edd <_EIP+0x4edd> 00004edd Before
first symbol


1 warning issued.  Results may not be reliable.



_ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ 
Jean-Eric Cuendet
Linkvest SA
Av des Baumettes 19, 1020 Renens Switzerland
Tel +41 21 632 9043  Fax +41 21 632 9090
http://www.linkvest.com  E-mail: jean-eric.cuendet@linkvest.com
_ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ 




_______________________________________________
NFS maillist  -  NFS@lists.sourceforge.net
http://lists.sourceforge.net/lists/listinfo/nfs
