Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266397AbTGEQno (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 5 Jul 2003 12:43:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266400AbTGEQno
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 5 Jul 2003 12:43:44 -0400
Received: from 66-75-253-176.san.rr.com ([66.75.253.176]:640 "EHLO mackman.net")
	by vger.kernel.org with ESMTP id S266397AbTGEQnn (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 5 Jul 2003 12:43:43 -0400
Date: Sat, 5 Jul 2003 09:58:06 -0700 (PDT)
From: Ryan Mack <lists@mackman.net>
X-X-Sender: rmack@mackman.net
To: Markus Plail <linux-kernel@gitteundmarkus.de>
cc: linux-kernel@vger.kernel.org
Subject: Re: 2.4.21 ServerWorks DMA Bugs
In-Reply-To: <87fzllh21i.fsf@gitteundmarkus.de>
Message-ID: <Pine.LNX.4.53.0307050956060.2029@mackman.net>
References: <Pine.LNX.4.53.0307042325430.3837@mackman.net>
 <87fzllh21i.fsf@gitteundmarkus.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

That at least explains the lack of DMA, but why does non-DMA IO result in 
such significant clock skew?

Also, does anybody know what the status of the failure to recognize higher 
UDMA modes on the CSB5 chipset?  Is there a working patch out there?

Thanks again, Ryan

On Sat, 5 Jul 2003, Markus Plail wrote:

> On Fri, 4 Jul 2003, Ryan Mack wrote:
> 
> > I've real the other threads but nothing touches on my specific issue.
> > I have a dual P4 Xeon Dell PowerEdge 1600SC with a Fusion MPT SCSI
> > controller and a ServerWorks CSB5 IDE chipset.  All the HDs are on the
> > SCSI bus, and only my CD reader and my DVD writer are on the IDE bus
> > (one on each channel).  Hyperthreading is enabled (4 logical
> > processors).  I am using GCC 3.2.2.
> > 
> > The CD readers is the blacklisted 'SAMSUNG CD-ROM SC-148C' and I never
> > use it so I can remove it if needed.  The DVD writer is a 'SONY DVD RW
> > DRU-500A'.  Both are going through the ide-scsi driver.  Whenever I
> > read/write CDs in the DVD writer, I get very high system load (50% on
> > one CPU), even though DMA seems to be enabled.
> 
> If you are writing CDs with unusual block sizes (audio CDs, (S)VCDs,
> RAW mode -> blocksize != 2048) you won't get DMA with ide-scsi, no
> matter what you do. It's simply not supported.
