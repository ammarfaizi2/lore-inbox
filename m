Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261514AbULIMyA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261514AbULIMyA (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Dec 2004 07:54:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261516AbULIMyA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Dec 2004 07:54:00 -0500
Received: from zone4.gcu-squad.org ([213.91.10.50]:250 "EHLO
	zone4.gcu-squad.org") by vger.kernel.org with ESMTP id S261514AbULIMx6 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Dec 2004 07:53:58 -0500
Date: Thu, 9 Dec 2004 13:53:04 +0100 (CET)
To: linux-kernel@vger.kernel.org
Subject: checksum in (i2c) eeprom driver
X-IlohaMail-Blah: khali@localhost
X-IlohaMail-Method: mail() [mem]
X-IlohaMail-Dummy: moo
X-Mailer: IlohaMail/0.8.13 (On: webmail.gcu.info)
Message-ID: <lNsWdTVB.1102596784.6279250.khali@localhost>
From: "Jean Delvare" <khali@linux-fr.org>
Bounce-To: "Jean Delvare" <khali@linux-fr.org>
CC: LM Sensors <sensors@stimpy.netroedge.com>, Greg KH <greg@kroah.com>,
       Deepak Saxena <dsaxena@plexity.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi all,

Any objection to me removing the checksumming code from the (i2c) eeprom
driver? Deepak had suggested we should do so a long time ago [1], and I
fully agree with his position. The checksum is application-specific and
verifying it doesn't belong to the kernel-space. The checksumming code
we (optionally) use at the moment only covers memory module EEPROMs as
far as I know, while EEPROMs exposed on I2C/SMBus may be of a variety of
other natures.

[1] http://archives.andrew.net.au/lm-sensors/msg21194.html

Thanks,
--
Jean Delvare
