Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292294AbSBTUfh>; Wed, 20 Feb 2002 15:35:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292293AbSBTUf0>; Wed, 20 Feb 2002 15:35:26 -0500
Received: from mailhost.teleline.es ([195.235.113.141]:12596 "EHLO
	tsmtp8.mail.isp") by vger.kernel.org with ESMTP id <S292292AbSBTUfN>;
	Wed, 20 Feb 2002 15:35:13 -0500
Date: Wed, 20 Feb 2002 21:37:15 +0100
From: Diego Calleja <diegocg@teleline.es>
To: linux-kernel@vger.kernel.org
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: hang in 2.4.18-rc2-ac1
Message-Id: <20020220213715.0a741080.diegocg@teleline.es>
In-Reply-To: <E16dcvN-0004YR-00@the-village.bc.nu>
In-Reply-To: <20020220192127.622006ff.diegocg@teleline.es>
	<E16dcvN-0004YR-00@the-village.bc.nu>
X-Mailer: Sylpheed version 0.6.6 (GTK+ 1.2.10; i386-debian-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

En Wed, 20 Feb 2002 20:01:09 +0000 (GMT)
Alan Cox <alan@lxorguk.ukuu.org.uk> escribio...:

> > This happened while using X & kde & wine. Kernel 2.4.18-rc2-ac1
> 
> You seem to have non standard kernel modules loaded ?

I use standard kernel. Modules usually loaded while I run kde are: soundcore, sound, sb, sb_lib, opl3, uart401, isa-pnp, apm
tdfx, 
Perhaps usbcore && usb-ohci were loaded, too.
Chipset is SIS 5571, ide chipset SIS 5513. I've some problems with
latest updates about SIS Ide driver update: When I sleep the drive with
hdparm -Y /dev/hda
then the drive sleeps. But it doesn't 'awake'. I can do 'Login: XXX \n Password: XXX' or write a command
in the shell. But when the unit has to read/write, it just does nothing.

Latest kernels without this patch (2.4.18-preX....) did something different:
I could sleep drive normally. But when the system had to read/write something:

Feb 15 18:13:08 localhost kernel: hda: timeout waiting for DMA
Feb 15 18:13:08 localhost kernel: ide_dmaproc: chipset supported ide_dma_timeout func only: 14
Feb 15 18:13:08 localhost kernel: hda: status timeout: status=0xd0 { Busy }
Feb 15 18:13:08 localhost kernel: hda: drive not ready for command
Feb 15 18:13:08 localhost kernel: ide0: reset: success

The system just stopped a few seconds, and then it started as always.

Drive was tuned with hdparm with the following options:
/sbin/hdparm -c3 -A1 -a8 -d1 -m16 -p4 -u1 -W1 -X34 /dev/hda

I'll copy all this about SIS IDE driver in a new post, so all people interested will be able to read about it.





