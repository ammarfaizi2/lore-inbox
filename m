Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932293AbWBXRDt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932293AbWBXRDt (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 24 Feb 2006 12:03:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932390AbWBXRDt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 24 Feb 2006 12:03:49 -0500
Received: from xenotime.net ([66.160.160.81]:30395 "HELO xenotime.net")
	by vger.kernel.org with SMTP id S932385AbWBXRDs (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 24 Feb 2006 12:03:48 -0500
Date: Fri, 24 Feb 2006 09:03:47 -0800 (PST)
From: "Randy.Dunlap" <rdunlap@xenotime.net>
X-X-Sender: rddunlap@shark.he.net
To: Christoph Hellwig <hch@infradead.org>
cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, erich <erich@areca.com.tw>,
       Arjan van de Ven <arjan@infradead.org>, linux-scsi@vger.kernel.org,
       linux-kernel@vger.kernel.org, billion.wu@areca.com.tw, akpm@osdl.org,
       oliver@neukum.org
Subject: Re: Areca RAID driver remaining items?
In-Reply-To: <20060224165647.GA4176@infradead.org>
Message-ID: <Pine.LNX.4.58.0602240858180.7894@shark.he.net>
References: <1140458552.3495.26.camel@mentorng.gurulabs.com>
 <20060220182045.GA1634@infradead.org> <001401c63779$12e49aa0$b100a8c0@erich2003>
 <20060222145733.GC16269@infradead.org> <00dc01c63842$381f9a30$b100a8c0@erich2003>
 <1140683157.2972.6.camel@laptopd505.fenrus.org> <001901c6385e$9aee7d40$b100a8c0@erich2003>
 <1140695990.19361.8.camel@localhost.localdomain> <20060224165647.GA4176@infradead.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 24 Feb 2006, Christoph Hellwig wrote:

> On Thu, Feb 23, 2006 at 11:59:50AM +0000, Alan Cox wrote:
> > On Iau, 2006-02-23 at 17:50 +0800, erich wrote:
> > > But unfortunately I found some mainboards will hang up if I always enable
> > > this function in my lab.
> > > To avoid this issue, I do an option for this case.
> > >
> > > But  Christoph Hellwig give me comment with it.
> >
> >
> > Another thing you can also do for many of these cases is to use either
> > the PCI or DMI interfaces to identify the problem board and
> > automatically set the option as well.
> >
> > There are two ways to do this. One is
>
> Please avoid that unless really nessecary.  I doubt there's boards where
> MSI would only be broken with the areca card but not with other MSI-capable
> ones.  If a board or chipset is generally broken vs MSI it should be
> added to the global MSI blacklist.  It's probably be nice to have a global
> nomsi boot option instead of one in every driver aswell..

Jeff G. added an "msi" option to the sata_mv driver recently.
But yes, I expect it to be more of a platform issue than a
driver issue.

s2io network people report MSI interrupt problems on various
platforms (on netdev mailing list).

There are other reports (that I have at home, not visible to me
now).  It would be good to have an MSI expert around.

http://www.xenotime.net/linux/patches/pci_nomsi.patch adds a
global boot option to disable MSI interrupt assignments.

-- 
~Randy
