Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135595AbRD1Snq>; Sat, 28 Apr 2001 14:43:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135596AbRD1SnZ>; Sat, 28 Apr 2001 14:43:25 -0400
Received: from 3jane.ashpool.org ([195.24.172.2]:63250 "EHLO 3jane.ashpool.org")
	by vger.kernel.org with ESMTP id <S135595AbRD1SnW>;
	Sat, 28 Apr 2001 14:43:22 -0400
Date: Sat, 28 Apr 2001 20:47:47 +0200 (CEST)
From: poptix <poptix@poptix.net>
X-X-Sender: <poptix@3jane.ashpool.org>
To: <linux-kernel@vger.kernel.org>
Subject: Re: 2.4.3 2.4.4pre8: aic7xxx showstopper bug fails to detect sda
In-Reply-To: <20010428203143.A27784@oisec.net>
Message-ID: <Pine.LNX.4.33.0104282039410.444-100000@3jane.ashpool.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Howdy,

	I've got an "Adaptec AHA-2940UW Pro Ultra SCSI host adapter" using
the aic7xxx driver (the new one, not the old one), and have had no
problems, I have a zip drive on ID5, and a 12X Smart & Friendly CD-RW on
ID6, haven't had any problems on 2.4.3-ac14, or 2.4.4, just an FYI.

				Matthew S. Hallacy

> Getting the same errors here, but only a few seconds after my adaptec gets initialized and all disks/cdrs/zips get attached + mounted. On 2.4.3-ac14 it only gives these errors and happily runs afterwards. But on 2.4.4 it panics after $random time.
>
> My setup is a P2B-S motherboard with a Quantum Fireball ST 6.4 GB HDD
>
> scsi0 : Adaptec AIC7XXX EISA/VLB/PCI SCSI HBA DRIVER, Rev 6.1.11
>         <Adaptec aic7890/91 Ultra2 SCSI adapter>
>         aic7890/91: Wide Channel A, SCSI Id=7, 32/255 SCBs
>
>  Vendor: QUANTUM   Model: FIREBALL ST6.4S   Rev: 0F0C
>  Type:   Direct-Access                      ANSI SCSI revision: 02
>  (scsi0:A:0): 20.000MB/s transfers (20.000MHz, offset 15)
>
> And the specific errors are
>
> scsi0:0:0:0: Attempting to queue a TARGET RESET message
> scsi0:0:0:0: Command not found
> aic7xxx_dev_reset returns 8194
> Device not ready.  Make sure there is a disc in the drive.
>
> > Then, the Kernel detects the SECOND SCSI disk and attaches it as sda
> > (Linux 2.2 would mount that as sdb), the first disk is "gone" (Linux 2.2
> > would mount that as sda).  Regretfully, my root partition is on the
> > FIRST SCSI disk, so the kernel panicks since it cannot mount /.
> >
> > That's all I copied in a hurry, maybe it's sufficient to debug, if not,
> > I can try to grab a null modem cable and catch the full sequence; I'd be
> > glad if someone could mention the "canonical" aic7xxx LILO append
> > parameters for a full debug trace in that case.

