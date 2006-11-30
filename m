Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1031622AbWK3XFB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1031622AbWK3XFB (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 30 Nov 2006 18:05:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1031620AbWK3XFB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 30 Nov 2006 18:05:01 -0500
Received: from nf-out-0910.google.com ([64.233.182.189]:46309 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S1031622AbWK3XE7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 30 Nov 2006 18:04:59 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=nSLeJNASKvG5q3c1asn4xH+dI+ruVd6jv0gGRfQxjphdYdvJPNm1o0un9X6XwgqpvYzBb8YHN+ZdgVryZtmja6ZqBpvrPrL9wfq+8QEIAb1BNB+mQFG4irCnNmmYZhmxaefQVUCKr7IyyFY0lXxpWROPkQYZh49l5oOYyMDgGoY=
Message-ID: <5bdc1c8b0611301504y6d5b957et350bad438c5e636c@mail.gmail.com>
Date: Thu, 30 Nov 2006 15:04:57 -0800
From: "Mark Knecht" <markknecht@gmail.com>
To: linux-kernel <linux-kernel@vger.kernel.org>, "Ingo Molnar" <mingo@elte.hu>
Subject: 2.6.19-rt1 - failed to boot on AMD64
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Ingo,
   I attempted to get 2.6.19-rt1 going this afternoon but no luck.
First, thanks for the realtime-lsm patch in the kernel. Nice to have
it there.

   OK, so 2.6.19-rt1 starts booting, gets to the point where it see
the keyboard and mouse, and then apparently starts looking for a
remote NFS server? I don't remember seeing this on earlier kernels.

<SNIP>
Root-NFS: No NFS server available, giving up
VFS: Unable to mount root via NFS, trying floppy
VFS: Insert root floppy and press enter
SCSI 0:0:0:0: Direct-Access HP PSC1610  1.00 PQ: 0 ANSI: 2
sd 0:0:0:0: Attached scsi removable disk sda
<SNIP>


At this point the machine just waits and does nothing more. It does
respond to Alt-Ctrl-Del and reboots cleanly.


Here's the basic hardware:

lightning ~ # lspci
00:00.0 Memory controller: nVidia Corporation CK804 Memory Controller (rev a3)
00:01.0 ISA bridge: nVidia Corporation CK804 ISA Bridge (rev a3)
00:01.1 SMBus: nVidia Corporation CK804 SMBus (rev a2)
00:02.0 USB Controller: nVidia Corporation CK804 USB Controller (rev a2)
00:02.1 USB Controller: nVidia Corporation CK804 USB Controller (rev a3)
00:04.0 Multimedia audio controller: nVidia Corporation CK804 AC'97
Audio Controller (rev a2)
00:06.0 IDE interface: nVidia Corporation CK804 IDE (rev f2)
00:07.0 IDE interface: nVidia Corporation CK804 Serial ATA Controller (rev f3)
00:08.0 IDE interface: nVidia Corporation CK804 Serial ATA Controller (rev f3)
00:09.0 PCI bridge: nVidia Corporation CK804 PCI Bridge (rev a2)
00:0a.0 Bridge: nVidia Corporation CK804 Ethernet Controller (rev a3)
00:0b.0 PCI bridge: nVidia Corporation CK804 PCIE Bridge (rev a3)
00:0c.0 PCI bridge: nVidia Corporation CK804 PCIE Bridge (rev a3)
00:0d.0 PCI bridge: nVidia Corporation CK804 PCIE Bridge (rev a3)
00:0e.0 PCI bridge: nVidia Corporation CK804 PCIE Bridge (rev a3)
00:18.0 Host bridge: Advanced Micro Devices [AMD] K8
[Athlon64/Opteron] HyperTransport Technology Configuration
00:18.1 Host bridge: Advanced Micro Devices [AMD] K8
[Athlon64/Opteron] Address Map
00:18.2 Host bridge: Advanced Micro Devices [AMD] K8
[Athlon64/Opteron] DRAM Controller
00:18.3 Host bridge: Advanced Micro Devices [AMD] K8
[Athlon64/Opteron] Miscellaneous Control
01:00.0 VGA compatible controller: ATI Technologies Inc RV370 5B60
[Radeon X300 (PCIE)]
01:00.1 Display controller: ATI Technologies Inc RV370 [Radeon X300SE]
05:06.0 Multimedia audio controller: Xilinx Corporation RME Hammerfall
DSP (rev 68)
05:08.0 FireWire (IEEE 1394): Texas Instruments TSB82AA2 IEEE-1394b
Link Layer Controller (rev 01)
lightning ~ #

   I'll start going through the kernel config to see if something got
messed up in the make oldconfig step. I've not seen this problem with
any previous -rt kernel. I never ran 2.6.19-rcX so maybe this problem
is something in 2.6.19 and not just the -rt? Maybe I should run 2.6.19
itself and see if it boots?

Thanks,
Mark
