Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261623AbTDHTUU (for <rfc822;willy@w.ods.org>); Tue, 8 Apr 2003 15:20:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261631AbTDHTUU (for <rfc822;linux-kernel-outgoing>); Tue, 8 Apr 2003 15:20:20 -0400
Received: from franka.aracnet.com ([216.99.193.44]:54181 "EHLO
	franka.aracnet.com") by vger.kernel.org with ESMTP id S261623AbTDHTUS (for <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Apr 2003 15:20:18 -0400
Date: Tue, 08 Apr 2003 12:31:54 -0700
From: "Martin J. Bligh" <mbligh@aracnet.com>
To: linux-kernel <linux-kernel@vger.kernel.org>
Subject: [Bug 556] New: dma not enabled for IDE hard drives 
Message-ID: <28110000.1049830314@[10.10.2.4]>
X-Mailer: Mulberry/2.2.1 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


http://bugme.osdl.org/show_bug.cgi?id=556

           Summary: dma not enabled for IDE hard drives
    Kernel Version: 2.5.67
            Status: NEW
          Severity: normal
             Owner: alan@lxorguk.ukuu.org.uk
         Submitter: freelsjd@ornl.gov


Distribution:Debian/Sid

Hardware Environment:dual 2.4Ghz Xeon, SE7500CW2 MB, all Intel
                      Promise PDC20267 ATA-100 ide channels in
                      non-RAID mode

Software Environment:testing with hdparm 5.2-1 of Debian/Sid

Problem Description:

I have similar .config settings for both the 2.4.20 and the 2.5.67
kernels with the identical machine.  Under 2.4.20, I do get dma enabled 
and see good performance (Mb/s) from the hard disk I/O.  

However, under the 2.5.67 kernel, dma is not enabled and the performance 
of the hard drives is poor (~2-3 Mb/s under 2.5.67 versus ~30 Mb/s under 
2.4.20).  The "hdparm -I /dev/hda" command confirms that dma is 
enabled on the hardware, but "hdparm -d1 /dev/hda" confirms that dma will not
enable and the performenace is poor under 2.5.67.  Under 2.4.20, these same
commands show good performance.

Steps to reproduce:

make the kernel, run lilo, boot, and run hdparm tests on this machine.


