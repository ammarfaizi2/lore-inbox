Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262190AbUKDMB5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262190AbUKDMB5 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 Nov 2004 07:01:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262189AbUKDL7h
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Nov 2004 06:59:37 -0500
Received: from mail03.agrinet.ch ([81.221.250.52]:15366 "EHLO
	mail03.agrinet.ch") by vger.kernel.org with ESMTP id S262170AbUKDLzW
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Nov 2004 06:55:22 -0500
From: Mischa <mischa@multiply.ch>
Subject: Kernel Panic (probably caused by aic7xxx module) with 2.6.x
Date: Thu, 4 Nov 2004 13:02:41 +0100
User-Agent: KMail/1.7
MIME-Version: 1.0
Content-Disposition: inline
X-Length: 7531
To: linux-kernel@vger.kernel.org
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Message-Id: <200411041302.41104.mischa@multiply.ch>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi 
 
We have several Kernel Panics with the following Hardware: 
 
Hardware Setup: 
 
Dell PowerEdge 2650 
1 Dual Channel RAID Controller 
1 Adaptec 3960D Ultra160 SCSI adapter (onBoard, not used) 
1 Dual Channel Adaptec aic7899 Ultra160 SCSI adapter (used for extarnal 
Tape-Backup) 
 
Kernel Version: 
2.6.8.1 
 
Problems: 
The Kernel Panics appear if you try to use the external tape, but also 
randomly in time. There were also Panics with a less output than the posted 
one. 
 
Temporary Solution: 
If we don't load the aic7xxx kernel module, the server run stable. 
 
The panics also appear with Kernel 2.6.9 and if we deactivated the unused 
onboard SCSI-Controller. 
 
Does anyone else know a solution or has seen problems like this? 
 
Thanks a lot for help. 
 
Mischa 
 
dmesg output: 
-=================================================================== -
 scsi1 : Adaptec AIC7XXX EISA/VLB/PCI SCSI HBA DRIVER, Rev 6.2.36 
         <Adaptec 3960D Ultra160 SCSI adapter> 
         aic7899: Ultra160 Wide Channel A, SCSI Id=7, 32/253 SCBs 
 
 (scsi1:A:3): 10.000MB/s transfers (10.000MHz, offset 32) 
   Vendor: HP        Model: C1537A            Rev: L105 
   Type:   Sequential-Access                  ANSI SCSI revision: 02 
 Attached scsi tape st0 at scsi1, channel 0, id 3, lun 0 
 st0: try direct i/o: yes (alignment 512 B), max page reachable by HBA 1048575 
 Attached scsi generic sg2 at scsi1, channel 0, id 3, lun 0,  type 1 
 scsi2 : Adaptec AIC7XXX EISA/VLB/PCI SCSI HBA DRIVER, Rev 6.2.36 
         <Adaptec 3960D Ultra160 SCSI adapter> 
         aic7899: Ultra160 Wide Channel B, SCSI Id=7, 32/253 SCBs 
 
 scsi3 : Adaptec AIC7XXX EISA/VLB/PCI SCSI HBA DRIVER, Rev 6.2.36 
         <Adaptec aic7899 Ultra160 SCSI adapter> 
         aic7899: Ultra160 Wide Channel A, SCSI Id=7, 32/253 SCBs 
 
 scsi4 : Adaptec AIC7XXX EISA/VLB/PCI SCSI HBA DRIVER, Rev 6.2.36 
         <Adaptec aic7899 Ultra160 SCSI adapter> 
         aic7899: Ultra160 Wide Channel B, SCSI Id=7, 32/253 SCBs 
 
 XFS mounting filesystem dm-18 
 Starting XFS recovery on filesystem: dm-18 (dev: dm-18) 
 Ending XFS recovery on filesystem: dm-18 (dev: dm-18) 
 XFS mounting filesystem dm-8 
 Starting XFS recovery on filesystem: dm-8 (dev: dm-8) 
 Ending XFS recovery on filesystem: dm-8 (dev: dm-8) 
 XFS mounting filesystem dm-6 
 Starting XFS recovery on filesystem: dm-6 (dev: dm-6) 
 Ending XFS recovery on filesystem: dm-6 (dev: dm-6) 
 XFS mounting filesystem dm-10 
 Starting XFS recovery on filesystem: dm-10 (dev: dm-10) 
 Ending XFS recovery on filesystem: dm-10 (dev: dm-10) 
 XFS mounting filesystem dm-14 
 Starting XFS recovery on filesystem: dm-14 (dev: dm-14) 
 Ending XFS recovery on filesystem: dm-14 (dev: dm-14) 
 XFS mounting filesystem dm-2 
 Starting XFS recovery on filesystem: dm-2 (dev: dm-2) 
 Ending XFS recovery on filesystem: dm-2 (dev: dm-2) 
 ISO 9660 Extensions: Microsoft Joliet Level 1 
 ISOFS: changing to secondary root 
 tg3: eth1: Link is up at 100 Mbps, full duplex. 
 tg3: eth1: Flow control is off for TX and off for RX. 
 process `named' is using obsolete setsockopt SO_BSDCOMPAT 
 tg3: eth0: Link is up at 1000 Mbps, full duplex. 
 tg3: eth0: Flow control is on for TX and on for RX. 
 st0: Block limits 1 - 16777215 bytes. 
 Unable to handle kernel paging request at virtual address 6e6962d0 
  printing eip: 
 c0117d8f 
 *pde = 00000000 
 Oops: 0000 [#1] 
 PREEMPT SMP 
 Modules linked in: aic7xxx st 
 CPU:    27 
 EIP:    0060:[<c0117d8f>]    Not tainted 
 EFLAGS: 00010897   (2.6.8.1) 
 EIP is at do_page_fault+0x44/0x56f 
 eax: d0ca4000   ebx: 00000246   ecx: 0000007b   edx: 00000000 
 esi: 00000000   edi: c0117d4b   ebp: 6e696268   esp: d0ca40a8 
 ds: 007b   es: 007b   ss: 0068 
 Process desk[1].txt (pid: -801734524, threadinfo=d0ca3000 task=d0368000) 
 Stack: 0000040d 0000004a fffffffb 0000003b 4d677541 6e6962d0 00000001 
00000001 
        00030001 00000000 73c92b7c 6f4b0010 6e756d6d 74616b69 006e6f69 
4d4d4f4b 
        317e4e55 00000000 040d0000 003a0000 fffb0000 002cffff 75410000 
00014d67 
 Call Trace: 
  [<c0117d4b>] do_page_fault+0x0/0x56f 
  [<c0106b81>] error_code+0x2d/0x38 
  [<c0117d4b>] do_page_fault+0x0/0x56f 
  [<c0117d8f>] do_page_fault+0x44/0x56f 
  [<c0117d4b>] do_page_fault+0x0/0x56f 
  [<c0106b81>] error_code+0x2d/0x38 
  [<c0117d4b>] do_page_fault+0x0/0x56f 
  [<c0117d8f>] do_page_fault+0x44/0x56f 
  [<c0117d4b>] do_page_fault+0x0/0x56f 
  [<c0106b81>] error_code+0x2d/0x38 
  [<c0117d4b>] do_page_fault+0x0/0x56f 
  [<c0117d8f>] do_page_fault+0x44/0x56f 
  [<c0117d4b>] do_page_fault+0x0/0x56f 
  [<c0106b81>] error_code+0x2d/0x38 
  [<c0117d4b>] do_page_fault+0x0/0x56f 
  [<c0117d8f>] do_page_fault+0x44/0x56f 
  [<c0117d4b>] do_page_fault+0x0/0x56f 
  [<c0106b81>] error_code+0x2d/0x38 
  [<c0117d4b>] do_page_fault+0x0/0x56f 
  [<c0117d8f>] do_page_fault+0x44/0x56f 
  [<c0117d4b>] do_page_fault+0x0/0x56f 
  [<c0106b81>] error_code+0x2d/0x38 
  [<c0117d4b>] do_page_fault+0x0/0x56f 
  [<c0117d8f>] do_page_fault+0x44/0x56f 
  [<c0117d4b>] do_page_fault+0x0/0x56f 
  [<c0106b81>] error_code+0x2d/0x38 
  [<c0117d4b>] do_page_fault+0x0/0x56f 
  [<c0117d8f>] do_page_fault+0x44/0x56f 
  [<c0117d4b>] do_page_fault+0x0/0x56f 
  [<c0106b81>] error_code+0x2d/0x38 
  [<c0117d4b>] do_page_fault+0x0/0x56f 
  [<c0117d8f>] do_page_fault+0x44/0x56f 
  [<c0117d4b>] do_page_fault+0x0/0x56f 
  [<c0106b81>] error_code+0x2d/0x38 
  [<c0117d4b>] do_page_fault+0x0/0x56f 
  [<c0117d8f>] do_page_fault+0x44/0x56f 
  [<c0117d4b>] do_page_fault+0x0/0x56f 
  [<c0106b81>] error_code+0x2d/0x38 
  [<c0117d4b>] do_page_fault+0x0/0x56f 
  [<c0117d8f>] do_page_fault+0x44/0x56f 
  [<c0117d4b>] do_page_fault+0x0/0x56f 
  [<c0106b81>] error_code+0x2d/0x38 
  [<c0117d4b>] do_page_fault+0x0/0x56f 
  [<c0117d8f>] do_page_fault+0x44/0x56f 
  [<c0117d4b>] do_page_fault+0x0/0x56f 
  [<c0106b81>] error_code+0x2d/0x38 
  [<c0117d4b>] do_page_fault+0x0/0x56f 
  [<c0117d8f>] do_page_fault+0x44/0x56f 
  [<c0117d4b>] do_page_fault+0x0/0x56f 
  [<c0106b81>] error_code+0x2d/0x38 
  [<c0117d4b>] do_page_fault+0x0/0x56f 
  [<c0117d8f>] do_page_fault+0x44/0x56f 
  [<c0117d4b>] do_page_fault+0x0/0x56f 
  [<c0106b81>] error_code+0x2d/0x38 
  [<c0117d4b>] do_page_fault+0x0/0x56f 
  [<c0117d8f>] do_page_fault+0x44/0x56f 
  [<c0117d4b>] do_page_fault+0x0/0x56f 
  [<c0106b81>] error_code+0x2d/0x38 
  [<c0117d4b>] do_page_fault+0x0/0x56f 
  [<c0117d8f>] do_page_fault+0x44/0x56f 
  [<c0117d4b>] do_page_fault+0x0/0x56f 
  [<c0106b81>] error_code+0x2d/0x38 
  [<c0117d4b>] do_page_fault+0x0/0x56f 
  [<c0117d8f>] do_page_fault+0x44/0x56f 
  [<c0117d4b>] do_page_fault+0x0/0x56f 
  [<c0106b81>] error_code+0x2d/0x38 
  [<c0117d4b>] do_page_fault+0x0/0x56f 
  ======================= 
 Unable to handle kernel NULL pointer dereference at virtual address 00000001 
  printing eip: 
 c0106d84 
 *pde = 00000000 
-=================================================================== -
