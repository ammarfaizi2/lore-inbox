Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267796AbTAHJ4v>; Wed, 8 Jan 2003 04:56:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267798AbTAHJ4u>; Wed, 8 Jan 2003 04:56:50 -0500
Received: from louise.pinerecords.com ([213.168.176.16]:1408 "EHLO
	louise.pinerecords.com") by vger.kernel.org with ESMTP
	id <S267796AbTAHJ4s>; Wed, 8 Jan 2003 04:56:48 -0500
Date: Wed, 8 Jan 2003 11:05:09 +0100
From: Tomas Szepe <szepe@pinerecords.com>
To: "Justin T. Gibbs" <gibbs@scsiguy.com>
Cc: dipankar@in.ibm.com, linux-scsi@vger.kernel.org,
       linux-kernel@vger.kernel.org
Subject: Re: aic7xxx broken in 2.5.53/54 ?
Message-ID: <20030108100509.GA229@louise.pinerecords.com>
References: <20030103101618.GB8582@in.ibm.com> <596830816.1041606846@aslan.scsiguy.com> <20030106073204.GA1875@in.ibm.com> <274040000.1041869813@aslan.scsiguy.com> <20030108024107.GA1127@louise.pinerecords.com> <703940000.1041999784@aslan.btc.adaptec.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <703940000.1041999784@aslan.btc.adaptec.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> [gibbs@scsiguy.com]
> 
> > [gibbs@scsiguy.com]
> > 
> > These reads are actually more expensive than just using PIO.  Neither of
> > these older drivers included a test to try and catch fishy behavior.
> > 
> > Justin, are you quite sure that these tests actually work?
> > I too have just run into
> 
> See my recent post to the SCSI list.  The tests don't work on
> certain older controllers that lack a feature I was using.  The
> latest csets submitted to Linus correct this problem (as verified
> on a dusty dual P-90 PCI/EISA box just added to our regression cluster).

Ok.  I can confirm 6.2.26 fixes the false positive here:

PCI: Found IRQ 11 for device 00:10.0
PCI: Found IRQ 10 for device 00:11.0
scsi0 : Adaptec AIC7XXX EISA/VLB/PCI SCSI HBA DRIVER, Rev 6.2.26
        <Adaptec 2940 Ultra SCSI adapter>
        aic7880: Ultra Single Channel A, SCSI Id=7, 16/253 SCBs

scsi1 : Adaptec AIC7XXX EISA/VLB/PCI SCSI HBA DRIVER, Rev 6.2.26
        <Adaptec 2940 Ultra SCSI adapter>
        aic7880: Ultra Single Channel A, SCSI Id=7, 16/253 SCBs

Thanks,
-- 
Tomas Szepe <szepe@pinerecords.com>
