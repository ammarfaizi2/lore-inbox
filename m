Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261240AbTKGAh7 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 6 Nov 2003 19:37:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261262AbTKGAh6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 6 Nov 2003 19:37:58 -0500
Received: from metro.dynaweb.hu ([195.70.37.87]:37094 "EHLO metro.dynaweb.hu")
	by vger.kernel.org with ESMTP id S261240AbTKGAh5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 6 Nov 2003 19:37:57 -0500
Date: Fri, 7 Nov 2003 01:35:54 +0100
From: Rumi Szabolcs <rumi_ml@rtfm.hu>
To: linux-kernel@vger.kernel.org
Subject: 2.4 ICH4 + SATA bridge problems
Message-Id: <20031107013554.72178e8e.rumi_ml@rtfm.hu>
X-Mailer: Sylpheed version 0.9.6 (GTK+ 1.2.10; sparc-sun-solaris2.9)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

I've got here an i845PE-based motherboard with the usual
Marvell 88i8030 PATA->SATA bridge chip. When I connect a
SATA drive to this one, the BIOS recognizes it as an UDMA100
device, but the kernel (2.4.22) only uses UDMA33, and hdparm
also only reports support up to udma2, which results in a
performance of about 15MB/sec (hdparm -t) vs. the >50MB/sec
these drives can normally push.

I have tested this with two different drives, a fully native
SATA drive (ST3160023AS) and a pseudo-SATA drive (MX6Y120M0)
which uses the same Marvell chip internally to convert SATA
back to PATA because thats what the drive really is. The
result is that both drives show up as UDMA100 in the BIOS
and as UDMA33 in the kernel.

What is the reason for this?
Any comments/fixes out there already?

Thanks!

Regards,
Szabolcs Rumi
