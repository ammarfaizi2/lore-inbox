Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314504AbSDZXXJ>; Fri, 26 Apr 2002 19:23:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314525AbSDZXXI>; Fri, 26 Apr 2002 19:23:08 -0400
Received: from dial249.pm3abing3.abingdonpm.naxs.com ([216.98.75.249]:6574
	"EHLO ani.animx.eu.org") by vger.kernel.org with ESMTP
	id <S314504AbSDZXXH>; Fri, 26 Apr 2002 19:23:07 -0400
Date: Fri, 26 Apr 2002 19:30:19 -0400
From: Wakko Warner <wakko@animx.eu.org>
To: "Jeff V. Merkey" <jmerkey@vger.timpanogas.org>
Cc: "Randy.Dunlap" <rddunlap@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: 160gb disk showing up as 137gb
Message-ID: <20020426193019.C8578@animx.eu.org>
In-Reply-To: <20020426171836.A3160@animx.eu.org> <Pine.LNX.4.33L2.0204261416040.14014-100000@dragon.pdx.osdl.net> <20020426163445.A16100@vger.timpanogas.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 0.95.3i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> If you are using a 3Ware adapter, you will need to upgrade 
> the firmware to enable 48 bit lba.  Ditto other RAID controllers.

It's not on a raid controller.  The machine has a PIIX3 ide controller and a
AHA-2940UW scsi controller.  Both exibit the same problem.

> > | Just bought a maxtor 160gb disk and it shows upt as a 137gb disk.  I thought
> > | this might be the system board's ide chipset limitation so I put a scsi->ide
> > | adapter on the drive.  Same situation occurs.  I'm looking at what the kernel
> > | reports when it finds the drive.  /proc/partitions shows this drive as:
> > |    8     0  134217727 sda
> > | /proc/scsi/scsi shows:
> > | Attached devices:
> > | Host: scsi0 Channel: 00 Id: 00 Lun: 00
> > |   Vendor: Maxtor 4 Model: G160J8           Rev: GAK8
> > |   Type:   Direct-Access                    ANSI SCSI revision: 02
> > |
> > | I tried kernel 2.4.14 and 2.4.18.  Any ideas?
> > 
> > Hi,
> > 
> > There was a thread on this 2-3 months back.
> > IDE in 2.4 doesn't have a 48-bit block address interface IIRC,
> > although Andre has some patches for this.
> > This is necessary to go above 137 GB.
> > 
> > -- 
> > ~Randy
> > 
> > -
> > To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> > the body of a message to majordomo@vger.kernel.org
> > More majordomo info at  http://vger.kernel.org/majordomo-info.html
> > Please read the FAQ at  http://www.tux.org/lkml/
-- 
 Lab tests show that use of micro$oft causes cancer in lab animals
