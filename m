Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268864AbUIXQKl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268864AbUIXQKl (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 24 Sep 2004 12:10:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268883AbUIXQKl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 24 Sep 2004 12:10:41 -0400
Received: from mx01.qsc.de ([213.148.129.14]:14242 "EHLO mx01.qsc.de")
	by vger.kernel.org with ESMTP id S268864AbUIXQJJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 24 Sep 2004 12:09:09 -0400
Message-ID: <4154466C.5060804@rocklinux-consulting.de>
Date: Fri, 24 Sep 2004 18:08:12 +0200
From: =?ISO-8859-1?Q?Ren=E9_Rebe?= <rene@rocklinux-consulting.de>
User-Agent: Mozilla Thunderbird 0.8 (X11/20040916)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org, James.Bottomley@steeleye.com
Subject: sym53c8xx_2 regressions in 2.6.9-rc2
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Score: 0.0 (/)
X-Spam-Report: Spam detection software, running on the system "grum.localhost", has
	identified this incoming email as possible spam.  The original message
	has been attached to this so you can view it (if it isn't spam) or block
	similar future email.  If you have any questions, see
	the administrator of that system for details.
	Content preview:  Hi James, hi all, James, your recent 2.6.9-pre changes
	seem to cause new regressions in the sym53c8xx_2 driver. On my U30
	sparc64 box I get many errors in the system log: [...] 
	Content analysis details:   (0.0 points, 5.0 required)
	pts rule name              description
	---- ---------------------- --------------------------------------------------
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi James, hi all,

James, your recent 2.6.9-pre changes seem to cause new regressions in 
the sym53c8xx_2 driver.

On my U30 sparc64 box I get many errors in the system log:

Sep 20 15:28:34 sundown kernel: sym0:0:0:phase change 6-7 11@c7ff7b90 
resid=6.
Sep 20 15:28:34 sundown last message repeated 2 times
Sep 20 15:28:34 sundown kernel: sym0:0:0:phase change 6-7 11@c7ff6390 
resid=6.
Sep 20 15:28:35 sundown last message repeated 6 times
Sep 20 15:28:35 sundown kernel: sym0:0:0:phase change 6-7 11@c7ff9b90 
resid=6.
Sep 20 15:28:35 sundown kernel: sym0:0:0:phase change 6-7 11@c7ff6390 
resid=6.
Sep 20 15:28:35 sundown last message repeated 29 times
Sep 20 15:28:35 sundown kernel: sym0:0:0:phase change 6-7 11@c7ff9b90 
resid=6.
Sep 20 15:28:35 sundown last message repeated 2 times
Sep 20 15:28:35 sundown kernel: sym0:0:0:phase change 6-7 11@c7ff6390 
resid=6.
Sep 20 15:28:36 sundown last message repeated 28 times

those did not show up in any other 2.6 kernel up to .8.1 ...

Connected devices are: # cat /proc/scsi/scsi
Attached devices:
Host: scsi0 Channel: 00 Id: 00 Lun: 00
   Vendor: IBM      Model: DXHS18Y          Rev: 0430
   Type:   Direct-Access                    ANSI SCSI revision: 03
Host: scsi0 Channel: 00 Id: 06 Lun: 00
   Vendor: TEAC     Model: CD-ROM CD-532S   Rev: 1.0A
   Type:   CD-ROM                           ANSI SCSI revision: 02

With a working 2.6.8 kernel (that is the one the running right now) the 
printouts during boot are:

sym0: <875> rev 0x3 at pci 0001:00:03.0 irq 4,7e0
sym0: No NVRAM, ID 7, Fast-20, SE, parity checking
sym0: SCSI BUS has been reset.
scsi0 : sym-2.1.18j
sym0:0: FAST-20 WIDE SCSI 40.0 MB/s ST (50.0 ns, offset 15)
   Vendor: IBM       Model: DXHS18Y           Rev: 0430
   Type:   Direct-Access                      ANSI SCSI revision: 03
sym0:0:0: tagged command queuing enabled, command queue depth 16.
scsi(0:0:0:0): Beginning Domain Validation
sym0:0: FAST-20 SCSI 20.0 MB/s ST (50.0 ns, offset 16)
sym0:0: FAST-20 WIDE SCSI 40.0 MB/s ST (50.0 ns, offset 15)
scsi(0:0:0:0): Domain Validation skipping write tests
scsi(0:0:0:0): Ending Domain Validation
SCSI device sda: 35566480 512-byte hdwr sectors (18210 MB)
SCSI device sda: drive cache: write back
  /dev/scsi/host0/bus0/target0/lun0: p1 p2 p3
Attached scsi disk sda at scsi0, channel 0, id 0, lun 0
   Vendor: TEAC      Model: CD-ROM CD-532S    Rev: 1.0A
   Type:   CD-ROM                             ANSI SCSI revision: 02
scsi(0:0:6:0): Beginning Domain Validation
sym0:6: FAST-20 SCSI 20.0 MB/s ST (50.0 ns, offset 16)
scsi(0:0:6:0): Domain Validation skipping write tests
scsi(0:0:6:0): Ending Domain Validation

Sincerely yours,
   René Rebe
