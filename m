Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264369AbUD0V7i@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264369AbUD0V7i (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Apr 2004 17:59:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264372AbUD0V7h
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Apr 2004 17:59:37 -0400
Received: from [80.72.36.106] ([80.72.36.106]:16521 "EHLO alpha.polcom.net")
	by vger.kernel.org with ESMTP id S264369AbUD0V7f (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Apr 2004 17:59:35 -0400
Date: Tue, 27 Apr 2004 23:59:26 +0200 (CEST)
From: Grzegorz Kulewski <kangur@polcom.net>
To: viro@parcelfarce.linux.theplanet.co.uk
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: 2.6.6-rc2-bk3 (and earlier?) mount problem (?
In-Reply-To: <20040427213549.GC17014@parcelfarce.linux.theplanet.co.uk>
Message-ID: <Pine.LNX.4.58.0404272342150.13077@alpha.polcom.net>
References: <Pine.LNX.4.58.0404261758230.19703@ppc970.osdl.org>
 <20040427010748.GY17014@parcelfarce.linux.theplanet.co.uk>
 <Pine.LNX.4.58.0404271106500.22815@alpha.polcom.net> <1083070293.30344.116.camel@watt.suse.com>
 <Pine.LNX.4.58.0404271500210.27538@alpha.polcom.net> <20040427140533.GI14129@stingr.net>
 <20040427183410.GZ17014@parcelfarce.linux.theplanet.co.uk>
 <20040427200459.GJ14129@stingr.net> <20040427202813.GA17014@parcelfarce.linux.theplanet.co.uk>
 <Pine.LNX.4.58.0404272232030.9618@alpha.polcom.net>
 <20040427213549.GC17014@parcelfarce.linux.theplanet.co.uk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 27 Apr 2004 viro@parcelfarce.linux.theplanet.co.uk wrote:
> On Tue, Apr 27, 2004 at 10:39:09PM +0200, Grzegorz Kulewski wrote:
> > > 	c) nobody sane should put that as default.  Oh, wait, it's gentoo
> > > we are talking about?  Nevermind, then.
> > 
> > But what default? Gentoo just calls evms_activate before mounting 
> > filesystems to check if there are evms volumes (because filesystems can 
> > reside on it). And, according to man page, this is the right usage of 
> > evms_activate.
> 
> And that usage of evms_activate takes over all normally partitioned devices
> and shoves equivalents of partitions under /dev/evms, right?  So in which
> universe would that be the right thing to do without a big fat warning and
> update of /etc/fstab?


>From evms_activate man page:

DESCRIPTION
       The  evms_activate  command  discovers  all EVMS volumes and 
activates kernel devices for all volumes
       that are not yet active. The command should be run at boot time so 
the file systems  that  reside  on
       the volumes can be mounted. If EVMS volumes are listed in the 
/etc/fstab, evms_activate should be run
       before /etc/fstab is processed (which is distribution specific). If 
the root file  system  is  on  an
       EVMS volume, evms_activate should be run from the init-ramdisk.
 

And where is the big fat warning that you can not use your normal devices 
anymore?

And I still do not understand why my old device names that every script / 
program on the Eartch uses cannot be used anymore... And if I really can 
not use them why their device files in dev do not disappear? (I am using 
udev.)

And can I use fdisk to modify and then reload partition table in this new 
approach? And will mount that is searching for filesystem with specified 
label find it on new device? And should not the kernel warn in case 
someone is touching the old device?


Grzegorz Kulewski

