Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271363AbTHMDk5 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Aug 2003 23:40:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271359AbTHMDk5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Aug 2003 23:40:57 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:10197 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S271357AbTHMDky
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Aug 2003 23:40:54 -0400
Message-ID: <3F39B33A.2050709@pobox.com>
Date: Tue, 12 Aug 2003 23:40:42 -0400
From: Jeff Garzik <jgarzik@pobox.com>
Organization: none
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2.1) Gecko/20021213 Debian/1.2.1-2.bunk
X-Accept-Language: en
MIME-Version: 1.0
To: LKML <linux-kernel@vger.kernel.org>, linux-scsi@vger.kernel.org
Subject: libata update posted
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Well, I was hoping to complete another low-level driver (Silicon Image) 
out there, but I would rather get bug fixes out first :)

libata driver architecture version 0.70 (helper library)
Intel ICH5 SATA driver version 0.93

Patch for 2.4.21:
ftp://ftp.??.kernel.org/pub/linux/kernel/people/jgarzik/patchkits/2.4/2.4.21-libata5.patch.bz2

Patch for 2.6.0-test3:
ftp://ftp.??.kernel.org/pub/linux/kernel/people/jgarzik/patchkits/2.6/2.6.0-test3-bk1-libata1.patch.bz2

Stressed on both 2.4 and 2.6, SMP and UP, lba2[48] and lba48.

Changes:
* lba48 fix
* SMP fixes
* locking sanitization
* locking documentation ("make pdfdocs")
* more infrastructure for command queueing and async taskfiles

Notes:
* Parallel ATA limited to UDMA/33 (SATA is full speed)
* ATAPI not ready for prime time

Still no data-corrupting bugs, knock on wood.

