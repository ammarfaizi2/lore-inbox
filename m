Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S270711AbRHTL22>; Mon, 20 Aug 2001 07:28:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S270741AbRHTL2R>; Mon, 20 Aug 2001 07:28:17 -0400
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:55302 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S270711AbRHTL2E>; Mon, 20 Aug 2001 07:28:04 -0400
Subject: Re: [2.4.8-ac5 and earlier] fatal mount-problem
To: viro@math.psu.edu (Alexander Viro)
Date: Mon, 20 Aug 2001 12:30:23 +0100 (BST)
Cc: andihartmann@freenet.de (Andreas Hartmann),
        linux-kernel@vger.kernel.org (Kernel-Mailingliste)
In-Reply-To: <Pine.GSO.4.21.0108200602010.1313-100000@weyl.math.psu.edu> from "Alexander Viro" at Aug 20, 2001 06:03:20 AM
X-Mailer: ELM [version 2.5 PL5]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E15YnGB-0005sr-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > (as modules) and you do the same mount again on the same (not unmounted)
> > device, the mount-programm hangs up and never comes back. It doesn't
> > recognize, that the device is allready mounted.
> 
> strace, please. -ac5 and 2.4.9 have the same code in fs/super.c, so
> I really wonder what the hell is happening...

Duplicated here with 2.4.8-ac6
Booted with ide-scsi as the cd driver

mount /dev/scd0 /mnt
umount /dev/scs0
mount /dev/scd0 /mnt
umount /dev/scd0

works fine

mount /dev/scd0 /mnt
mount /dev/scd0 /mmt

hangs (D state)

mount /dev/scd0 /mnt
mount /dev/scd0 /tmp

hangs (D state)

