Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266658AbUAWTTV (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 23 Jan 2004 14:19:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266657AbUAWTSi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 23 Jan 2004 14:18:38 -0500
Received: from jurand.ds.pg.gda.pl ([153.19.208.2]:65461 "EHLO
	jurand.ds.pg.gda.pl") by vger.kernel.org with ESMTP id S266658AbUAWTR3
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 23 Jan 2004 14:17:29 -0500
Date: Fri, 23 Jan 2004 20:17:27 +0100 (CET)
From: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
To: Pascal Schmidt <der.eremit@email.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] make ide-cd handle non-2kB sector sizes
In-Reply-To: <Pine.LNX.4.44.0401232002280.1069-100000@neptune.local>
Message-ID: <Pine.LNX.4.55.0401232006480.3223@jurand.ds.pg.gda.pl>
References: <Pine.LNX.4.44.0401232002280.1069-100000@neptune.local>
Organization: Technical University of Gdansk
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 23 Jan 2004, Pascal Schmidt wrote:

> > Hmm, given MO is a removable direct access device, I'd suppose ide-floppy
> > would be used as the handling driver similarly to the Zip drive, wouldn't
> > it?
> 
> No, ide-floppy refuses to use media with larger sectors than 512 bytes.

 So that's just opposite to what ide-cd does, but I think ide-cd should be
limited to CD-like devices with their all properties (oddities).  
Specifically you can do random writes to an MO disk, perhaps even format
it, which is usually not the case with CDs.

 BTW, what does ide-scsi say of the device type for the MO: is it "CD-ROM"  
or "Direct-Access" or anything else?  I used an MO drive (a SCSI one --
nobody was crazy enough to think of an ATAPI interface for that kinds of
devices at that time) for a short while under Linux once and it used to be
the latter, with sd, not sr being the appropriate driver.

-- 
+  Maciej W. Rozycki, Technical University of Gdansk, Poland   +
+--------------------------------------------------------------+
+        e-mail: macro@ds2.pg.gda.pl, PGP key available        +
