Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161120AbVKYPoj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161120AbVKYPoj (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 25 Nov 2005 10:44:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161121AbVKYPoj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 25 Nov 2005 10:44:39 -0500
Received: from viruswall.astrium.eads.net ([194.203.13.70]:21516 "EHLO
	viruswall.astrium.eads.net") by vger.kernel.org with ESMTP
	id S1161120AbVKYPoi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 25 Nov 2005 10:44:38 -0500
Message-ID: <C2D16922D674664C9CCA61127AC9B77B03E105@auk52177.ukr.astrium.corp>
From: "SMALL, Timothy" <timothy.small@astrium.eads.net>
To: "'Alan Cox'" <alan@lxorguk.ukuu.org.uk>, linux-ide@vger.kernel.org,
       linux-kernel@vger.kernel.org
Subject: RE: Assorted bugs in the PIIX drivers
Date: Fri, 25 Nov 2005 15:44:22 -0000
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2650.21)
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


This looks like the MPIIX datasheet:

http://www.mit.edu/afs/sipb/contrib/doc/specs/unfiled/i82371MX.pdf

Also, may or may not want to bother with looking at supporting another chip
- the never-actually-released-by-Intel i82600 integrated single chip
north/south bridge.  This chipset design (can you still call it a chipset if
it only has one chip?) is licensed from Intel, and sold by Radisys.  The
docs are here:

http://www.radisys.com/service_support/tech_solutions/techsupportlib_detail.
cfm?ProductID=1262

I have it working fine with the ide/pci driver in PIO, and UDMA, but not
MDMA modes, but haven't had a chance to revisit it, but it is on my TODO
list...

Tim.


> -----Original Message-----
> From: Alan Cox [mailto:alan@lxorguk.ukuu.org.uk] 
> Sent: Friday, November 25, 2005 2:43 PM
> To: linux-ide@vger.kernel.org; linux-kernel@vger.kernel.org
> Subject: Assorted bugs in the PIIX drivers
> 
> 
> I finally got all the documents rounded up to try and redo 
> Jgarzik's PIIX driver a bit more completely (I'm short MPIIX 
> if anyone has it ?)
> 
> I then started reading the docs and the code and noticing a 
> couple of problems
> 
> 1.	We set IE1 on PIO0-2 which the docs say is for PIO3+
> 
> 2.	The ata_piix one (but not the ide/pci one) have shifts 
> wrong so that
> the secondary slave timings are half loaded into the primary slave
> 
> 
> I'm also not clear if the "no MWDMA0" list has been updated 
> correctly for the newer chipsets.
> 
> I've yet to review the DMA programming, just the PIO so far.
> 
> -
> To unsubscribe from this list: send the line "unsubscribe 
> linux-ide" in the body of a message to 
> majordomo@vger.kernel.org More majordomo info at  
> http://vger.kernel.org/majordomo-info.html
> 

This email is for the intended addressee only.
If you have received it in error then you must not use, retain, disseminate or otherwise deal with it.
Please notify the sender by return email.
The views of the author may not necessarily constitute the views of EADS Astrium Limited.
Nothing in this email shall bind EADS Astrium Limited in any contract or obligation.

EADS Astrium Limited, Registered in England and Wales No. 2449259
Registered Office: Gunnels Wood Road, Stevenage, Hertfordshire, SG1 2AS, England
