Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264312AbUFTQLO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264312AbUFTQLO (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 20 Jun 2004 12:11:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264367AbUFTQLN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 20 Jun 2004 12:11:13 -0400
Received: from imf17aec.mail.bellsouth.net ([205.152.59.65]:16797 "EHLO
	imf17aec.mail.bellsouth.net") by vger.kernel.org with ESMTP
	id S264312AbUFTQLD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 20 Jun 2004 12:11:03 -0400
Date: Sun, 20 Jun 2004 12:11:01 -0400
From: Ron Day <ronmon@bellsouth.net>
To: linux-kernel@vger.kernel.org
Cc: ronmon@bellsouth.net
Subject: Re: SCSI related hang on boot
Message-Id: <20040620121101.34274f68@mimi.ronmon.shacknet.nu>
X-Mailer: Sylpheed version 0.9.11claws (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Please CC me on this, since I'm not a list member.

I've been following this thread and hoping for an answer. The problem
I'm having, as well as my hardware, is very similar to this. 

For the record, my equipment:

ASUS A7M-266D, 2 x Athlon MP1800+, 1024MB ECC registered

Tekram DC-390U3W, Symbios Logic (LSI) 53c1010 chipset.
	Running for 2+ years with sym53c8xx_2 driver. It
	replaced a Fireport40 that ran for 2-3 years with
	the same driver and the earlier sym53c8xx (v1)
	with older/slower/smaller HDD's.

Bus0, terminated in-line after second HDD
2 x U160 HDD's, id 0 and 1 (2+ years running)

Bus1, terminated in-line at scanner
An internal Yamaha SCSI CD-RW, id 2 (3-4 years running)
A UMAX S-12 scanner, id 5 (8+ years running)

Everything goes as expected through sym0, where the
two HDD's reside, but problems arise at sym1. Compared
to successful dmesg output, it seems that the scanner
(and hence the termination for that bus) is not seen.

My conclusion is that sym2.1.18i works and sym2.1.18j
does not. I say this because I have made a copy of the 
drivers/scsi/sym53c8xx_2 directory from 2.6.5 (the latest
that I'm aware of with the .i drivers). By replacing the
files in current kernels with these, I have compiled and
run several newer versions sucessfully, the latest being
2.6.7, which I'm running now.

Rather than post everything here, I'll link to some files that should be
relevant.

The error (written down and typed in, no serial console):
http://ronmon.shacknet.nu/configs/scsi_boot_error

Output from a good dmesg (sym2.1.18.i driver):
http://ronmon.shacknet.nu/configs/dmesg_good-2.6.7-rc3

Brief system layout courtesy of phpsysinfo:
http://ronmon.shacknet.nu/phpsysinfo/

Output from 'lspci -vvx':
http://ronmon.shacknet.nu/configs/lspci-vvx
