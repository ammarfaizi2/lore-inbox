Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266116AbRF2Qhn>; Fri, 29 Jun 2001 12:37:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266115AbRF2Qhc>; Fri, 29 Jun 2001 12:37:32 -0400
Received: from datafoundation.com ([209.150.125.194]:45584 "EHLO
	datafoundation.com") by vger.kernel.org with ESMTP
	id <S266117AbRF2Qh1>; Fri, 29 Jun 2001 12:37:27 -0400
Date: Fri, 29 Jun 2001 12:37:26 -0400 (EDT)
From: John Jasen <jjasen@datafoundation.com>
To: <linux-kernel@vger.kernel.org>
cc: <gibbs@freebsd.org>, <dima@datafoundation.com>
Subject: problems with aic7xxx driver 6.1.11 (fwd)
Message-ID: <Pine.LNX.4.30.0106291237030.9716-100000@flash.datafoundation.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


---------- Forwarded message ----------
Date: Mon, 25 Jun 2001 11:31:32 -0400 (EDT)
From: John Jasen <jjasen@datafoundation.com>
To: gibbs@freebsd.org
Cc: Dima Meschaninov <dima@datafoundation.com>
Subject: problems with aic7xxx driver 6.1.11


#1) It seems that the new aic7xxx drivers do not detect raid controllers,
et al on the bus, as we have an nStor NexStor 8le that is completely
invisible to your driver.

#2) There seem to be a few problems with the new driver, where it can
easily get confused into a reset loop. (see below for a rough
description)

---------- Forwarded message ----------
Date: Mon, 25 Jun 2001 11:20:08 -0400
From: Dmitry Meshchaninov <dima@datafoundation.com>
To: John Jasen <jjasen@datafoundation.com>
Subject: Description of SCSI situation on zathras

Looks like we have had power down at night. Afterwards, the scsi tray was
in a strange state - the system BIOS didn't find anything on the bus, and
naturally the linux driver didn't either.

After we power cycled scsi tray and rebooted the system, the system BIOS
detected all the scsi devices but the linux driver still was blind.

It said something about timeouts during lun probing and marked all the
devicess offline, and we tried it via reboot/powercycle of the system at
least 2-3 times.

After we setup the old driver everything went fine.


