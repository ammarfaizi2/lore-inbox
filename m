Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266677AbUAWT4j (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 23 Jan 2004 14:56:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266679AbUAWT4j
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 23 Jan 2004 14:56:39 -0500
Received: from mail2-116.ewetel.de ([212.6.122.116]:61321 "EHLO
	mail2.ewetel.de") by vger.kernel.org with ESMTP id S266677AbUAWT4h
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 23 Jan 2004 14:56:37 -0500
Date: Fri, 23 Jan 2004 20:56:33 +0100 (CET)
From: Pascal Schmidt <der.eremit@email.de>
To: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] make ide-cd handle non-2kB sector sizes
In-Reply-To: <Pine.LNX.4.55.0401232006480.3223@jurand.ds.pg.gda.pl>
Message-ID: <Pine.LNX.4.44.0401232054060.1178-100000@neptune.local>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-CheckCompat: OK
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 23 Jan 2004, Maciej W. Rozycki wrote:

> So that's just opposite to what ide-cd does, but I think ide-cd should be
> limited to CD-like devices with their all properties (oddities).  

When I brought up the issue a few months back, the consensus was to
use ide-cd, not ide-floppy.

> Specifically you can do random writes to an MO disk, perhaps even format
> it, which is usually not the case with CDs.

ide-cd also handles DVD-RAM, which can also handle random writes.

> BTW, what does ide-scsi say of the device type for the MO: is it "CD-ROM"  
> or "Direct-Access" or anything else?  I used an MO drive (a SCSI one --
> nobody was crazy enough to think of an ATAPI interface for that kinds of
> devices at that time) for a short while under Linux once and it used to be
> the latter, with sd, not sr being the appropriate driver.

On 2.4:

scsi0 : SCSI host adapter emulation for IDE ATAPI devices
  Vendor: FUJITSU   Model: M25-MCC3064AP     Rev: 0051
  Type:   Optical Device                     ANSI SCSI revision: 02

And yes, this uses the sd driver.

-- 
Ciao,
Pascal

