Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261779AbTKHPCb (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 8 Nov 2003 10:02:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261782AbTKHPCb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 8 Nov 2003 10:02:31 -0500
Received: from fep02-0.kolumbus.fi ([193.229.0.44]:25343 "EHLO
	fep02-app.kolumbus.fi") by vger.kernel.org with ESMTP
	id S261779AbTKHPCa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 8 Nov 2003 10:02:30 -0500
Date: Sat, 8 Nov 2003 17:02:33 +0200 (MET DST)
From: Szakacsits Szabolcs <szaka@sienet.hu>
X-X-Sender: szaka@ua178d119.elisa.omakaista.fi
To: Andrew Pimlott <andrew@pimlott.net>
cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: undo an mke2fs !!
In-Reply-To: <20031107231359.GA2722@pimlott.net>
Message-ID: <Pine.LNX.4.58.0311081624390.12661@ua178d119.elisa.omakaista.fi>
References: <Pine.LNX.4.44.0311061753350.21501-100000@gaia.cela.pl>
 <Pine.LNX.4.58.0311070601380.10194@ua178d119.elisa.omakaista.fi>
 <20031107231359.GA2722@pimlott.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Fri, 7 Nov 2003, Andrew Pimlott wrote:
> On Fri, Nov 07, 2003 at 06:35:03AM +0200, Szakacsits Szabolcs wrote:
> >
> > 	http://linux-ntfs.sourceforge.net/man/ntfsclone.html
> > 
> > It clones either all used data or only metadata to a mountable image at the
> > sector level (so it's much more efficient than dd if disk is far away to be
> > full).
> 
> Can it avoid seeking all over the place when copying the data?  This

First it validates the block allocation bitmap then uses it. So seeks are
minimized and it indeed gave performance improvement:

http://marc.theaimsgroup.com/?l=linux-ntfs-dev&m=105032147728258&w=2

> would be really cool for fast backups and getting data off a dying disk.

For disks with bad sectors, etc I always recommended 'dd noerror ...' but
yes, there are cases when it's safe thus it make sense to support this as
well - added to TODO list. Cheers,

	Szaka
