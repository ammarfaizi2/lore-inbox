Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261205AbUDBWCX (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 2 Apr 2004 17:02:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261204AbUDBWCW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 2 Apr 2004 17:02:22 -0500
Received: from e31.co.us.ibm.com ([32.97.110.129]:10235 "EHLO
	e31.co.us.ibm.com") by vger.kernel.org with ESMTP id S261210AbUDBWBb
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 2 Apr 2004 17:01:31 -0500
To: linux-kernel@vger.kernel.org
Cc: thornber@redhat.com, Stephanie Glass <sglass@us.ibm.com>,
       Paul Larson <plars@us.ibm.com>
MIME-Version: 1.0
Subject: 
X-Mailer: Lotus Notes Release 6.0.2CF1 June 9, 2003
Message-ID: <OF77D6BB95.C84E969D-ON86256E6A.00701C31-86256E6A.00790700@us.ibm.com>
From: Hien Nguyen <hien1@us.ibm.com>
Date: Fri, 2 Apr 2004 16:01:39 -0600
X-MIMETrack: Serialize by Router on D03NM121/03/M/IBM(Release 6.0.2CF2HF168 | December 5, 2003) at
 04/02/2004 15:01:11,
	Serialize complete at 04/02/2004 15:01:11
Content-Type: text/plain; charset="US-ASCII"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I installed SuSE SLES9 beta1 and realized that device mapper 1.00.07-68 
rpm has been installed in the kernel. However it didn't work correctly 
with errors:


Hardware Environment:
pSeries p630 2way Power4+ 1.4GHz 16 GB RAM
pSeries B80 2way Power3 375Mhz 3GB RAM

Software Environment:
SLES9 beta2 with 2.6.4-15-pseries64 kernel

Steps to Reproduce:
1. Installed the system with SLES9 beta1 CDs
2. Upgraded the built kernel to 2.6.4-15-pseries64 using  rpm -ivh 
kernel-pseries64-2.6.4-15.ppc.rpm
3.  Loaded dm_mod: modprobe dm_mod
4. Creating /dev/mapper/control character device with major:10 minor:63 by
executing devmap_mknod.sh

Actual Results:

Tried dmsetup ls and got errors:
   device-mapper ioctl cmd 0 failed: Invalid argument
   Command failed

Expected Results: 
   This a regression since it works fine in the last built kernel: 
2.6.4-9-pseries64


Also, when dmsetup suspend on a device mapper device, it hangs there 
forever.

Do you have any ideas ?



Regards,

 Hien Nguyen
 Linux Technology Center             AUSTIN
 Phone: (512) 838-4140            Tie Line: 678-4140
 e-mail: hien1@us.ibm.com

