Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264340AbUD0UjR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264340AbUD0UjR (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Apr 2004 16:39:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264344AbUD0UjQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Apr 2004 16:39:16 -0400
Received: from [80.72.36.106] ([80.72.36.106]:50312 "EHLO alpha.polcom.net")
	by vger.kernel.org with ESMTP id S264340AbUD0UjO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Apr 2004 16:39:14 -0400
Date: Tue, 27 Apr 2004 22:39:09 +0200 (CEST)
From: Grzegorz Kulewski <kangur@polcom.net>
To: viro@parcelfarce.linux.theplanet.co.uk
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: 2.6.6-rc2-bk3 (and earlier?) mount problem (?
In-Reply-To: <20040427202813.GA17014@parcelfarce.linux.theplanet.co.uk>
Message-ID: <Pine.LNX.4.58.0404272232030.9618@alpha.polcom.net>
References: <Pine.LNX.4.58.0404270157160.6900@alpha.polcom.net>
 <20040427002323.GW17014@parcelfarce.linux.theplanet.co.uk>
 <Pine.LNX.4.58.0404261758230.19703@ppc970.osdl.org>
 <20040427010748.GY17014@parcelfarce.linux.theplanet.co.uk>
 <Pine.LNX.4.58.0404271106500.22815@alpha.polcom.net> <1083070293.30344.116.camel@watt.suse.com>
 <Pine.LNX.4.58.0404271500210.27538@alpha.polcom.net> <20040427140533.GI14129@stingr.net>
 <20040427183410.GZ17014@parcelfarce.linux.theplanet.co.uk>
 <20040427200459.GJ14129@stingr.net> <20040427202813.GA17014@parcelfarce.linux.theplanet.co.uk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 27 Apr 2004 viro@parcelfarce.linux.theplanet.co.uk wrote:

> On Wed, Apr 28, 2004 at 12:04:59AM +0400, Paul P Komkoff Jr wrote:
> > > Excuse me?  The damn thing had found nothing.  However, it didn't care
> > > to release the devices it had claimed - hadn't even closed them, as the
> > > matter of fact.  That's a clear and obvious bug, regardless of any
> > > disagreements.
> > 
> > As far as I can see from here, evms parsed partition table, called
> > dmsetup several times and created corresponding nodes in /dev/evms.
> 
> ... without saying anything?
> 
> > Logic is easy - evms trying to concentrate block device management
> > into its own hands, but we have in-kernel partitioning code to
> > consider ...
> 
> How nice of them.
> 
> Well, AFAICS that means
> 	a) either kernel side of the things or the userland tools should
> printk/syslog - at least that evms device had been set up
> 	b) any distribution that runs this from initrd/init scripts would
> better take care of having sane fstab.
> 	c) nobody sane should put that as default.  Oh, wait, it's gentoo
> we are talking about?  Nevermind, then.

But what default? Gentoo just calls evms_activate before mounting 
filesystems to check if there are evms volumes (because filesystems can 
reside on it). And, according to man page, this is the right usage of 
evms_activate. And Gentoo could not know easily that I have no evms 
volumes in the system. And I possibly could insert some and boot Gentoo 
(and for example have label not device in fstab to specify fs to mount). I 
really think that evms_activate should not take the device that is not for 
it. And I think Gentoo is right. (And it is the best distro I ever tried.)


Grzegorz Kulewski

