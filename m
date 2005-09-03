Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751225AbVICAE1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751225AbVICAE1 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 2 Sep 2005 20:04:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750859AbVICAE1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 2 Sep 2005 20:04:27 -0400
Received: from ee.oulu.fi ([130.231.61.23]:11233 "EHLO ee.oulu.fi")
	by vger.kernel.org with ESMTP id S1751225AbVICAE0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 2 Sep 2005 20:04:26 -0400
Date: Sat, 3 Sep 2005 03:03:59 +0300
From: Pekka Pietikainen <pp@ee.oulu.fi>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: pjones@redhat.com,
       "ATARAID (eg, Promise Fasttrak, Highpoint 370) related discussions" 
	<ataraid-list@redhat.com>,
       linux-kernel@vger.kernel.org
Subject: Re: IDE HPA
Message-ID: <20050903000359.GA16028@ee.oulu.fi>
References: <1125666332.30867.10.camel@localhost.localdomain> <62b0912f05090206331d04afd3@mail.gmail.com> <E1EBCdS-00064p-00@chiark.greenend.org.uk> <62b0912f05090209242ad72321@mail.gmail.com> <1125680712.30867.20.camel@localhost.localdomain> <62b0912f05090210441d3fa248@mail.gmail.com> <1125684567.31292.2.camel@localhost.localdomain> <1125687557.30867.26.camel@localhost.localdomain> <1125688483.31292.20.camel@localhost.localdomain> <1125692578.30867.33.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <1125692578.30867.33.camel@localhost.localdomain>
User-Agent: Mutt/1.4.2i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 02, 2005 at 09:22:58PM +0100, Alan Cox wrote:
> You installed it on Red Hat 7 ? I think 7, may have been 6.x or earlier.
> This behaviour goes back pretty much to the creation of the ATA spec for
> HPA. In fact if it was that long ago IBM shipped it with Windows so it
> did have a partition table!
FC3 happily ignored the HPA on IBM X31. FC4 did not. I won't vow about the
original partitioning, but a "worked for just about everything" FC3
kickstart slightly updated to FC4 started breaking horribly after suspend.
As in messed up filesystems since parts of the disk just vanished when you
resumed. (FC3 could have been broken too, but CONFIG_IDE_STROKE or whatnot
wasn't enabled, so it worked as expected). It probably didn't work
as expected for people with broken bioses that didn't do >32GB ether, but those
people required additional hacks for competing OS's too, so it wasn't such a
biggie for them, I suppose.

Some sort of BIOS bug, completely IBM's (or rather some subcontractor)
fault, happens on one X31 laptop I know of, where the HPA just can't be
disabled. At all. The BIOS setting gets ignored. On the one I personally use
disabling it works, so losing the recovery Windows XP was enough to have a
functional system. Not optimal, but I don't really need the recovery stuff
for anything, so might as well use the entire disk.

For the one where disabling the HPA just didn't work the solution was to
manually partition, and just not using the area the HPA would appear on.
There goes automatic kickstart installs, but at least the laptop now is usable.
