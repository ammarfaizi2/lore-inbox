Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262071AbUHLMLv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262071AbUHLMLv (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 Aug 2004 08:11:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268526AbUHLMLv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 Aug 2004 08:11:51 -0400
Received: from mailhost.cs.auc.dk ([130.225.194.6]:50909 "EHLO
	mailhost.cs.auc.dk") by vger.kernel.org with ESMTP id S262071AbUHLMK7
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 Aug 2004 08:10:59 -0400
Subject: Memory Stick Pro driver
From: Emmanuel Fleury <fleury@cs.auc.dk>
To: Linux Kernel Mailing-list <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Organization: Aalborg University -- Computer Science Dept.
Message-Id: <1092312640.13824.89.camel@rade7.e.cs.auc.dk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Thu, 12 Aug 2004 14:10:40 +0200
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I have a built-in "memory stick" reader on my vaio laptop and I recently
tried to read a "memory stick pro" stick. I got this messages in the
/var/log/messages:

Aug 12 14:10:13 hermes vmunix: SCSI error: host 0 id 0 lun 0 return code
= 8000002
Aug 12 14:10:13 hermes vmunix:  Sense class 7, sense error 0, extended
sense 3
Aug 12 14:10:13 hermes vmunix: sda: Unit Not Ready, sense:
Aug 12 14:10:13 hermes vmunix: Current : sense = 70  3
Aug 12 14:10:13 hermes vmunix: ASC=30 ASCQ= 1
Aug 12 14:10:13 hermes vmunix: Raw sense data:0x70 0x00 0x03 0x00 0x00
0x00 0x00 0x0a 0x00 0x00 0x00 0x00 0x30 0x01 0x00 0x00 0x00 0x00
Aug 12 14:10:13 hermes vmunix: sda : READ CAPACITY failed.
Aug 12 14:10:13 hermes vmunix: sda : status=1, message=00, host=0,
driver=08
Aug 12 14:10:13 hermes vmunix: Current sd: sense = 70  3
Aug 12 14:10:13 hermes vmunix: ASC=30 ASCQ= 1
Aug 12 14:10:13 hermes vmunix: Raw sense data:0x70 0x00 0x03 0x00 0x00
0x00 0x00 0x0a 0x00 0x00 0x00 0x00 0x30 0x01 0x00 0x00 0x00 0x00
Aug 12 14:10:13 hermes vmunix: sda: assuming Write Enabled
Aug 12 14:10:13 hermes vmunix: SCSI error: host 0 id 0 lun 0 return code
= 8000002
Aug 12 14:10:13 hermes vmunix:  Sense class 7, sense error 0, extended
sense 3
Aug 12 14:10:13 hermes vmunix: sda: Unit Not Ready, sense:
Aug 12 14:10:13 hermes vmunix: Current : sense = 70  3
Aug 12 14:10:13 hermes vmunix: ASC=30 ASCQ= 1
Aug 12 14:10:13 hermes vmunix: Raw sense data:0x70 0x00 0x03 0x00 0x00
0x00 0x00 0x0a 0x00 0x00 0x00 0x00 0x30 0x01 0x00 0x00 0x00 0x00
Aug 12 14:10:13 hermes vmunix: sda : READ CAPACITY failed.
Aug 12 14:10:13 hermes vmunix: sda : status=1, message=00, host=0,
driver=08
Aug 12 14:10:13 hermes vmunix: Current sd: sense = 70  3
Aug 12 14:10:13 hermes vmunix: ASC=30 ASCQ= 1
Aug 12 14:10:13 hermes vmunix: Raw sense data:0x70 0x00 0x03 0x00 0x00
0x00 0x00 0x0a 0x00 0x00 0x00 0x00 0x30 0x01 0x00 0x00 0x00 0x00
Aug 12 14:10:13 hermes vmunix: sda: assuming Write Enabled
Aug 12 14:10:13 hermes vmunix:  sda:<3>Buffer I/O error on device sda,
logical block 0
Aug 12 14:10:13 hermes vmunix:  unable to read partition table
Aug 12 14:10:13 hermes vmunix: SCSI error: host 0 id 0 lun 0 return code
= 8000002
Aug 12 14:10:13 hermes vmunix:  Sense class 7, sense error 0, extended
sense 3
Aug 12 14:10:15 hermes vmunix: SCSI error: host 0 id 0 lun 0 return code
= 8000002
Aug 12 14:10:15 hermes vmunix:  Sense class 7, sense error 0, extended
sense 3
Aug 12 14:10:15 hermes vmunix: sda: Unit Not Ready, sense:
Aug 12 14:10:15 hermes vmunix: Current : sense = 70  3
Aug 12 14:10:15 hermes vmunix: ASC=30 ASCQ= 1
Aug 12 14:10:15 hermes vmunix: Raw sense data:0x70 0x00 0x03 0x00 0x00
0x00 0x00 0x0a 0x00 0x00 0x00 0x00 0x30 0x01 0x00 0x00 0x00 0x00
Aug 12 14:10:15 hermes vmunix: sda : READ CAPACITY failed.
Aug 12 14:10:15 hermes vmunix: sda : status=1, message=00, host=0,
driver=08
Aug 12 14:10:15 hermes vmunix: Current sd: sense = 70  3
Aug 12 14:10:15 hermes vmunix: ASC=30 ASCQ= 1
Aug 12 14:10:15 hermes vmunix: Raw sense data:0x70 0x00 0x03 0x00 0x00
0x00 0x00 0x0a 0x00 0x00 0x00 0x00 0x30 0x01 0x00 0x00 0x00 0x00
Aug 12 14:10:15 hermes vmunix: sda: assuming Write Enabled
Aug 12 14:10:15 hermes vmunix: SCSI error: host 0 id 0 lun 0 return code
= 8000002
Aug 12 14:10:15 hermes vmunix:  Sense class 7, sense error 0, extended
sense 3
Aug 12 14:10:15 hermes vmunix: sda: Unit Not Ready, sense:
Aug 12 14:10:15 hermes vmunix: Current : sense = 70  3
Aug 12 14:10:15 hermes vmunix: ASC=30 ASCQ= 1
Aug 12 14:10:15 hermes vmunix: Raw sense data:0x70 0x00 0x03 0x00 0x00
0x00 0x00 0x0a 0x00 0x00 0x00 0x00 0x30 0x01 0x00 0x00 0x00 0x00
Aug 12 14:10:15 hermes vmunix: sda : READ CAPACITY failed.
Aug 12 14:10:15 hermes vmunix: sda : status=1, message=00, host=0,
driver=08
Aug 12 14:10:15 hermes vmunix: Current sd: sense = 70  3
Aug 12 14:10:15 hermes vmunix: ASC=30 ASCQ= 1
Aug 12 14:10:15 hermes vmunix: Raw sense data:0x70 0x00 0x03 0x00 0x00
0x00 0x00 0x0a 0x00 0x00 0x00 0x00 0x30 0x01 0x00 0x00 0x00 0x00
Aug 12 14:10:15 hermes vmunix: sda: assuming Write Enabled
Aug 12 14:10:15 hermes vmunix:  sda:<3>Buffer I/O error on device sda,
logical block 0
Aug 12 14:10:15 hermes vmunix:  unable to read partition table
Aug 12 14:10:15 hermes vmunix: SCSI error: host 0 id 0 lun 0 return code
= 8000002
Aug 12 14:10:15 hermes vmunix:  Sense class 7, sense error 0, extended
sense 3
Aug 12 14:10:17 hermes vmunix: SCSI error: host 0 id 0 lun 0 return code
= 8000002
Aug 12 14:10:17 hermes vmunix:  Sense class 7, sense error 0, extended
sense 3
Aug 12 14:10:17 hermes vmunix: sda: Unit Not Ready, sense:
Aug 12 14:10:17 hermes vmunix: Current : sense = 70  3
Aug 12 14:10:17 hermes vmunix: ASC=30 ASCQ= 1
Aug 12 14:10:17 hermes vmunix: Raw sense data:0x70 0x00 0x03 0x00 0x00
0x00 0x00 0x0a 0x00 0x00 0x00 0x00 0x30 0x01 0x00 0x00 0x00 0x00
Aug 12 14:10:17 hermes vmunix: sda : READ CAPACITY failed.
Aug 12 14:10:17 hermes vmunix: sda : status=1, message=00, host=0,
driver=08
Aug 12 14:10:17 hermes vmunix: Current sd: sense = 70  3
Aug 12 14:10:17 hermes vmunix: ASC=30 ASCQ= 1
Aug 12 14:10:17 hermes vmunix: Raw sense data:0x70 0x00 0x03 0x00 0x00
0x00 0x00 0x0a 0x00 0x00 0x00 0x00 0x30 0x01 0x00 0x00 0x00 0x00
Aug 12 14:10:17 hermes vmunix: sda: assuming Write Enabled
Aug 12 14:10:17 hermes vmunix: SCSI error: host 0 id 0 lun 0 return code
= 8000002
Aug 12 14:10:17 hermes vmunix:  Sense class 7, sense error 0, extended
sense 3
Aug 12 14:10:17 hermes vmunix: sda: Unit Not Ready, sense:
Aug 12 14:10:17 hermes vmunix: Current : sense = 70  3
Aug 12 14:10:17 hermes vmunix: ASC=30 ASCQ= 1
Aug 12 14:10:17 hermes vmunix: Raw sense data:0x70 0x00 0x03 0x00 0x00
0x00 0x00 0x0a 0x00 0x00 0x00 0x00 0x30 0x01 0x00 0x00 0x00 0x00
Aug 12 14:10:17 hermes vmunix: sda : READ CAPACITY failed.
Aug 12 14:10:17 hermes vmunix: sda : status=1, message=00, host=0,
driver=08
Aug 12 14:10:17 hermes vmunix: Current sd: sense = 70  3
Aug 12 14:10:17 hermes vmunix: ASC=30 ASCQ= 1
Aug 12 14:10:17 hermes vmunix: Raw sense data:0x70 0x00 0x03 0x00 0x00
0x00 0x00 0x0a 0x00 0x00 0x00 0x00 0x30 0x01 0x00 0x00 0x00 0x00
Aug 12 14:10:17 hermes vmunix: sda: assuming Write Enabled
Aug 12 14:10:17 hermes vmunix:  sda:<3>Buffer I/O error on device sda,
logical block 0
Aug 12 14:10:17 hermes vmunix:  unable to read partition table
Aug 12 14:10:17 hermes vmunix: SCSI error: host 0 id 0 lun 0 return code
= 8000002
Aug 12 14:10:17 hermes vmunix:  Sense class 7, sense error 0, extended
sense 3
Aug 12 14:10:19 hermes vmunix: SCSI error: host 0 id 0 lun 0 return code
= 8000002
Aug 12 14:10:19 hermes vmunix:  Sense class 7, sense error 0, extended
sense 3
Aug 12 14:10:19 hermes vmunix: sda: Unit Not Ready, sense:
Aug 12 14:10:19 hermes vmunix: Current : sense = 70  3
Aug 12 14:10:19 hermes vmunix: ASC=30 ASCQ= 1
Aug 12 14:10:19 hermes vmunix: Raw sense data:0x70 0x00 0x03 0x00 0x00
0x00 0x00 0x0a 0x00 0x00 0x00 0x00 0x30 0x01 0x00 0x00 0x00 0x00
Aug 12 14:10:19 hermes vmunix: sda : READ CAPACITY failed.
Aug 12 14:10:19 hermes vmunix: sda : status=1, message=00, host=0,
driver=08
Aug 12 14:10:19 hermes vmunix: Current sd: sense = 70  3
Aug 12 14:10:19 hermes vmunix: ASC=30 ASCQ= 1
Aug 12 14:10:19 hermes vmunix: Raw sense data:0x70 0x00 0x03 0x00 0x00
0x00 0x00 0x0a 0x00 0x00 0x00 0x00 0x30 0x01 0x00 0x00 0x00 0x00
Aug 12 14:10:19 hermes vmunix: sda: assuming Write Enabled
Aug 12 14:10:19 hermes vmunix: SCSI error: host 0 id 0 lun 0 return code
= 8000002
Aug 12 14:10:19 hermes vmunix:  Sense class 7, sense error 0, extended
sense 3
Aug 12 14:10:19 hermes vmunix: sda: Unit Not Ready, sense:
Aug 12 14:10:19 hermes vmunix: Current : sense = 70  3
Aug 12 14:10:19 hermes vmunix: ASC=30 ASCQ= 1
Aug 12 14:10:19 hermes vmunix: Raw sense data:0x70 0x00 0x03 0x00 0x00
0x00 0x00 0x0a 0x00 0x00 0x00 0x00 0x30 0x01 0x00 0x00 0x00 0x00
Aug 12 14:10:19 hermes vmunix: sda : READ CAPACITY failed.
Aug 12 14:10:19 hermes vmunix: sda : status=1, message=00, host=0,
driver=08
Aug 12 14:10:19 hermes vmunix: Current sd: sense = 70  3
Aug 12 14:10:19 hermes vmunix: ASC=30 ASCQ= 1
Aug 12 14:10:19 hermes vmunix: Raw sense data:0x70 0x00 0x03 0x00 0x00
0x00 0x00 0x0a 0x00 0x00 0x00 0x00 0x30 0x01 0x00 0x00 0x00 0x00
Aug 12 14:10:19 hermes vmunix: sda: assuming Write Enabled
Aug 12 14:10:19 hermes vmunix:  sda:<3>Buffer I/O error on device sda,
logical block 0
Aug 12 14:10:19 hermes vmunix:  unable to read partition table
Aug 12 14:10:19 hermes vmunix: SCSI error: host 0 id 0 lun 0 return code
= 8000002
Aug 12 14:10:19 hermes vmunix:  Sense class 7, sense error 0, extended
sense 3

...
And so on
...

I was curious to know if the 128Mo limitation is tied to the hardware or
the software and how much differ these two formats... would it be
possible to read a "memory stick pro" stick with a "memory stick" reader
????

Any one can comment on this ? (or give me some hints)

Regards
-- 
Emmanuel Fleury

Computer Science Department, |  Office: B1-201
Aalborg University,          |  Phone:  +45 96 35 72 23
Fredriks Bajersvej 7E,       |  Fax:    +45 98 15 98 89
9220 Aalborg East, Denmark   |  Email:  fleury@cs.auc.dk

