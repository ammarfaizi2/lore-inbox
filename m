Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264906AbTK3NL3 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 30 Nov 2003 08:11:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264907AbTK3NL3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 30 Nov 2003 08:11:29 -0500
Received: from fep02-0.kolumbus.fi ([193.229.0.44]:60828 "EHLO
	fep02-app.kolumbus.fi") by vger.kernel.org with ESMTP
	id S264906AbTK3NL2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 30 Nov 2003 08:11:28 -0500
Date: Sun, 30 Nov 2003 13:10:36 +0200 (MET DST)
From: Szakacsits Szabolcs <szaka@sienet.hu>
X-X-Sender: szaka@ua178d119.elisa.omakaista.fi
To: Andries Brouwer <aebr@win.tue.nl>
cc: Andrew Clausen <clausen@gnu.org>, Apurva Mehta <apurva@gmx.net>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       bug-parted@gnu.org
Subject: Re: Disk Geometries reported incorrectly on 2.6.0-testX
In-Reply-To: <20031130003428.GA5465@win.tue.nl>
Message-ID: <Pine.LNX.4.58.0311301210540.2329@ua178d119.elisa.omakaista.fi>
References: <20031128045854.GA1353@home.woodlands> <20031128142452.GA4737@win.tue.nl>
 <20031129022221.GA516@gnu.org> <Pine.LNX.4.58.0311290550190.21441@ua178d119.elisa.omakaista.fi>
 <20031129123451.GA5372@win.tue.nl> <20031129222722.GA505@gnu.org>
 <20031130003428.GA5465@win.tue.nl>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Sun, 30 Nov 2003, Andries Brouwer wrote:

> Just ask yourself this question: does Windows XP require a bootable
> partition to start below the 1024 cylinder mark?
> Windows NT4 has such a restriction. Not Windows 2000 or XP.

Wrong:
	http://support.microsoft.com/default.aspx?scid=kb;en-us;282191

> > > Usually booting goes like this: the BIOS reads sector 0 (the MBR)
> > > from the first disk, and starts the code found there. What happens
> > > afterwards is up to that code. If that code uses CHS units to find
> > > a partition, and if the program that wrote the table has different
> > > ideas about those units than the BIOS, booting may fail.
> > Exactly.
> Good. We agree.

I'm glad also. So what actually [cs]fdisk do with the CHS entries in the
partition table? Ignore them? Might they convert a given partition start to
different CHS units if the partition entry was deleted then recreated at
the same cylinder? 

AFAIS, parted tries hard not to break these [IMHO correctly], right Andrew?

	Szaka
