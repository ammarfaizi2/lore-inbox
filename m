Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750817AbVIQB30@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750817AbVIQB30 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 16 Sep 2005 21:29:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750815AbVIQB30
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 16 Sep 2005 21:29:26 -0400
Received: from soundwarez.org ([217.160.171.123]:6123 "EHLO soundwarez.org")
	by vger.kernel.org with ESMTP id S1750817AbVIQB30 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 16 Sep 2005 21:29:26 -0400
Date: Sat, 17 Sep 2005 03:29:24 +0200
From: Kay Sievers <kay.sievers@vrfy.org>
To: "Dr.Dre" <pharon@gmail.com>
Cc: Greg KH <greg@kroah.com>, jirislaby@gmail.com, dominik.karall@gmx.net,
       linux-kernel@vger.kernel.org
Subject: Re: 2.6.14-rc1-mm1
Message-ID: <20050917012924.GA30024@vrfy.org>
References: <20050916022319.12bf53f3.akpm@osdl.org> <200509162042.07376.dominik.karall@gmx.net> <432B2101.9080806@gmail.com> <20050916195903.GE22221@vrfy.org> <20050916213003.GB13604@kroah.com> <200509162353.j8GNrX2B007036@turing-police.cc.vt.edu> <20050917001021.GA16041@kroah.com> <5d8b7b90509161818a4616d9@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5d8b7b90509161818a4616d9@mail.gmail.com>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Sep 17, 2005 at 04:18:37AM +0300, Dr.Dre wrote:
> On 9/17/05, Greg KH <greg@kroah.com> wrote:
> > On Fri, Sep 16, 2005 at 07:53:32PM -0400, Valdis.Kletnieks@vt.edu wrote:
> > > On Fri, 16 Sep 2005 14:30:04 PDT, Greg KH said:
> > > > > > >On Friday 16 September 2005 11:23, Andrew Morton wrote:
> > > > > > >>ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.14-rc1/2.6.14-rc1-mm1/
> > >
> > > > Yes, Andrew, can you please drop these patches, they will cause lots of
> > > > problems with users due to the above mentioned issues.
> > >
> > > For those of us playing along at home -
> > >
> > > Would doing a 'patch -R' of all 30 patches listed in "Big input/sysfs changes"
> > > be needed?
> > 
> > That's probably the safest.
> > 
> > >  Or just the 'input-prepare-to-sysfs-integration.patch' and following?
> > 
> > Don't really know if stuff would still build if you only reverted that
> > one.

> just a notice here: 
> I had to install udev-70 to fix the "blocked udev" problem, then
> noticed the  missing /dev/input/mice problem because neither gpm nor X
> would start.
> 
> So I recompiled with this feature as a module ( mousedev ) and
> rebooted to find udev started to create the node. ( I didn't reverse
> any patches.)

Cause the "udev event" works, but "udevstart" doesn't. So, if you are
lucky, the module load will trigger the events to create the nodes.

Kay
