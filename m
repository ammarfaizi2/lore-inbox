Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263723AbTL2RPw (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 29 Dec 2003 12:15:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263726AbTL2RPw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 29 Dec 2003 12:15:52 -0500
Received: from websrv.werbeagentur-aufwind.de ([213.239.197.241]:62605 "EHLO
	mail.werbeagentur-aufwind.de") by vger.kernel.org with ESMTP
	id S263723AbTL2RPu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 29 Dec 2003 12:15:50 -0500
Subject: Re: [2.4.18] oops in lvm or raid
From: Christophe Saout <christophe@saout.de>
To: Roger Gammans <roger@computer-surgery.co.uk>
Cc: LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20031229145936.GA19936@computer-surgery.co.uk>
References: <20031229145936.GA19936@computer-surgery.co.uk>
Content-Type: text/plain
Message-Id: <1072718170.5152.130.camel@leto.cs.pocnet.net>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Mon, 29 Dec 2003 18:16:10 +0100
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Am Mo, den 29.12.2003 schrieb Roger Gammans um 15:59:

> Dec 29 13:15:23 turin kernel: lvm -- giving up to snapshot /dev/rootvg/data_root on /dev/rootvg/data_20031218: out of spa
> Dec 29 13:15:23 turin kernel: Unable to handle kernel paging request at virtual address 00015618
> Dec 29 13:15:23 turin kernel:  printing eip:
> Dec 29 13:15:23 turin kernel: c4847a7c
>                               c4847a7c -> lvm_snapshot_remap_block (c4847a0c)
>
> This is a stock kernel (bf2.4) from debian stable (Version: 2.4.18-5)

LVM1 snapshotting in the plain 2.4.18 kernel is known to have bugs.

You should upgrade to the latest LVM 1.0.8 kernel code. Well, I can't
access the Sistina website at the moment. I'm sure you can find a
lvm_1.0.8.tar.gz (or lvm_1.0.7.tar.gz which also has most bugs fixed)
somewhere.

In the directory LVM/1.0.8/kernel are some files:

Copy lvm.h to /usr/src/linux/include/linux and the rest to
/usr/src/linux/drivers/md (overwrite the old ones) and recompile the
kernel.

Or you can upgrade to the 2.4.23 kernel, I think it contains the LVM
1.0.7 code.

--
Christophe Saout <christophe@saout.de>
Please avoid sending me Word or PowerPoint attachments.
See http://www.fsf.org/philosophy/no-word-attachments.html

