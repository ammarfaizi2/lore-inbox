Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281497AbRKHKSq>; Thu, 8 Nov 2001 05:18:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281500AbRKHKSg>; Thu, 8 Nov 2001 05:18:36 -0500
Received: from wiprom2mx1.wipro.com ([203.197.164.41]:57801 "EHLO
	wiprom2mx1.wipro.com") by vger.kernel.org with ESMTP
	id <S281497AbRKHKS2>; Thu, 8 Nov 2001 05:18:28 -0500
Message-ID: <3BEA599B.6080606@wipro.com>
Date: Thu, 08 Nov 2001 15:38:27 +0530
From: "BALBIR SINGH" <balbir.singh@wipro.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.5) Gecko/20011012
X-Accept-Language: en-us
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Suspected error in make dep
Content-Type: multipart/mixed;
	boundary="------------InterScan_NT_MIME_Boundary"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


This is a multi-part message in MIME format.

--------------InterScan_NT_MIME_Boundary
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

I got the following on my machine

Pentium III, 128MB, Linux 2.4.13 while running make dep on 2.4.14

sa1100fb.c:164:27: linux/cpufreq.h: No such file or directory
sa1100fb.c:166:26: asm/hardware.h: No such file or directory
sa1100fb.c:169:28: asm/mach-types.h: No such file or directory
sa1100fb.c:171:30: asm/arch/assabet.h: No such file or directory


 From my .config

#
# Frame-buffer support
#
# CONFIG_FB is not set



The files mentioned do not exist in arch that is i386. This driver seems
to be for the "arm" architecture.

I was wondering why this file is used in make dep. Did I miss something or
should I wait for kbuild in 2.5?

Balbir


--------------InterScan_NT_MIME_Boundary
Content-Type: text/plain;
	name="InterScan_Disclaimer.txt"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="InterScan_Disclaimer.txt"

-------------------------------------------------------------------------------------------------------------------------
Information transmitted by this E-MAIL is proprietary to Wipro and/or its Customers and
is intended for use only by the individual or entity to which it is
addressed, and may contain information that is privileged, confidential or
exempt from disclosure under applicable law. If you are not the intended
recipient or it appears that this mail has been forwarded to you without
proper authority, you are notified that any use or dissemination of this
information in any manner is strictly prohibited. In such cases, please
notify us immediately at mailto:mailadmin@wipro.com and delete this mail
from your records.
----------------------------------------------------------------------------------------------------------------------

--------------InterScan_NT_MIME_Boundary--
