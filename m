Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265127AbUIZXx2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265127AbUIZXx2 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 26 Sep 2004 19:53:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265093AbUIZXx2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 26 Sep 2004 19:53:28 -0400
Received: from avmta3-rme.xtra.co.nz ([210.86.15.158]:9162 "EHLO
	avmta3-rme.xtra.co.nz") by vger.kernel.org with ESMTP
	id S265127AbUIZXxP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 26 Sep 2004 19:53:15 -0400
Message-ID: <40BC5D4C2DD333449FBDE8AE961E0C33017E3C54@psexc03.nbnz.co.nz>
From: "Roberts-Thomson, James" <James.Roberts-Thomson@NBNZ.CO.NZ>
To: "Randy.Dunlap" <rddunlap@xenotime.net>
Cc: linux-kernel@vger.kernel.org
Subject: RE: Help Requested with patching "drivers/pci/quirks.c"
Date: Mon, 27 Sep 2004 11:53:00 +1200
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Randy Dunlap wrote:

> Try "lspci -n".

OK, on the 2.4.27 machine, lspci displays an entry for the SMBus device
(once the p4b_smbus module is loaded), thus:

0000:00:1f.3 SMBus: Intel Corp. 82801DB/DBL/DBM (ICH4/ICH4-L/ICH4-M) SMBus
Controller (rev 01)

which lspci -n identifies as 

0000:00:1f.3 Class 0c05: 8086:24c3 (rev 01)

In pci_ids.h, 0x0c05 is "PCI_CLASS_SERIAL_SMBUS", and "24c3" is a
"PCI_DEVICE_ID_INTEL_82801DB_3".  So, thanks to your help, I've found the
dev->device entry I need; but where do I get the dev->subsystem_device value
from?  I'm willing to believe I have the information and that I just don't
recognise what it is - that is my problem.

Thanks for the help so far, though!

> | This communication is confidential and may contain [...etc...]
> N.B.:  I may have received this non-confidential email in error.

(Deep Sigh).  A standard disclaimer inserted by my workplace's email
gateway, I'm afraid.  I have no control over this.  Would it help if I added
the following ?

Despite any later disclaimer to the contrary, this email is not confidential
and does not contain privleged material.

Thanks,

James Roberts-Thomson


This communication is confidential and may contain privileged material.
If you are not the intended recipient you must not use, disclose, copy or retain it.
If you have received it in error please immediately notify me by return email
and delete the emails.
Thank you.
