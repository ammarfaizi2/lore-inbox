Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262580AbUAHApd (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 Jan 2004 19:45:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262705AbUAHApc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 Jan 2004 19:45:32 -0500
Received: from brokedown.net ([24.107.146.40]:947 "EHLO brokedown.net")
	by vger.kernel.org with ESMTP id S262580AbUAHAp3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 Jan 2004 19:45:29 -0500
Subject: PSYCHO0 PBMA: PCI streaming byte hole error asserted. 2.4.24
From: Josh Grebe <josh@brokedown.net>
To: linux-kernel@vger.kernel.org
Message-Id: <1073522727.3421.1.camel@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.4.5 
Date: Wed, 07 Jan 2004 18:45:28 -0600
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi All,

I'm getting a log message of:

PSYCHO0 PBMA: PCI streaming byte hole error asserted.

Pretty frequently. So frequently in fact, that I think it may be logging
one every packet that crosses my gigabit network card.  I have an E450
with two Intel E1000 cards in it, here is my lspci (sorry for bad
formatting):

00:00.0 Host bridge: Sun Microsystems Computer Corp. Psycho PCI Bus
Module
01:00.0 Host bridge: Sun Microsystems Computer Corp. Psycho PCI Bus
Module
02:00.0 Host bridge: Sun Microsystems Computer Corp. Psycho PCI Bus
Module
03:00.0 Host bridge: Sun Microsystems Computer Corp. Psycho PCI Bus
Module
03:01.0 Ethernet controller: Intel Corp. 82542 Gigabit Ethernet
Controller (rev 03)
04:00.0 Host bridge: Sun Microsystems Computer Corp. Psycho PCI Bus
Module
04:01.0 Bridge: Sun Microsystems Computer Corp. EBUS (rev 01)
04:01.1 Ethernet controller: Sun Microsystems Computer Corp. Happy Meal
(rev 01)
04:02.0 SCSI storage controller: LSI Logic / Symbios Logic 53c875 (rev
03)
04:03.0 SCSI storage controller: LSI Logic / Symbios Logic 53c875 (rev
03)
04:04.0 Display controller: 3DLabs Permedia II 2D+3D (rev 01)
05:00.0 Host bridge: Sun Microsystems Computer Corp. Psycho PCI Bus
Module
05:01.0 PCI bridge: Digital Equipment Corporation DECchip 21154 (rev 05)
06:04.0 Ethernet controller: Intel Corp. 82557/8/9 [Ethernet Pro 100]
(rev 08)
06:05.0 Ethernet controller: Intel Corp. 82557/8/9 [Ethernet Pro 100]
(rev 08)
06:06.0 Ethernet controller: Intel Corp. 82542 Gigabit Ethernet
Controller (rev 03)



This machine is a quad 400mhz box, with one gig interface to the
internet and one
to a netapp filer. I am running kernel 2.4.24. This problem started when
I added
a second e1000 card to it earlier today. My startup messages for the
detection
of the e1000 cards:

Jan  7 15:44:16 syslogger Intel(R) PRO/1000 Network Driver - version
5.2.20-k1
Jan  7 15:44:16 syslogger Copyright (c) 1999-2003 Intel Corporation.
Jan  7 15:44:16 syslogger eth3: Dropping NETIF_F_SG since no checksum
feature.
Jan  7 15:44:16 syslogger eth3: Intel(R) PRO/1000 Network Connection
Jan  7 15:44:16 syslogger eth4: Dropping NETIF_F_SG since no checksum
feature.
Jan  7 15:44:16 syslogger eth4: Intel(R) PRO/1000 Network Connection



Any thoughts? I searched the archives and google and didn't come up with
anything.

Thanks,

Josh



