Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317331AbSHAWsy>; Thu, 1 Aug 2002 18:48:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317338AbSHAWsx>; Thu, 1 Aug 2002 18:48:53 -0400
Received: from leibniz.math.psu.edu ([146.186.130.2]:16001 "EHLO math.psu.edu")
	by vger.kernel.org with ESMTP id <S317331AbSHAWsv>;
	Thu, 1 Aug 2002 18:48:51 -0400
Date: Thu, 1 Aug 2002 18:52:18 -0400 (EDT)
From: Alexander Viro <viro@math.psu.edu>
To: Petr Vandrovec <VANDROVE@vc.cvut.cz>
cc: martin@dalecki.de, linux-kernel@vger.kernel.org, mingo@elte.hu
Subject: Re: IDE from current bk tree, UDMA and two channels...
In-Reply-To: <CEE6114682@vcnet.vc.cvut.cz>
Message-ID: <Pine.GSO.4.21.0208011850140.12627-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Fri, 2 Aug 2002, Petr Vandrovec wrote:

> > Uh-oh...
> > 
> > Let me see if I got it straight:
> > 
> > a) your disk doesn't work with half-Kb requests
> > b) you have a partition with odd number of sectors
> > c) hardsect_size is set to half-Kb
> > d) old code worked since it rounded size to multiple of kilobyte.
> > 
> > Correct?
> 
> Yes, exactly. Replacing disk is not an option...

OK.  At the very least we need a way for driver to tell what the sector
size is.  And that can be a problem - AFAICS IDE shares the queue for
master and slave and sector size is queue property.

BTW, what type of partition table do you have there?

