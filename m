Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S272197AbRIJX44>; Mon, 10 Sep 2001 19:56:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S272199AbRIJX4u>; Mon, 10 Sep 2001 19:56:50 -0400
Received: from hermes.domdv.de ([193.102.202.1]:23558 "EHLO zeus.domdv.de")
	by vger.kernel.org with ESMTP id <S272198AbRIJX4g>;
	Mon, 10 Sep 2001 19:56:36 -0400
Message-ID: <XFMail.20010911015634.ast@domdv.de>
X-Mailer: XFMail 1.4.6-3 on Linux
X-Priority: 3 (Normal)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
Date: Tue, 11 Sep 2001 01:56:34 +0200 (CEST)
Organization: D.O.M. Datenverarbeitung GmbH
From: Andreas Steinmetz <ast@domdv.de>
To: linux-kernel@vger.kernel.org
Subject: reboot notifier priority definitions
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

As a suggestion to prevent further shutdown/reboot notifier processing problems
here's a (crude) attempt of definitions for include/linux/notifier.h. I do
believe it needs to be heavily reworked by someone with a broad kernel overview.

#define NOTIFY_REBOOT_PHYSICAL    0x00 /* scsi */
#define NOTIFY_REBOOT_LOGICAL     0x10 /* md, lvm */
#define NOTIFY_REBOOT_FS          0x20 /* knfsd */
#define NOTIFY_REBOOT_APPLICATION 0x30 /* tux */

The current situation of not having such definitions already did lead to a
kernel oops (md<->scsi). I do fear that if such definitions are not introduced:

1. code maintainers will strictly stick to priority 0 or will use random
   and not interoperable priorities

2. more and more interference problems will arise due to the above point


Andreas Steinmetz
D.O.M. Datenverarbeitung GmbH
