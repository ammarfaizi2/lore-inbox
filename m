Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270206AbTHJQki (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 10 Aug 2003 12:40:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270219AbTHJQki
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 10 Aug 2003 12:40:38 -0400
Received: from mail.gmx.net ([213.165.64.20]:57041 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S270206AbTHJQkg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 10 Aug 2003 12:40:36 -0400
Subject: [BUG mm-tree of test2/test3] nforce2-acpi-fixes breaks via ide
	controller
From: Benjamin Weber <shawk@gmx.net>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Cc: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>,
       Andrew Morton <akpm@digeo.com>,
       Andrew de Quincey <adq_dvb@lidskialf.net>
Content-Type: text/plain
Message-Id: <1060533632.3886.19.camel@athxp.bwlinux.de>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.3 
Date: 10 Aug 2003 18:40:32 +0200
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all

Since the test2-mm1 sources I get the following error during boot:

VP_IDE: IDE controller at PCI slot 0000:00:11.1
VP_IDE: (ide_setup_pci_device:) Could not enable device.

This results in not being able to use DMA for any devices connected to
my IDE controller. Hdparm says permission denied when I do a hdparm -d1
/dev/hda e.g.

I checked with a vanilla kernel and everything is working fine there.
Going through the broken-out patches from Andrew Morton I found the one
patch that caused the above behavior: nforce2-acpi-fixes.patch

I do not know why it should interfere with my via stuff, but it does. A
vanilla test3 kernel is working fine as well, whereas test3-mm1 shows
the same error as before with test2-mmX.

My board is a ECS K7VTA3 Rev. 5.0. Vanilla Kernel reports the chipset
as:
VP_IDE: VIA vt8235 (rev 00) IDE UDMA133 controller on pci0000:00:11.1

Hope the above information is enough. I can provide more if needed.

--
Benjamin

