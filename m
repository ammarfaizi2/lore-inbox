Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265127AbTFMEn4 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 13 Jun 2003 00:43:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265132AbTFMEn4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 13 Jun 2003 00:43:56 -0400
Received: from auth22.inet.co.th ([203.150.14.104]:23301 "EHLO
	auth22.inet.co.th") by vger.kernel.org with ESMTP id S265127AbTFMEnz
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 Jun 2003 00:43:55 -0400
From: Michael Frank <mflt1@micrologica.com.hk>
To: linux-kernel@vger.kernel.org
Subject: 2.4.21-rc7 hang on boot after spurious 8259A interrupt: IRQ15.
Date: Fri, 13 Jun 2003 11:36:36 +0800
User-Agent: KMail/1.5.2
X-OS: KDE 3 on GNU/Linux
MIME-Version: 1.0
Content-Disposition: inline
Message-Id: <200306130958.39707.mflt1@micrologica.com.hk>
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Doing swsusp testing in endless loop. On a P4/2.4G (ACPI=off)
on 192nd boot:

spurious 8259A interrupt: IRQ15.
Calibrating delay loop... 

 hang

Hit Reset and it rebooted OK

This is the first spurious 8259A interrupt: IRQ15 seen.

I see spurious 8259A interrupt: IRQ7 quite frequently on
varying hardware on both 2.4 and 2.5.

By design, the 8259A delivers a vector 7 when the IRQ
line is deasserted before the IRQ is serviced. This
applies to both edge and level trigger modes. A floating
"wire" or crapy chipset can pickup noise, but the driver 
should handle it.  

No problems seen with mainboard/cpu/ram in three months. 
I dont' think it is HW, but it could be.  

Also, spurious 8259A interrupts are quite recent, could 
something be wrong with recent 8259A driver?

Regards
Michael

I am not subscribed, pls cc me

-- 
Powered by linux-2.5.70-mm3, compiled with gcc-2.95-3

My current linux related activities in rough order of priority:
- Testing of 2.4/2.5 kernel interactivity
- Testing of Swsusp for 2.4
- Testing of Opera 7.11 emphasizing interactivity
- Research of NFS i/o errors during transfer 2.4>2.5
- Learning 2.5 series kernel debugging with kgdb - it's in the -mm tree
- Studying 2.5 series serial and ide drivers, ACPI, S3
* Input and feedback is always welcome *


