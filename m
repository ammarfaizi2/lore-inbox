Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265125AbTL2W2P (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 29 Dec 2003 17:28:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265126AbTL2W2P
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 29 Dec 2003 17:28:15 -0500
Received: from websrv.werbeagentur-aufwind.de ([213.239.197.241]:8347 "EHLO
	mail.werbeagentur-aufwind.de") by vger.kernel.org with ESMTP
	id S265125AbTL2W2L (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 29 Dec 2003 17:28:11 -0500
Subject: RE: ataraid in 2.6.?
From: Christophe Saout <christophe@saout.de>
To: Nicklas Bondesson <nicke@nicke.nu>
Cc: "'Arjan van de Ven'" <arjanv@redhat.com>, linux-kernel@vger.kernel.org
Content-Type: text/plain
Message-Id: <1072736909.7404.3.camel@leto.cs.pocnet.net>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Mon, 29 Dec 2003 23:28:29 +0100
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Am Mo, den 29.12.2003 schrieb Nicklas Bondesson um 23:18:

> I'm planning to go with the device mapping in 2.6.0 to setup RAID1 using my
> Promise TX2000 card. How do I know which device name it will choose? I have
> looked in the 'devices.txt' but there is neither a ide-raid nor a specific
> Promise device name mapping. Please advice.

If you cannot wait for Arjan or anybody else to write an ataraid setup
tool, you can go with dmsetup and choose any name you want (see the
dmsetup man page). The only restriction is that dmsetup creates device
under /dev/mapper, you can though use symlinks to it like LVM2 does if
you need it under /dev/ataraid or something (in your initscript). If you
don't have a better idea you can just give it the same name as before.


