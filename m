Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265019AbTFXAOi (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 Jun 2003 20:14:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265329AbTFXAOh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 Jun 2003 20:14:37 -0400
Received: from mion.elka.pw.edu.pl ([194.29.160.35]:47043 "EHLO
	mion.elka.pw.edu.pl") by vger.kernel.org with ESMTP id S265019AbTFXAOg
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 Jun 2003 20:14:36 -0400
Date: Tue, 24 Jun 2003 02:28:16 +0200 (MET DST)
From: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
To: Tobias Diedrich <ranma@gmx.at>
cc: <linux-kernel@vger.kernel.org>
Subject: Re: WDC HD found, but ignored?
In-Reply-To: <20030623231436.GA5612@melchior.yamamaya.is-a-geek.org>
Message-ID: <Pine.SOL.4.30.0306240218090.29691-100000@mion.elka.pw.edu.pl>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Yes, its really weird, you added "hdc=ide-scsi" to command line :-).
Anyway ide driver should detect such user errors...
--
Bartlomiej

On Tue, 24 Jun 2003, Tobias Diedrich wrote:

> This is a really weird case.
> The kernel (2.4.21-ac2) finds the hard disk (WDC WD1800JB-00DUA0), but
> does not attach the ide-disk driver (No error message). The following
> partition check fails with I/O error on sector 0. Attempts to access the
> disk (In this case hdc) on the booted system result in the kernel trying
> to load the ide-disk module, which fails because it is compiled in.
> The works fine in this configuration when booting the W2K partition.
>
> I hope someone has an idea on what is going wrong here.
> Please CC me on replies as I am not subscribed to the list at the
> moment.
> Kernel boot log:

<...>

> Kernel command line: root=/dev/hda1 vga=ext parport=auto hdc=ide-scsi
> ide_setup: hdc=ide-scsi

<...>

> hdc: WDC WD1800JB-00DUA0, ATA DISK drive
> hdd: RICOH CD-R/RW MP7200A, ATAPI CD/DVD-ROM drive

<...>

