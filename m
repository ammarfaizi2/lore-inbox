Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262126AbVANUMB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262126AbVANUMB (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 14 Jan 2005 15:12:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262128AbVANUMA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 14 Jan 2005 15:12:00 -0500
Received: from nuevo.divinia.com ([209.237.231.206]:7621 "HELO
	nuevo.divinia.com") by vger.kernel.org with SMTP id S262126AbVANUKS
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 14 Jan 2005 15:10:18 -0500
Date: Fri, 14 Jan 2005 12:10:11 -0800 (PST)
From: Aaron Gowatch <aarong@divinia.com>
To: linux-kernel@vger.kernel.org
Subject: aacraid fails when RAID1 array is in anything but Optimal state
Message-ID: <Pine.LNX.4.44.0501141156580.28993-100000@nuevo.divinia.com>
X-Favorite-Cola: Coke
X-Your: Mom
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

We're using Dell PowerEdge 750s with a Dell rebranded Adaptec CERC 1.5/6ch 
SATA adapter.  The systems have 2 disks configured as RAID1.  If the array 
is in any other state than 'Optimal' (ie. 'Degraded' or 'Rebuilding') the 
following error is displayed and the box subsequently panics because its 
unable to mount the root filesystem.

We've had the same experience with 2.6.7 and 2.6.9.  Yesterday as a test, 
I installed RedHat ES 3.0 and it does not exhibit this behavior, but thats 
kernel 2.4 with different aacraid driver.  We've also updated to the 
latest recommended firmware in attempt to correct this.

Is there any way to make this work with kernel 2.6?  Or is this expected 
behavior for this controller under 2.6?

Red Hat/Adaptec aacraid driver (1.1.2-lk2 Jan 14 2005)
AAC0: kernel 4.1.4 build 7403
AAC0: monitor 4.1.4 build 7403
AAC0: bios 4.1.0 build 7403
AAC0: serial bf91c8fafaf001
scsi0 : aacraid
  Vendor: DELL      Model: CERC Mirror       Rev: V1.0
  Type:   Direct-Access                      ANSI SCSI revision: 02
SCSI device sda: 78057216 512-byte hdwr sectors (39965 MB)
sda: Write Protect is off
SCSI device sda: drive cache: write through
 sda:<3>aacraid: Host adapter reset request. SCSI hang ?
aacraid: Host adapter appears dead
scsi: Device offlined - not ready after error recovery: host 0 channel 0 
id 0 lun 0
SCSI error : <0 0 0 0> return code = 0x6000000
end_request: I/O error, dev sda, sector 0
Buffer I/O error on device sda, logical block 0
scsi0 (0:0): rejecting I/O to offline device
Buffer I/O error on device sda, logical block 0
 unable to read partition table
Attached scsi removable disk sda at scsi0, channel 0, id 0, lun 0

Thanks,
Aa.

