Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263769AbTKXQmK (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 24 Nov 2003 11:42:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263771AbTKXQmK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 24 Nov 2003 11:42:10 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:51609 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S263769AbTKXQmI
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 24 Nov 2003 11:42:08 -0500
Message-ID: <3FC234D4.30401@pobox.com>
Date: Mon, 24 Nov 2003 11:41:56 -0500
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030703
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Linux Kernel <linux-kernel@vger.kernel.org>
CC: benh@kernel.crashing.org
Subject: [PATCH/CFT] libata bug fix update
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Ben H noticed a bug which may cause some devices to "not be talked to" 
at probe time...  definitely a bugfix that libata users should obtain. 
This fix affects all SATA controllers libata supports.

Promise and VIA SATA users:
If you continue to see negative results, change ATA_FLAG_SRST to 
ATA_FLAG_SATA_RESET in the sata_{promise,via}.c source code, and re-test.

Patch for 2.6.0-test10:
http://www.kernel.org/pub/linux/kernel/people/jgarzik/libata/2.6.0-test10-libata1.patch.bz2

Patch for 2.4.23-rc3:
http://www.kernel.org/pub/linux/kernel/people/jgarzik/libata/2.4.23-rc3-libata1.patch.bz2

BK users:
http://gkernel.bkbits.net/libata-2.[45]


