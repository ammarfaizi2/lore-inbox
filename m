Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268483AbUHaNuQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268483AbUHaNuQ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 31 Aug 2004 09:50:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268473AbUHaNuQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 31 Aug 2004 09:50:16 -0400
Received: from astound-64-85-224-245.ca.astound.net ([64.85.224.245]:28432
	"EHLO master.linux-ide.org") by vger.kernel.org with ESMTP
	id S268498AbUHaNtZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 31 Aug 2004 09:49:25 -0400
Date: Tue, 31 Aug 2004 06:45:16 -0700 (PDT)
From: Andre Hedrick <andre@linux-ide.org>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
cc: Rogier Wolff <R.E.Wolff@harddisk-recovery.nl>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       linux-ide@vger.kernel.org
Subject: Re: Driver retries disk errors.
In-Reply-To: <1093952715.32684.12.camel@localhost.localdomain>
Message-ID: <Pine.LNX.4.10.10408310643290.26528-100000@master.linux-ide.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Rogier,

Because the command layer states to execute retries, regardless.
Modern drives now convert read-once to retry.
You need special opcodes to revert to desired status.

Media forensics is not a cake walk.

Andre Hedrick
LAD Storage Consulting Group

On Tue, 31 Aug 2004, Alan Cox wrote:

> On Llu, 2004-08-30 at 17:39, Rogier Wolff wrote:
> > We encounter "bad" drives with quite a lot more regularity than other
> > people (look at the Email address). We're however, wondering why the
> > IDE code still retries a bad block 8 times? By the time the drive
> > reports "bad block" it has already tried it several times, including a
> > bunch of "recalibrates" etc etc. For comparison, the Scsi-disk driver
> > doesn't do any retrying.
> 
> It helps for some things like magneto-opticals. For generic hard drives
> its only relevant for older devices.
> 
> > (*) Note: Tested last month: The driver still works for MFM
> > drives. However, the initialization apparently is not enough
> > anymore. The drive did not work when the BIOS didn't think there was a
> > drive.
> 
> Please file a bug report if 2.6 also shows that problem.
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 

