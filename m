Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262369AbTLPU5u (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 16 Dec 2003 15:57:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262386AbTLPU5u
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 Dec 2003 15:57:50 -0500
Received: from astound-64-85-224-253.ca.astound.net ([64.85.224.253]:13069
	"EHLO master.linux-ide.org") by vger.kernel.org with ESMTP
	id S262369AbTLPU5s (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 Dec 2003 15:57:48 -0500
Date: Tue, 16 Dec 2003 12:51:02 -0800 (PST)
From: Andre Hedrick <andre@linux-ide.org>
To: Helge Hafting <helgehaf@aitel.hist.no>
cc: jw schultz <jw@pegasys.ws>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: raid0 slower than devices it is assembled of?
In-Reply-To: <3FDF1C03.2020509@aitel.hist.no>
Message-ID: <Pine.LNX.4.10.10312161246340.2113-100000@master.linux-ide.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Helge,

Reads you may gain on writes only if all devices are on single ended mode.
Both pATA and pSCSI suck wind in writes, pSCSI should smoke pATA on reads.
It is all a matter of the physical protocol on the wire.

Only in SATA/SAS will you even reach close to ideal world.

Cheers,

Andre Hedrick
LAD Storage Consulting Group

On Tue, 16 Dec 2003, Helge Hafting wrote:

> jw schultz wrote:
> 
> > No Linux [R]AID improves sequential performance.  How would
> > reading 65KB from two disks in alternation be faster than
> > reading continuously from one disk?
> > 
> Raid-0 is ideally N times faster than a single disk, when
> you have N disks.  Because you can read continuously from N
> disks instead of from 1, thereby N-doubling the bandwith.
> 
> Wether the current drivers manages that is of course another story.
> 
> Helge Hafting
> 
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 

