Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262092AbTJMXZW (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Oct 2003 19:25:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262095AbTJMXZW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Oct 2003 19:25:22 -0400
Received: from ale.atd.ucar.edu ([128.117.80.15]:39663 "EHLO ale.atd.ucar.edu")
	by vger.kernel.org with ESMTP id S262092AbTJMXZS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Oct 2003 19:25:18 -0400
From: "Charles Martin" <martinc@ucar.edu>
To: <linux-kernel@vger.kernel.org>
Cc: <martinc@ucar.edu>
Subject: how to build a working 2.6 kernel with SATA
Date: Mon, 13 Oct 2003 17:25:12 -0600
Message-ID: <006d01c391e1$4356b190$c3507580@atdsputnik>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook, Build 10.0.2627
Importance: Normal
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1165
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I am trying to build a bootable 2.6 kernel for a Dell 8300, 
which has both the onboard ICH5 SATA controller and a PCI 
Promise S150 SATA controller. Two drives are connected to 
the Promise card, configured for mirroring. I've installed 
RH9, using the proprietary driver from Promise. 

I've been working with 2.6.0-test7. I apply the test7-bk2 patch, 
followed by the test7-bk2-libata patch. This is followed by the standard

make bzImage && make modules && make modules_install && make install.
Note that I have to comment out scsi_hostadapter in /etc/modules.conf
in order for the mkinitrd to succeed during "make install".

I can't seem to get a kernel and initrd combination built
that will boot. I have seen a variety of boot problems,
but they usually seem to be related to a failure trying
to mount the root file system. For instance, the boot
gives the error "error 6 mounting ext3" when trying to 
mount the root filesystem. Pivotroot then fails after this.

I've tried several permutations on having the serial ata built-in, 
versus a module, with varying but always negative results.

Perhaps there is a key step that I am not aware of? Does
my procedure sound correct?

Thanks,
Charlie

