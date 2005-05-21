Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261646AbVEUDbM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261646AbVEUDbM (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 20 May 2005 23:31:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261648AbVEUDbL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 20 May 2005 23:31:11 -0400
Received: from pop.gmx.de ([213.165.64.20]:59051 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S261646AbVEUDbF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 20 May 2005 23:31:05 -0400
X-Authenticated: #428038
Date: Sat, 21 May 2005 05:31:02 +0200
From: Matthias Andree <matthias.andree@gmx.de>
To: Neil Brown <neilb@cse.unsw.edu.au>
Cc: linux-kernel@vger.kernel.org
Subject: Re: software RAID
Message-ID: <20050521033102.GB354@merlin.emma.line.org>
Mail-Followup-To: Neil Brown <neilb@cse.unsw.edu.au>,
	linux-kernel@vger.kernel.org
References: <Pine.LNX.4.62.0505201246520.13530@gannon.phys.uwm.edu> <17038.24706.571479.471268@cse.unsw.edu.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <17038.24706.571479.471268@cse.unsw.edu.au>
X-PGP-Key: http://home.pages.de/~mandree/keys/GPGKEY.asc
User-Agent: Mutt/1.5.9i
X-Y-GMX-Trusted: 0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 21 May 2005, Neil Brown wrote:

> On Friday May 20, amiller@gravity.phys.uwm.edu wrote:
> > Hi,
> >    We're looking to set up either software RAID 1 or RAID 10 using 2 SATA 
> > disks.  If a disk in drive A has a bad sector, can it be setup so that the 
> > array will read the sector from drive B and then have it rewrite the 
> > bad sector on drive A?  Please CC me in the response.
> 
> Not yet, but it is this functionality is very near the top of my TODO
> list for md.

Speaking of consistency, what is md's support for barriers like? Is it
safe to use write caches on the drives? (RAID1 assumed)

What if I'm using different drive models with different cache sizes
(isn't as unreasonable as it sounds as different drives may have
different margins WRT environmental influences), how does md figure what
is missing from one drive?

Is there anything short of break mirror and rebuild to guarantee
consistency until next reboot?

Documentation/md.txt is a bit lacking in these respects.

-- 
Matthias Andree
