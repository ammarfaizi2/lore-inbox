Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262606AbVAEVjB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262606AbVAEVjB (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 5 Jan 2005 16:39:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262605AbVAEVg4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 5 Jan 2005 16:36:56 -0500
Received: from fw.osdl.org ([65.172.181.6]:19107 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S262606AbVAEVf6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 5 Jan 2005 16:35:58 -0500
Date: Wed, 5 Jan 2005 13:35:48 -0800
From: Andrew Morton <akpm@osdl.org>
To: linux-kernel@vger.kernel.org
Subject: Fw: [Bugme-new] [Bug 3993] New: sata_sx4 causes file corruption
 during simultaneous writes
Message-Id: <20050105133548.13ac80d3.akpm@osdl.org>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Begin forwarded message:

Date: Wed, 5 Jan 2005 08:08:32 -0800
From: bugme-daemon@osdl.org
To: bugme-new@lists.osdl.org
Subject: [Bugme-new] [Bug 3993] New: sata_sx4 causes file corruption during simultaneous writes


http://bugme.osdl.org/show_bug.cgi?id=3993

           Summary: sata_sx4 causes file corruption during simultaneous
                    writes
    Kernel Version: 2.6.9
            Status: NEW
          Severity: normal
             Owner: andmike@us.ibm.com
         Submitter: sam@davidoffdotnet.net


Distribution: Debian testing (sarge)
Hardware Environment: Dual Pentium III 733 Mhz, 512 MB ECC Ram, Promise SX4 S150
Controller
Software Environment: 2.6.9 kernel with SMP support
Problem Description: 
Three Seagate 160MB drives connected to the Promise SX4 S150 'Fasttrak'
controller, using the libata sata_sx4 driver.  Individual writes to the drives
are fine.  When the drives are written to simultaneously, either by multiple cp
threads or assembling them in a raid 5, corruption occurs as evidenced by fsck
errors and inconsistent md5 sums.

No hardware errors are reported.  The drives all give clean badblocks tests and
return good benchmarks via bonnie++.

The system used has passed rigorous mprime testing and memtest testing.  The ram
used in the promise card has passed promises's test, is certified as promise
compatible, and has passed indepndent memtest testing when installed in a
separate system.

Steps to reproduce:

1. Format drives and setup filesystem.
2. Start simultaneous instances of cp, copying large files to each drive.
3. Compare md5sums of copied files OR run fsck

Alternative:

1. Assemble drives into raid 5 array
2. copy file
3. compare md5 of copied file with original OR run fsck

------- You are receiving this mail because: -------
You are on the CC list for the bug, or are watching someone who is.
