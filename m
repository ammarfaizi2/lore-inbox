Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263472AbUCYSBN (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 25 Mar 2004 13:01:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263479AbUCYSBN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 25 Mar 2004 13:01:13 -0500
Received: from fw.osdl.org ([65.172.181.6]:12724 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S263472AbUCYSBI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 25 Mar 2004 13:01:08 -0500
Date: Thu, 25 Mar 2004 10:01:06 -0800
From: cliff white <cliffw@osdl.org>
To: linux-kernel@vger.kernel.org
Subject: OSDL: STP hardware uprev
Message-Id: <20040325100106.235054a7.cliffw@osdl.org>
Organization: OSDL
X-Mailer: Sylpheed version 0.9.6 (GTK+ 1.2.9; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



We've (finally) uprev'd all the 4 and 8 CPU machines with newer, great SCSI RAID
controllers. ( For some range of 'great' ) 
http://www.osdl.org/lab_activities/kernel_testing/stp/

The new cards are Adaptec 2200S SCSI RAID, and we now have true 64 bit PAE 
support. No more bounce buffers!

However, IO tests run post 3/23/04 will not be comparable to tests run before,
due to the hardware change.

Please, run a bunch of STP tests, and complain.

More Details:
64MB Cache ( not battery-backed ) 
firmware version V4.0 ( Build 6011)
2 each in the 4-cpu machines,
4 in the 8-cpu machines
Drive cache is set to write-through on all drives.

4-way dmesg:
AAC0: kernel 4.0.4 build 6011
AAC0: monitor 4.0.4 build 6011
AAC0: bios 4.0.0 build 6011
AAC0: serial 0ba60f4
aacraid:        NMI ISR: NMI_PRIMARY_ATU_ERROR
AAC1: kernel 4.0.4 build 6011
AAC1: monitor 4.0.4 build 6011
AAC1: bios 4.0.0 build 6011
AAC1: serial 0ba6120
aacraid:        NMI ISR: NMI_PRIMARY_ATU_ERROR

This makes us happy:
Mar 25 07:35:52 stp8-000 kernel: AAC0: 64 Bit PAE enabled
Mar 25 07:35:53 stp8-000 kernel: AAC1: 64 Bit PAE enabled
Mar 25 07:35:54 stp8-000 kernel: AAC2: 64 Bit PAE enabled
Mar 25 07:35:56 stp8-000 kernel: AAC3: 64 Bit PAE enabled
---------------
Thanks and praise to Our Own Russell Evans, for doing the
speedy install.


cliffw

-- 
The church is near, but the road is icy.
The bar is far, but i will walk carefully. - Russian proverb
