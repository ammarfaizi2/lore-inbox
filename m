Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262108AbTK3Xqw (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 30 Nov 2003 18:46:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262119AbTK3Xqw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 30 Nov 2003 18:46:52 -0500
Received: from mail006.syd.optusnet.com.au ([211.29.132.63]:18830 "EHLO
	mail006.syd.optusnet.com.au") by vger.kernel.org with ESMTP
	id S262108AbTK3Xqu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 30 Nov 2003 18:46:50 -0500
Date: Mon, 1 Dec 2003 10:51:11 +1100
From: Andrew Clausen <clausen@gnu.org>
To: John Bradford <john@grabjohn.com>
Cc: Arjan van de Ven <arjanv@redhat.com>, Andries Brouwer <aebr@win.tue.nl>,
       Szakacsits Szabolcs <szaka@sienet.hu>, Apurva Mehta <apurva@gmx.net>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       bug-parted@gnu.org
Subject: Re: Disk Geometries reported incorrectly on 2.6.0-testX
Message-ID: <20031130235111.GB464@gnu.org>
References: <20031128045854.GA1353@home.woodlands> <20031128142452.GA4737@win.tue.nl> <20031129022221.GA516@gnu.org> <Pine.LNX.4.58.0311290550190.21441@ua178d119.elisa.omakaista.fi> <20031129123451.GA5372@win.tue.nl> <200311291350.hATDo0CY001142@81-2-122-30.bradfords.org.uk> <20031129223103.GB505@gnu.org> <1070182676.5214.2.camel@laptop.fenrus.com> <200311301040.hAUAePk6000149@81-2-122-30.bradfords.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200311301040.hAUAePk6000149@81-2-122-30.bradfords.org.uk>
X-Accept-Language: en,pt
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Nov 30, 2003 at 10:40:25AM +0000, John Bradford wrote:
> > EFI GPT has some severe downsides (like requiring the last sector on
> > disk, which in linux may not be accessible if the total number of
> > sectors is not a multiple of 2, and making dd of one disk to another
> > impossible if the second one is bigger)
> 
> EFI GPT is also a far more elaborate scheme than is necessary for a
> lot of installations.

Is this a problem?

> My 'requirements' are:
> 
> * Good magic
> 
> We have seen support for not very widely used partitioning schemes
> broken in the past when other schemes are checked for ahead of them.
> A simple scheme with well defined magic values reduces this risk.

I think magic doesn't belong in partition tables.  I like probing.
Having the same data stored in two places makes things hairy
if you don't know how to resolve inconsistencies.

> * Simple
> 
> The code for some of the partitioning schemes is full of workarounds
> for different implementations.  Added complexity, and more variations
> increase the likelyhood of bugs.

If you're not interested in work-arounds, why not use LVM?

> * All partition information stored in one partition table
> 
> Linked lists make re-arranging partitions, and backing up the
> partition table more difficult.

I don't think it's very difficult, but I agree that tables are nice
and simple.

Cheers,
Andrew

