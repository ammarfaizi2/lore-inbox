Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317346AbSGIJmc>; Tue, 9 Jul 2002 05:42:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317347AbSGIJmb>; Tue, 9 Jul 2002 05:42:31 -0400
Received: from 62-190-201-188.pdu.pipex.net ([62.190.201.188]:53509 "EHLO
	darkstar.example.net") by vger.kernel.org with ESMTP
	id <S317346AbSGIJm3>; Tue, 9 Jul 2002 05:42:29 -0400
From: jbradford@dial.pipex.com
Message-Id: <200207090941.KAA00806@darkstar.example.net>
Subject: Re: ATAPI + cdwriter problem
To: mistral@stev.org (James Stevenson)
Date: Tue, 9 Jul 2002 10:41:29 +0100 (BST)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <016e01c22720$1be7ad80$0cfea8c0@ezdsp.com> from "James Stevenson" at Jul 09, 2002 09:10:36 AM
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

> the other 2 drives are on a different controller not a prmoise its running
> off the motherboard.

Odd, I was positive you were going to say it was the Promise controller to blame :-)

> its a via chipset motherboard which botht the old 2x writer and 44x are on
> the secondary channel
> the whole ide system looks a bit like this.
> hda: IBM-DTTA-351680, ATA DISK drive
> hdb: IBM-DTLA-305040, ATA DISK drive
> hdc: HP CD-Writer+ 7200, ATAPI CD/DVD-ROM drive
> hdd: IDE/ATAPI CD-ROM 44X, ATAPI CD/DVD-ROM drive
> hde: Maxtor 4G160J8, ATA DISK drive
> hdf: Maxtor 4G160J8, ATA DISK drive
> hdg: 32X10, ATAPI CD/DVD-ROM drive

Can't see anything obviously wrong with that setup, but once you get the new CD-writer working, I'd re-arrange things like this:

hda: IBM-DTTA-351680, ATA DISK drive
hdb: IBM-DTLA-305040, ATA DISK drive
hdc: 32X10, ATAPI CD/DVD-ROM drive
hdd: IDE/ATAPI CD-ROM 44X, ATAPI CD/DVD-ROM drive
hde: Maxtor 4G160J8, ATA DISK drive
hdf: Maxtor 4G160J8, ATA DISK drive
not connected: HP CD-Writer+ 7200, ATAPI CD/DVD-ROM drive

Unless you really need 2 CD-Writers available, (in which case, I would suggest moving over to SCSI anyway).

Then you are only using 3 interfaces, and not 4, (which seems 'neater' to me, but you might dis-agree).  I don't think you're likely to see much performace advantage to having the CD-writer on the Promise card, to be honest.  You probably will for the Maxtor, (good choice), hard drives, though.

> i have some time over the next few days so i could try to recreate crash
> and try stuff.

That might help, as I can't think of anything else to suggest off hand.

John.
