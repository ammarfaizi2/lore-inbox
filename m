Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S273940AbRIXPkg>; Mon, 24 Sep 2001 11:40:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S273950AbRIXPk1>; Mon, 24 Sep 2001 11:40:27 -0400
Received: from smtp.mediascape.net ([212.105.192.20]:19974 "EHLO
	smtp.mediascape.net") by vger.kernel.org with ESMTP
	id <S273940AbRIXPkL>; Mon, 24 Sep 2001 11:40:11 -0400
Message-ID: <3BAF53A0.8D82A87B@mediascape.de>
Date: Mon, 24 Sep 2001 17:39:12 +0200
From: Olaf Zaplinski <o.zaplinski@mediascape.de>
X-Mailer: Mozilla 4.77 [de] (X11; U; Linux 2.4.10-pre15 i686)
X-Accept-Language: de, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: AIC7xxx errors (again) with 2.4.10pre15
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

my software RAID1 (hda1+sda1) worked fine with the current aic7xxx driver
when using 2.4.10pre13, but with 2.4.10pre15 I get the old behaviour I know
from 2.4.9:

Sep 24 17:05:24 binky kernel: scsi0:0:0:0: Attempting to queue an ABORT
message
Sep 24 17:05:24 binky kernel: (scsi0:A:0:0): Queuing a recovery SCB
Sep 24 17:05:24 binky kernel: scsi0:0:0:0: Device is disconnected,
re-queuing SCB
Sep 24 17:05:24 binky kernel: Recovery code sleeping
Sep 24 17:05:24 binky kernel: (scsi0:A:0:0): Abort Tag Message Sent
Sep 24 17:05:29 binky kernel: Recovery code awake
Sep 24 17:05:29 binky kernel: Timer Expired
Sep 24 17:05:29 binky kernel: aic7xxx_abort returns 8195
Sep 24 17:05:29 binky kernel: scsi0:0:0:0: Attempting to queue an ABORT
message
Sep 24 17:05:29 binky kernel: scsi0:0:0:0: Command found on device queue
Sep 24 17:05:29 binky kernel: aic7xxx_abort returns 8194
[...]
Sep 24 17:16:03 binky kernel: scsi0:0:0:0: Attempting to queue an ABORT
message
Sep 24 17:16:03 binky kernel: scsi0:0:0:0: Command found on device queue
Sep 24 17:16:03 binky kernel: aic7xxx_abort returns 8194

Just as with 2.4.9, the "fix" is to use the "old AIC" driver - or not to use
software RAID.

Olaf
