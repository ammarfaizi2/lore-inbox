Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263882AbRFNSWR>; Thu, 14 Jun 2001 14:22:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263863AbRFNSWH>; Thu, 14 Jun 2001 14:22:07 -0400
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:56589 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S263854AbRFNSV6>; Thu, 14 Jun 2001 14:21:58 -0400
Subject: Re: 2.4.5 data corruption
To: lm@bitmover.com (Larry McVoy)
Date: Thu, 14 Jun 2001 19:20:06 +0100 (BST)
Cc: linux-kernel@vger.kernel.org, tytso@thunk.org
In-Reply-To: <200106122017.f5CKHnf24565@work.bitmover.com> from "Larry McVoy" at Jun 12, 2001 01:17:49 PM
X-Mailer: ELM [version 2.5 PL3]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E15Abiw-00056O-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Folks, I believe I have a reproducible test case which corrupts data in
> 2.4.5.

2.4.5 has an out of date 3ware driver that is short

+   1.02.00.005 - Allocate bounce buffers and custom queue depth for raid5 for
+                 6000 and 5000 series controllers.
+                 Reduce polling mdelays causing problems on some systems.
+                 Fix use_sg = 1 calculation bug.
+                 Check for scsi_register returning NULL.
+                 Add aen count to /proc/scsi/3w-xxxx.
+                 Remove aen code unit masking in tw_aen_complete().
+   1.02.00.006 - Remove unit from printk in tw_scsi_eh_abort(), causing
+                 possible oops.
+                 Fix possible null pointer dereference in tw_scsi_queue()
+                 if done function pointer was invalid.
+   1.02.00.007 - Fix possible null pointer dereferences in tw_ioctl().
+                 Remove check for invalid done function pointer from
+                 tw_scsi_queue().

That might be a first thing to check


