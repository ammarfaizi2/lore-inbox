Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261834AbSJIPYy>; Wed, 9 Oct 2002 11:24:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261835AbSJIPYy>; Wed, 9 Oct 2002 11:24:54 -0400
Received: from h68-147-110-38.cg.shawcable.net ([68.147.110.38]:26612 "EHLO
	webber.adilger.int") by vger.kernel.org with ESMTP
	id <S261834AbSJIPYx>; Wed, 9 Oct 2002 11:24:53 -0400
From: Andreas Dilger <adilger@clusterfs.com>
Date: Wed, 9 Oct 2002 09:27:31 -0600
To: Robert Love <rml@tech9.net>
Cc: Marco Colombo <marco@esi.it>, linux-kernel@vger.kernel.org, akpm@digeo.com,
       riel@conectiva.com.br
Subject: Re: [PATCH] O_STREAMING - flag for optimal streaming I/O
Message-ID: <20021009152731.GY3045@clusterfs.com>
Mail-Followup-To: Robert Love <rml@tech9.net>, Marco Colombo <marco@esi.it>,
	linux-kernel@vger.kernel.org, akpm@digeo.com, riel@conectiva.com.br
References: <Pine.LNX.4.44.0210091606000.26363-100000@Megathlon.ESI> <1034172868.746.3707.camel@phantasy>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1034172868.746.3707.camel@phantasy>
User-Agent: Mutt/1.4i
X-GPG-Key: 1024D/0D35BED6
X-GPG-Fingerprint: 7A37 5D79 BF1B CECA D44F  8A29 A488 39F5 0D35 BED6
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Oct 09, 2002  10:14 -0400, Robert Love wrote:
> On Wed, 2002-10-09 at 10:10, Marco Colombo wrote:
> 
> > >  #define O_NOFOLLOW	0400000 /* don't follow links */
> > >  #define O_NOFOLLOW	0x20000	/* don't follow links */
> > ...
> > 04000000 != 0x400000
> > 
> > or am I missing something?
> 
> No need.  See for example O_NOFOLLOW right above.  Each architecture can
> do has it pleases (I wish otherwise, but...).
> 
> > (do different archs dream of different O_STREAMING values?)
> 
> If they so choose.  Just look at the formats of the two numbers you
> posted, even those are different.

I would say - if you are picking a new flag that doesn't need to have
compatibility with any platform-specific existing flag, simply set them
all high enough so that they are the same on all platforms.  Just
because some of the flags are broken is no need to make all of them so.

Cheers, Andreas
--
Andreas Dilger
http://www-mddsp.enel.ucalgary.ca/People/adilger/
http://sourceforge.net/projects/ext2resize/

