Return-Path: <linux-kernel-owner+w=401wt.eu-S1752910AbXABOeZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752910AbXABOeZ (ORCPT <rfc822;w@1wt.eu>);
	Tue, 2 Jan 2007 09:34:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754857AbXABOeZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 Jan 2007 09:34:25 -0500
Received: from mail.icabo.tv.br ([200.220.202.3]:50247 "EHLO mail.icabo.tv.br"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752910AbXABOeY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 Jan 2007 09:34:24 -0500
X-Greylist: delayed 1561 seconds by postgrey-1.27 at vger.kernel.org; Tue, 02 Jan 2007 09:34:23 EST
Message-ID: <459A674B.3060304@fliagreco.com.ar>
Date: Tue, 02 Jan 2007 11:08:11 -0300
From: Pablo Sebastian Greco <lkml@fliagreco.com.ar>
User-Agent: Thunderbird 3.0a1 (Windows/20070101)
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: SATA problems
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-ICABO-MailScanner-Information: Please contact the ISP for more information
X-ICABO-MailScanner: Sem Virus encontrado
X-MailScanner-From: lkml@fliagreco.com.ar
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

First of all, thanks for everything, and my excuses if I'm doing 
anything wrong, this is my first lkml mail, but I've read all the faq, 
so should be OK.
This is the machine with the problem:

Intel ServerBoard S5000VSA
Dual Core Xeon 2.66 (Intel(R) Xeon(TM) CPU 2.66GHz stepping 04)
4G Kingston
1 Seagate 80G sata (ST380211AS) (sda)
3 Samsung 250G sata (SAMSUNG SP2504C) (sdb,c,d)

Installed distribution is FC6 x86_64

I've been getting these messages with distribution and vanilla kernels

Jan  1 16:29:08 squid kernel: ata4.00: exception Emask 0x0 SAct 
0x7fffffff SErr 0x0 action 0x2 frozen
Jan  1 16:29:08 squid kernel: ata4.00: cmd 
61/60:00:c9:6d:8e/00:00:0e:00:00/40 tag 0 cdb 0x0 data 49152 out
Jan  1 16:29:08 squid kernel:          res 
40/00:00:00:4f:c2/00:00:00:00:00/00 Emask 0x4 (timeout)
Jan  1 16:29:08 squid kernel: ata4.00: cmd 
60/08:08:f7:7d:56/00:00:0e:00:00/40 tag 1 cdb 0x0 data 4096 in
Jan  1 16:29:08 squid kernel:          res 
40/00:00:00:00:00/00:00:00:00:00/00 Emask 0x4 (timeout)
<snip>
Jan  1 16:29:08 squid kernel: ata4: soft resetting port
Jan  1 16:29:08 squid kernel: ata4: softreset failed (port busy but CLO 
unavailable)
Jan  1 16:29:08 squid kernel: ata4: softreset failed, retrying in 5 secs
Jan  1 16:29:13 squid kernel: ata4: hard resetting port
Jan  1 16:29:21 squid kernel: ata4: port is slow to respond, please be 
patient (Status 0x80)
Jan  1 16:29:43 squid kernel: ata4: port failed to respond (30 secs, 
Status 0x80)
Jan  1 16:29:43 squid kernel: ata4: COMRESET failed (device not ready)
Jan  1 16:29:43 squid kernel: ata4: hardreset failed, retrying in 5 secs
Jan  1 16:29:48 squid kernel: ata4: hard resetting port
Jan  1 16:29:49 squid kernel: ata4: SATA link up 3.0 Gbps (SStatus 123 
SControl 300)
Jan  1 16:29:49 squid kernel: ata4.00: configured for UDMA/133
Jan  1 16:29:49 squid kernel: ata4: EH complete
Jan  1 16:29:49 squid kernel: SCSI device sdd: 488397168 512-byte hdwr 
sectors (250059 MB)
Jan  1 16:29:49 squid kernel: sdd: Write Protect is off
Jan  1 16:29:49 squid kernel: SCSI device sdd: write cache: enabled, 
read cache: enabled, doesn't support DPO or FUA

lots of them, and eventually crashing the system.
Tested from fc6 2.6.18 kernel to vanilla 2.6.20-rc2-mm1. Old kernels 
just crash, newer ones log these things and then crash.
I don't want to flood with this mail with useless info, so please tell 
me what to send and I'll do it (dmesg, smartctl... you name it)
BTW, memtest was running for about 2 days without errors, and and 
badblocks on all 4 drives returned nothing. Reallocated_Sector_Ct 
raw_value was 0 on all 4 drives

Thanks in advance.
Pablo.
