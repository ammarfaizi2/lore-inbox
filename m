Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289926AbSAPNqJ>; Wed, 16 Jan 2002 08:46:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289927AbSAPNqA>; Wed, 16 Jan 2002 08:46:00 -0500
Received: from fs1.ml.kva.se ([130.237.201.20]:46349 "EHLO fs1.ml.kva.se")
	by vger.kernel.org with ESMTP id <S289926AbSAPNpu>;
	Wed, 16 Jan 2002 08:45:50 -0500
Date: Wed, 16 Jan 2002 14:47:36 +0100 (CET)
From: Lukas Geyer <geyer@ml.kva.se>
To: <linux-kernel@vger.kernel.org>
Subject: Two issues with 2.4.18pre3 on PPC
Message-ID: <Pine.LNX.4.33.0201161417540.6868-100000@cauchy.ml.kva.se>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I am very glad that the PPC patches are now merged so I can use a
mainstream kernel again on my iBook. Thanks to all the people who did
this. It works quite fine so far but there are two minor problems:

- The kernel ignores the boot parameter hdb=ide-scsi, it probes hdb anyway
  and loads the ATAPI CD-ROM driver. The problem may be (I am really not
  familiar with the kernel internals) the function pmac_ide_probe() in
  drivers/ide/ide-pmac.c which does not check for any kernel boot
  parameters at all.

- The generic RTC driver in drivers/char/rtc.c does not work for this
  iBook. The driver in drivers/macintosh/rtc.c does work, but it only
  implements the two ioctls RTC_RD_TIME and RTC_SET_TIME. (Is this due to
  hardware limitations?) Anyway, it is confusing to have both drivers
  configurable for PPC, maybe the corresponding Config.in files should be
  adjusted. (In addition, this is complicated by the fact that both
  configuration options appear in different submenus and if you select
  both as modules, then the generic driver will "shadow" the macintosh
  one.)

Lukas


