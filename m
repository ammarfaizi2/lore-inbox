Return-Path: <linux-kernel-owner+willy=40w.ods.org-S933043AbWK0S3r@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933043AbWK0S3r (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Nov 2006 13:29:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933026AbWK0S3r
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Nov 2006 13:29:47 -0500
Received: from alpha.logic.tuwien.ac.at ([128.130.175.20]:21467 "EHLO
	alpha.logic.tuwien.ac.at") by vger.kernel.org with ESMTP
	id S932875AbWK0S3p (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Nov 2006 13:29:45 -0500
Date: Mon, 27 Nov 2006 19:29:43 +0100
To: Alan <alan@lxorguk.ukuu.org.uk>
Cc: avl@logic.at, linux-kernel@vger.kernel.org
Subject: Re: Allow turning off hpa-checking.
Message-ID: <20061127182943.GE2352@gamma.logic.tuwien.ac.at>
Reply-To: avl@logic.at
References: <20061121115117.GU6851@gamma.logic.tuwien.ac.at> <20061121120614.06073ce8@localhost.localdomain> <20061122105735.GV6851@gamma.logic.tuwien.ac.at> <20061123170557.GY6851@gamma.logic.tuwien.ac.at> <20061127130953.GA2352@gamma.logic.tuwien.ac.at> <20061127133044.28b8b4ed@localhost.localdomain> <20061127160144.GB2352@gamma.logic.tuwien.ac.at> <20061127163328.3f1c12eb@localhost.localdomain> <20061127175647.GD2352@gamma.logic.tuwien.ac.at> <20061127181033.58e72d9a@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061127181033.58e72d9a@localhost.localdomain>
User-Agent: Mutt/1.3.28i
From: Andreas Leitgeb <avl@logic.at>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 27, 2006 at 06:10:33PM +0000, Alan wrote:
> > What else (if not sector remapping) could make the "current"
> > size gradually smaller between reboots. And why is "native"
> > size still constant?  And why does now even access to the but-last
> > native sector fail? The explanation with block-reads no longer
> > works.
> The presented size of an ATA disk is constant. It keeps additional space
> for error blocks. The HPA merely tells the disk to lie about its size.

I was speaking about a disk, whose "additional space" appeared to 
be already exhausted.  After that, it appears as if the native
size remains still constant, and the exceeding damaged sectors are 
auto-"hidden" by the drive by means of HPA.

Still incorrect?

Then I'm also speaking about not-broken disks, where I just want
to be able to tell the driver to believe the drive's "HPA-lie"
for whatever reason :-)

> > How should the partitioning tool know, if I want to ignore the
> > HPA, or respect it (knowing it contains stuff that I might need in
> > future).  Does there exist any that asks me?
> I have no idea. If not perhaps one should be written.
Till that happens ... ;-)

