Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130492AbQKCPxP>; Fri, 3 Nov 2000 10:53:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130570AbQKCPxG>; Fri, 3 Nov 2000 10:53:06 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:15736 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S130492AbQKCPwx>; Fri, 3 Nov 2000 10:52:53 -0500
Subject: Re: Linux 2.4 Status / TODO page (Updated as of 2.4.0-test10)
To: tytso@mit.edu
Date: Fri, 3 Nov 2000 15:53:34 +0000 (GMT)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <200011031509.eA3F9V719729@trampoline.thunk.org> from "tytso@mit.edu" at Nov 03, 2000 10:09:31 AM
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E13rj9s-0003c4-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>      * Palmax PD1100 hangs during boot since 2.4.0-test9 (Alan Cox)

Fixed in pre10.

>      * AIC7xxx doesnt work non PCI ? (Doug says OK, new version due
>        anyway)

This is now in Justin Gibbs hand but will take time to move on. Doug confirmed
his current code is now merged too.

>      * Check all devices use resources properly (Everyone now has to use
>        request_region and check the return since we no longer single
>        thread driver inits in all module cases. Also memory regions are
>        now requestable and a lot of old drivers dont know this yet. --
>        Alan Cox)

Folks have done most of the common drivers. So its not really a show stopper
now just a 'clean up'

>      * Issue with notifiers that try to deregister themselves? (lnz;
>        notifier locking change by Garzik should backed out, according to
>        Jeff)

and according to Alan

>      * SCSI CD-ROM doesn't work on filesystems with < 2kb block size
>        (Jens Axboe will fix)

SCSI M/O has the same problem. 2.2 can mount MSDOS fs on M/O 2.4test 10 cant.

>      * FAT filesystem doesn't support 2kb sector sizes (did under 2.2.16,
>        doesn't under 2.4.0test7. Kazu Makashima, alan)

This is the same as the SCSI cd rom issue. You can either do reblocking in the
fat layer and other fs's needing it or do it in the scsi code.

>      * Spin doing ioctls on a down netdeice as it unloads == BOOM
>        (prumpf, Alan Cox) Possible other net driver SMP issues (andi
>        kleen)

Turns out to be safe according to Jeff and ANK

> 10. To Do But Non Showstopper
>      * PCMCIA/Cardbus hangs (Basically unusable - Hinds pcmcia code is
>        reliable)
>           + PCMCIA crashes on unloading pci_socket

The pci_socket crash is fixed it seems

>      * Some AWE cards are not being found by ISAPnP ??

You have this one higher up as problems with some SB AWE cards

Alan

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
