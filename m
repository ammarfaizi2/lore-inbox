Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265734AbTF2R6i (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 29 Jun 2003 13:58:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265736AbTF2R6i
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 29 Jun 2003 13:58:38 -0400
Received: from 81-2-122-30.bradfords.org.uk ([81.2.122.30]:15746 "EHLO
	81-2-122-30.bradfords.org.uk") by vger.kernel.org with ESMTP
	id S265734AbTF2R6f (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 29 Jun 2003 13:58:35 -0400
Date: Sun, 29 Jun 2003 19:21:30 +0100
From: John Bradford <john@grabjohn.com>
Message-Id: <200306291821.h5TILUbl001109@81-2-122-30.bradfords.org.uk>
To: fsdeveloper@yahoo.de, linux-kernel@vger.kernel.org
Subject: Re: IDE-disk spindown fails
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> I have a problem spinning down my Western Digital 80GB harddisk.
> root@server:~> cat /proc/ide/hdc/model =20
> WDC WD800BB-00CAA1
>
> Neither hdparm -S nor noflushd is able to spin down this disk.

I've seen disks that don't spin down when set with a timeout using
hdparm -S, that do spin down when given an hdparm -y command,
(I.E. they spin down immediately).

Does hdparm -y cause your disk to spin down?

> The machine is a very old Pentium 1 machine. It's BIOS doesn't
> recognize this new (I've bought it a few days ago) harddisk.
> So I've set this IDE-channel to "none" in the BIOS to avoid
> very long searches on this channel from BIOS while booting.

Good idea.

> Reading and writing on the disk works quite fine.

Good.

> /dev/hda is the drive, the system is installed on.
> It's a very old 2GB Quantum drive.
> root@server:~> cat /proc/ide/hda/model=20
> QUANTUM FIREBALL_TM2110A
>
> The BIOS recognizes it and I'm able to spindown it.
>
>
> Does linux depend on the BIOS when spinning down?

No.

> root@server:~> cat /proc/version=20
> Linux version 2.4.21 (mb@lfs) (gcc-Version 3.3.1 20030519 (prerelease))=
>  #2 Son Jun 15 13:08:42 CEST 2003
>
> If you want me to run any tests on the machine, or if you
> want some information, I've not given, just ask, please.

Test whether hdparm -y works - it should spin the disk down
immediately.

John.
