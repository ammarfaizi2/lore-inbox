Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S272158AbRIJXYk>; Mon, 10 Sep 2001 19:24:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S272124AbRIJXYa>; Mon, 10 Sep 2001 19:24:30 -0400
Received: from hermes.domdv.de ([193.102.202.1]:3589 "EHLO zeus.domdv.de")
	by vger.kernel.org with ESMTP id <S272164AbRIJXYM>;
	Mon, 10 Sep 2001 19:24:12 -0400
Message-ID: <XFMail.20010911012400.ast@domdv.de>
X-Mailer: XFMail 1.4.6-3 on Linux
X-Priority: 3 (Normal)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
Date: Tue, 11 Sep 2001 01:24:00 +0200 (CEST)
Organization: D.O.M. Datenverarbeitung GmbH
From: Andreas Steinmetz <ast@domdv.de>
To: neilb@cse.unsw.edu.au
Subject: raid reboot notifier priority causes reboot oops
Cc: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
just sorted this out:
the raid code uses a reboot notifier of 0 which badly interferes with scsi
drivers using the same reboot notifier priority. This may (and does) cause scsi
to shut down prior to raid. A sensible value >0 is required for the raid reboot
notifier priority to prevent this.


Andreas Steinmetz
D.O.M. Datenverarbeitung GmbH
