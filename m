Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293396AbSCACh3>; Thu, 28 Feb 2002 21:37:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S310316AbSCACbW>; Thu, 28 Feb 2002 21:31:22 -0500
Received: from dsl-213-023-038-171.arcor-ip.net ([213.23.38.171]:36240 "EHLO
	starship.berlin") by vger.kernel.org with ESMTP id <S310329AbSCAC2C>;
	Thu, 28 Feb 2002 21:28:02 -0500
Content-Type: text/plain; charset=US-ASCII
From: Daniel Phillips <phillips@bonn-fries.net>
To: Erik Mouw <J.A.K.Mouw@its.tudelft.nl>, Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: read_proc issue
Date: Wed, 27 Feb 2002 04:19:35 +0100
X-Mailer: KMail [version 1.3.2]
Cc: Val Henson <val@nmt.edu>, "Randy.Dunlap" <rddunlap@osdl.org>,
        Laurent <laurent@augias.org>, linux-kernel@vger.kernel.org
In-Reply-To: <20020227140432.L20918@boardwalk> <E16gBps-0005wa-00@the-village.bc.nu> <20020228000532.GA8858@arthur.ubicom.tudelft.nl>
In-Reply-To: <20020228000532.GA8858@arthur.ubicom.tudelft.nl>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <E16fucy-0004vi-00@starship.berlin>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On February 28, 2002 01:05 am, Erik Mouw wrote:
> On Wed, Feb 27, 2002 at 09:42:04PM +0000, Alan Cox wrote:
> > > I've encountered this problem before, too.  What is the "One True Way"
> > > to do this cleanly?  In other words, if you want to do a calculation
> > > once every time someone runs "cat /proc/foo", what is the cleanest way
> > > to do that?  The solution we came up with was to check the file offset
> > > and only do the calculation if offset == 0, which seems pretty
> > > hackish.
> > 
> > Another approach is to do the calculation open and remember it in per
> > fd private data. You can recover that and free it on release. It could
> > even be a buffer holding the actual "content"
> 
> It might also be an idea to export proc_calc_metrics() from
> fs/proc/proc_misc.c because quite a lot of code actually tries to do
> exactly the same.

Look at all the parameters, they're trying to be a struct.  How about
cleaning it up before exporting?

-- 
Daniel
