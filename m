Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264676AbTF0Sqz (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 27 Jun 2003 14:46:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264679AbTF0Sqz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 27 Jun 2003 14:46:55 -0400
Received: from california.sandia.gov ([146.246.250.1]:27410 "EHLO
	ca.sandia.gov") by vger.kernel.org with ESMTP id S264676AbTF0Sqx
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 27 Jun 2003 14:46:53 -0400
From: Mitch Sukalski <mwsukal@ca.sandia.gov>
Reply-To: mwsukal@ca.sandia.gov
Organization: Sandia National Laboratories
To: linux-kernel@vger.kernel.org
Subject: PROBLEM: non-transparent Intel 82801BAM/CAM PCI-to-PCI bridge (rev. 81 chip, in IBM T40 2373-92U 4/2003 laptop)
Date: Fri, 27 Jun 2003 12:00:47 -0700
User-Agent: KMail/1.5
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200306271200.49875.mwsukal@ca.sandia.gov>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

If you have a new IBM T40 (mine is a model 2372-92U, build 4/03, 2GB RAM), the 
latest 2.4.21 kernel (and 2.4.20 as well), and PCMCIA support is broken, then 
you may have the same problem that I've just isolated. My symptoms included 
crazy values for socket status, and many "timed out during reset" messages 
(see dmesg output below).

Jun 12 15:00:36 juggler kernel: Yenta IRQ list 0000, PCI irq11
Jun 12 15:00:36 juggler kernel: Socket status: 080c2420
Jun 12 15:00:36 juggler kernel: Yenta IRQ list 0000, PCI irq11
Jun 12 15:00:36 juggler kernel: Socket status: 000dd9e2
Jun 12 15:00:39 juggler kernel: cs: socket f74a8000 timed out during reset.  
Try increasing setup_delay.
...

