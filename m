Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261237AbTILLb5 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 12 Sep 2003 07:31:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261312AbTILLb5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 Sep 2003 07:31:57 -0400
Received: from 81-2-122-30.bradfords.org.uk ([81.2.122.30]:19328 "EHLO
	81-2-122-30.bradfords.org.uk") by vger.kernel.org with ESMTP
	id S261237AbTILLb4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 Sep 2003 07:31:56 -0400
Date: Fri, 12 Sep 2003 12:45:29 +0100
From: John Bradford <john@grabjohn.com>
Message-Id: <200309121145.h8CBjTGg000313@81-2-122-30.bradfords.org.uk>
To: linux-kernel@vger.kernel.org, Roman.Kagan@itep.ru
Subject: Re: Problem: IDE data corruption with VIA chipsets on2.4.20-19.8+others
Cc: R.E.Wolff@BitWizard.nl
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > Anyway, speaking about SMART, some "smartd" was interfering with
> > normal operation on one of our systems and we saw similar "nasty"
> > stuff on that system until I removed "smartd". 
> > 
> > Aug 10 06:54:25 falbala kernel: hda: drive_cmd: status=0x51 { DriveReady SeekComplete Error }
> > Aug 10 06:54:25 falbala kernel: hda: drive_cmd: error=0x04 { DriveStatusError }
> > Aug 10 06:54:25 falbala kernel: hdb: drive_cmd: status=0x51 { DriveReady SeekComplete Error }
> > Aug 10 06:54:25 falbala kernel: hdb: drive_cmd: error=0x04 { DriveStatusError }
> > Aug 10 07:24:25 falbala kernel: hda: drive_cmd: status=0x51 { DriveReady SeekComplete Error }
> > Aug 10 07:24:25 falbala kernel: hda: drive_cmd: error=0x04 { DriveStatusError }
> > Aug 10 07:24:25 falbala kernel: hdb: drive_cmd: status=0x51 { DriveReady SeekComplete Error }
> > Aug 10 07:24:25 falbala kernel: hdb: drive_cmd: error=0x04 { DriveStatusError }
> > Aug 10 08:24:25 falbala kernel: hda: drive_cmd: status=0x51 { DriveReady SeekComplete Error }
> > Aug 10 08:24:25 falbala kernel: hda: drive_cmd: error=0x04 { DriveStatusError }
> > Aug 10 08:24:25 falbala kernel: hdb: drive_cmd: status=0x51 { DriveReady SeekComplete Error }
> > Aug 10 08:24:25 falbala kernel: hdb: drive_cmd: error=0x04 { DriveStatusError }
>
> You probably have SMART disabled on those drives by BIOS, and smartd is
> not smart enough to enable it before trying to use it so the drives
> complain.

Quite possible.

> I had the same problem on my GigaByte mobo where the BIOS
> setup didn't even provide an option to turn SMART on (like earlier Award
> BIOSes did).

For some reason, both of my Gigabyte GA-7VA motherboards seem to
disable SMART when I reboot.

> Check with smartctl -i /dev/hdX.  Enable with smartctl -e /dev/hdX
> _before_ starting smartd.

You may need to use smartctl -e /dev/hdX every time you boot.

John.
