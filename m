Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266256AbUAHVig (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 Jan 2004 16:38:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266320AbUAHVif
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 Jan 2004 16:38:35 -0500
Received: from mail0.lsil.com ([147.145.40.20]:5288 "EHLO mail0.lsil.com")
	by vger.kernel.org with ESMTP id S266256AbUAHVid (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 Jan 2004 16:38:33 -0500
Message-ID: <0E3FA95632D6D047BA649F95DAB60E57033BC2A5@exa-atlanta.se.lsil.com>
From: "Mukker, Atul" <Atulm@lsil.com>
To: "'Chris Meadors'" <clubneon@hereintown.net>,
       Christoph Hellwig <hch@infradead.org>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>,
       Linus Torvalds <torvalds@osdl.org>
Subject: RE: [PATCH] LSI Logic MegaRAID3 PCI ID [Was: MegaRAID on AMD64und
	er 2.6.1]
Date: Thu, 8 Jan 2004 16:38:09 -0500 
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2657.72)
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I have not followed this thread completly yet but both
PCI_DEVICE_ID_MEGARAID and PCI_DEVICE_ID_MEGARAID3 are valid and both should
be present. Look for their definitions in the header file or pci_ids.h

Thanks
-Atul Mukker
LSI Logic

> -----Original Message-----
> From: Chris Meadors [mailto:clubneon@hereintown.net]
> Sent: Thursday, January 08, 2004 3:30 PM
> To: Christoph Hellwig
> Cc: Linux Kernel; Linus Torvalds
> Subject: Re: [PATCH] LSI Logic MegaRAID3 PCI ID [Was: MegaRAID on
> AMD64under 2.6.1]
> 
> 
> On Thu, 2004-01-08 at 12:19, Chris Meadors wrote:
> > On Thu, 2004-01-08 at 11:55, Christoph Hellwig wrote:
> > > On Thu, Jan 08, 2004 at 11:51:58AM -0500, Chris Meadors wrote:
> > > > i.e. PCI_VENDOR_ID_LSI_LOGIC, PCI_DEVICE_ID_AMI_MEGARAID3
> > > > 
> > > > When I added the lines for that combination to 
> megaraid_pci_tbl[], the
> > > > driver found the card.  So, I'm cool now.
> > > 
> > > Care to send a patch to Linus to add it?  And my 
> apologies for losing
> > > that entry. 
> > 
> > Sure thing, it is attatched, as I fear the white space mangling
> > abilities of my MUA.
> 
> (Replying to myself with an updated version of the patch, 
> apply this one
> instead.)
> 
> I was wondering how the ID got lost.  I noticed that the file 
> was pretty
> much rewriten (the -rc patch is just a huge number of 
> removes, followed
> by an equally large number of adds).  So I started looking at the two
> files side by side, wondering if any other IDs were missed.  Then I
> think I spotted what happened.  In the -rc patch, there is an ID pair
> for, "PCI_VENDOR_ID_LSI_LOGIC, PCI_DEVICE_ID_AMI_MEGARAID".  Since LSI
> just starting making MegaRAID cards, there would have never been a
> device produced with that ID.  The line I added in my patch 
> was for the
> MEGARAID3.  Looking at the older version of the file showed just as I
> guessed, there wasn't an LSI_LOGIC MEGARAID.  I'm thinking the '3' got
> dropped in the conversion between the old and new files.
> 
> So, attached is a second version of this patch.  Instead of adding a
> totally new PCI ID, I'm just removing the incorrect LSI MEGARAID, and
> replacing it with the LSI MEGARAID3.  I've also diffed 
> against 2.6.1-rc3
> this time (but megaraid.c wasn't touched between -rc2 and 3).
> 
> -- 
> Chris
> 
