Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268009AbUHPWzq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268009AbUHPWzq (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 16 Aug 2004 18:55:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268008AbUHPWzq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 16 Aug 2004 18:55:46 -0400
Received: from the-village.bc.nu ([81.2.110.252]:27365 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id S268009AbUHPWx3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 16 Aug 2004 18:53:29 -0400
Subject: Re: 2.6.8.1-mm1
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
Cc: Andrew Morton <akpm@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <200408170030.41049.bzolnier@elka.pw.edu.pl>
References: <20040816143710.1cd0bd2c.akpm@osdl.org>
	 <200408170030.41049.bzolnier@elka.pw.edu.pl>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1092693063.21061.12.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Mon, 16 Aug 2004 22:51:10 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Llu, 2004-08-16 at 23:30, Bartlomiej Zolnierkiewicz wrote:
> Please don't push this upstream, it duplicates _a lot_ of functionality 
> present in drivers/ide / libata (Alan Cox has native drivers/ide driver,
> although I would still prefer libata based driver) and contains code for RAID 
> metadata handling which should belong to user-space.

Some of the metadata handling is needed kernel side. I'm hoping we can
avoid most of it with the drive hotplug code. The corner case causing
the problem is when no arrays are configured so there is no device/hwif
present.

I looked at the libata stuff - it's part of the reason I sent Jeff the
error dump/translate patch but right now libata is woefully ignorant of
a large number of IDE/EIDE/ATA considerations.

Alan

