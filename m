Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1162702AbWLBBVl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1162702AbWLBBVl (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 1 Dec 2006 20:21:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759365AbWLBBVk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 1 Dec 2006 20:21:40 -0500
Received: from qb-out-0506.google.com ([72.14.204.224]:64602 "EHLO
	qb-out-0506.google.com") by vger.kernel.org with ESMTP
	id S1759363AbWLBBVk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 1 Dec 2006 20:21:40 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:subject:from:reply-to:to:cc:in-reply-to:references:content-type:date:message-id:mime-version:x-mailer:content-transfer-encoding;
        b=GcxRJ+meL90qgvsP639FewtmY8CrkLIS/4npPrhSP7b+h0+sd1cNNiGxeyjiQ8Zk4Vyx06DE5p+HHS2QBMNH+OZQXObTdaljx1wB1YDGR3NvxU2VvoRYm2cR3+2xVqOVMGzjZaJ9eXLKF3ZyixuY0OtTgLB9aQa4akrgE0ccsVc=
Subject: Re: [dm-devel] Re: [RFC][PATCH] dm-cache: block level disk cache
	target for device mapper
From: Ming Zhang <blackmagic02881@gmail.com>
Reply-To: blackmagic02881@gmail.com
To: device-mapper development <dm-devel@redhat.com>
Cc: bert hubert <bert.hubert@netherlabs.nl>, ming@acis.ufl.edu,
       Linux Kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <a4e6962a0611271155q55adf6fftd489de84d6ae7e88@mail.gmail.com>
References: <200611271826.kARIQYRi032717@hera.kernel.org>
	 <20061127184748.GA11219@outpost.ds9a.nl>
	 <a4e6962a0611271155q55adf6fftd489de84d6ae7e88@mail.gmail.com>
Content-Type: text/plain
Date: Fri, 01 Dec 2006 20:21:37 -0500
Message-Id: <1165022497.2761.216.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.3 (2.6.3-1.fc5.5) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2006-11-27 at 13:55 -0600, Eric Van Hensbergen wrote:
> On 11/27/06, bert hubert <bert.hubert@netherlabs.nl> wrote:
> > On Mon, Nov 27, 2006 at 06:26:34PM +0000, Eric Van Hensbergen wrote:
> > > This is the first cut of a device-mapper target which provides a write-back
> > > or write-through block cache.  It is intended to be used in conjunction with
> > > remote block devices such as iSCSI or ATA-over-Ethernet, particularly in
> > > cluster situations.
> >
> > How does this work in practice? In other words, what is a typical actual
> > configuration?
> >
> > There is a remote block device, and a local one, and these are kept into
> > sync in some way?
> >
> 
> That's the basic idea.  In our testbed, we had a single iSCSI server
> exporting block devices to several clients -- each maintaining their
> own local disk cache of the server exported block devices.  You can
> configured either write-through or write-back policies -- write-back
> has better performance, but somewhat obvious consistency issues in
> failure cases.
> 
> The original intent was to combine this with the dm-cow target (which
> I posted a few hours before the dm-cache patch) to provide a scalable
> cluster deployment system based on back-end iSCSI or ATA-over-Ethernet
> storage.

like to see this idea but any similarity with
http://www.ele.uri.edu/Research/hpcl/STICS/stics.pdf?

STICS is patent pending so not sure if kernel can be free to merge this
dm-cache.


> 
>           -eric
> 
> --
> dm-devel mailing list
> dm-devel@redhat.com
> https://www.redhat.com/mailman/listinfo/dm-devel

