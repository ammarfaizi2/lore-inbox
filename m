Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261191AbSJPRfd>; Wed, 16 Oct 2002 13:35:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261208AbSJPRfc>; Wed, 16 Oct 2002 13:35:32 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:4622 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S261191AbSJPRfZ>;
	Wed, 16 Oct 2002 13:35:25 -0400
Date: Wed, 16 Oct 2002 18:41:22 +0100
From: Matthew Wilcox <willy@debian.org>
To: linux-kernel@vger.kernel.org, dledford@redhat.com
Subject: 2.5.43 oops in adaptec driver
Message-ID: <20021016184122.J15163@parcelfarce.linux.theplanet.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


SCSI subsystem driver Revision: 1.00
(scsi0) <Adaptec AIC-7899 Ultra 160/m SCSI host adapter> found at PCI 2/1/0
(scsi0) Wide Channel A, SCSI ID=7, 32/255 SCBs
(scsi0) Downloading sequencer code... 396 instructions downloaded
(scsi1) <Adaptec AIC-7899 Ultra 160/m SCSI host adapter> found at PCI 2/1/1
(scsi1) Wide Channel B, SCSI ID=7, 32/255 SCBs
(scsi1) Downloading sequencer code... 396 instructions downloaded
scsi0 : Adaptec AHA274x/284x/294x (EISA/VLB/PCI-Fast SCSI) 5.2.5/5.2.0
       <Adaptec AIC-7899 Ultra 160/m SCSI host adapter>
scsi1 : Adaptec AHA274x/284x/294x (EISA/VLB/PCI-Fast SCSI) 5.2.5/5.2.0
       <Adaptec AIC-7899 Ultra 160/m SCSI host adapter>
  Vendor:           Model:                   Rev:     
  Type:   Direct-Access                      ANSI SCSI revision: 00
scsi_eh_offline_sdevs: Device offlined - not ready or command retry failed after error recovery: host 0 channel 0 id 0 lun 0
Unable to handle kernel NULL pointer dereference at virtual address 00000004
 printing eip:
c021723c

ksymoops 2.4.6 on i686 2.4.14.  Options used
     -V (default)
     -k /proc/ksyms (default)
     -l /proc/modules (default)
     -o /lib/modules/2.4.14/ (default)
     -m System.map (specified)

Error (regular_file): read_ksyms stat /proc/ksyms failed
No modules in ksyms, skipping objects
No ksyms, skipping lsmod
Reading Oops report from the terminal
c021723c
*pde = 00104001
Oops: 0002
CPU:    1
EIP:    0060:[<c021723c>]    Not tainted
Using defaults from ksymoops -t elf32-i386 -a i386
EFLAGS: 00010296
eax: 00000000   ebx: f76c4f80   ecx: c3d5b2b0   edx: f76c4fd8
esi: f772f16c   edi: f772f290   ebp: f772fc00   esp: c3dede90
ds: 0068   es: 0068   ss: 0068
Stack: 00000000 f772fc00 c3dedebc c03ede60 c020ddf8 f772fc00 c3dedf28 c03ede60 
       f772c000 f772f800 f772fc00 74736f68 75622f30 742f3073 65677261 6c2f3074 
       00306e75 c020d965 c03ede68 c03ede70 c3dedf28 c03ede60 f772c000 f772f800 
Call Trace: [<c020ddf8>]  [<c020d965>]  [<c020def2>]  [<c020e3cc>]  [<c020e5af>]
  [<c0207ad9>]  [<c0105098>]  [<c0105054>]  [<c0106f61>] 
Code: 89 50 04 89 43 58 89 7a 04 89 96 24 01 00 00 55 56 e8 fe fd 


>>EIP; c021723c <aic7xxx_slave_attach+68/d0>   <=====

Trace; c020ddf8 <scsi_add_lun+384/3e4>
Trace; c020d965 <scsi_probe_lun+c1/1d0>
Trace; c020def2 <scsi_probe_and_add_lun+9a/154>
Trace; c020e3cc <scsi_scan_target+40/70>
Trace; c020e5af <scan_scsis+7b/ac>
Trace; c0207ad9 <scsi_register_host+201/2e8>
Trace; c0105098 <init+44/19c>
Trace; c0105054 <init+0/19c>
Trace; c0106f61 <kernel_thread_helper+5/c>

Code;  c021723c <aic7xxx_slave_attach+68/d0>
00000000 <_EIP>:
Code;  c021723c <aic7xxx_slave_attach+68/d0>   <=====
   0:   89 50 04                  mov    %edx,0x4(%eax)   <=====
Code;  c021723f <aic7xxx_slave_attach+6b/d0>
   3:   89 43 58                  mov    %eax,0x58(%ebx)
Code;  c0217242 <aic7xxx_slave_attach+6e/d0>
   6:   89 7a 04                  mov    %edi,0x4(%edx)
Code;  c0217245 <aic7xxx_slave_attach+71/d0>
   9:   89 96 24 01 00 00         mov    %edx,0x124(%esi)
Code;  c021724b <aic7xxx_slave_attach+77/d0>
   f:   55                        push   %ebp
Code;  c021724c <aic7xxx_slave_attach+78/d0>
  10:   56                        push   %esi
Code;  c021724d <aic7xxx_slave_attach+79/d0>
  11:   e8 fe fd 00 00            call   fe14 <_EIP+0xfe14> c0227050 <idescsi_qu
eue+350/580>

 <0>Kernel panic: Attempted to kill init!

1 error issued.  Results may not be reliable.

-- 
Revolutions do not require corporate support.
