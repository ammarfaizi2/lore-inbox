Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965085AbVKOXnw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965085AbVKOXnw (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Nov 2005 18:43:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965083AbVKOXnv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Nov 2005 18:43:51 -0500
Received: from bay108-f7.bay108.hotmail.com ([65.54.162.17]:31590 "EHLO
	hotmail.com") by vger.kernel.org with ESMTP id S965081AbVKOXnu
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Nov 2005 18:43:50 -0500
Message-ID: <BAY108-F7B49C0F56D3AF2CD03DF4C05D0@phx.gbl>
X-Originating-IP: [198.87.131.194]
X-Originating-Email: [joneserstein@hotmail.com]
From: "Jones Joneser" <joneserstein@hotmail.com>
To: linux-ide@vger.kernel.org
Cc: linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: PROBLEM: Tyan s2822 and SATA slowness / erratic speeds kernel 2.6
Date: Tue, 15 Nov 2005 23:43:50 +0000
Mime-Version: 1.0
Content-Type: text/plain; format=flowed
X-OriginalArrivalTime: 15 Nov 2005 23:43:50.0458 (UTC) FILETIME=[6E0461A0:01C5EA3E]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Machine:
Tyan s2822G3NR-D
Silicon Image, Inc. SiI 3114
SATA Drives: Western Digital 300gb / seagate 80 gb

Initially we thought we had a network issue because we were seeing a 
slowdown when transferring files > 512Mb in size (by whatever method: rsync, 
cp, scp, etc.) between two of the Tyan servers, we see the first 512Mb go at 
a decent rate (tens of megabytes per second) and then the rate plummets to 
below 500k/sec.   However we reproduce the issue locally on a machine thus 
eliminating the network card issue. We also had tried with different 
ethernet cards and x-over cable.


We are using CentOS 4 and have tried both 4.1 and 4.2 (the latest edition) 
64 and 32 bit.  We have tried ubuntu, gentoo, and vanilla kernels.  We have 
upgraded our BIOS to the latest and experimented with different BIOS 
settings (from 'safe' to 'optimal' with many variants in between.) We have 
tried it with ACPI switched off, with 4gb of RAM and with 8gb of RAM. We 
have upgraded the BIOS to 3.04 & then 3.05.  The best we get is that under 
the ubuntu, gentoo, and a 2.4 kernel we can see stable performance that is 
well below what we should be getting ~20MiB/s.

No matter what combination of configuration we try, we consistently see this 
issue.  We have even tried and LSI SATA controller w/ Tyan motherboard and 
experienced the same issues.

We moved the SATA controller to a Dell PE 1750 and experience none of the 
slowdowns, consistent ly 45-50MiB/s performance with no erraticness in speed 
or drops in performance.

We suspect the issue is related to the combo of the Tyan mobo with the SATA 
controller subsystem but need some assistance in further nailing down the 
cause and solution to this issue.

Let me know of any additional information that I can provide to assist with 
the debugging of this issue.

Thanks,
-asher


