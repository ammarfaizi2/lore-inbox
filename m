Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S270025AbRHYRkN>; Sat, 25 Aug 2001 13:40:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S270050AbRHYRkD>; Sat, 25 Aug 2001 13:40:03 -0400
Received: from hermes.domdv.de ([193.102.202.1]:24838 "EHLO zeus.domdv.de")
	by vger.kernel.org with ESMTP id <S270025AbRHYRjo>;
	Sat, 25 Aug 2001 13:39:44 -0400
Message-ID: <XFMail.20010825193951.ast@domdv.de>
X-Mailer: XFMail 1.4.6-3 on Linux
X-Priority: 3 (Normal)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
Date: Sat, 25 Aug 2001 19:39:51 +0200 (CEST)
Organization: D.O.M. Datenverarbeitung GmbH
From: Andreas Steinmetz <ast@domdv.de>
To: linux-kernel@vger.kernel.org
Subject: new aic7xxx code in 2.4.9 causes kernel panics
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
please CC me on replies as I'm not subscribed to the list.

The new aix7xxx driver in 2.4.9 panics the system during reboot. This may or
may not be related to the kernel raid code (the system in question runs a small
native ext2 partition for kernels/lilo and all other partitions are ext2/raid1
(autodetect).

What happens during reboot is that after the 'flushing signals' message from
the raid code there was a 20 to 30 second delay, then the new aic7xxx code
complained about 'ABORT' and then caused a kernel panic. This scenario was
reproducable.

Unfortunately I didn't have the time to write down the exact details as I had
to get the system working and did revert to the old aix7xxx code which works
flawlessly.


Andreas Steinmetz
D.O.M. Datenverarbeitung GmbH
