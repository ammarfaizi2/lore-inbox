Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264930AbSJOVlW>; Tue, 15 Oct 2002 17:41:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264931AbSJOVlV>; Tue, 15 Oct 2002 17:41:21 -0400
Received: from cmailm4.svr.pol.co.uk ([195.92.193.211]:59656 "EHLO
	cmailm4.svr.pol.co.uk") by vger.kernel.org with ESMTP
	id <S264930AbSJOVko>; Tue, 15 Oct 2002 17:40:44 -0400
Date: Tue, 15 Oct 2002 22:46:51 +0100
To: Linux Mailing List <linux-kernel@vger.kernel.org>,
       Linus Torvalds <torvalds@transmeta.com>, Dave Jones <davej@suse.de>
Subject: Re: [PATCH] Device-mapper submission 4/7
Message-ID: <20021015214651.GB28738@fib011235813.fsnet.co.uk>
References: <20021015174624.GD27753@fib011235813.fsnet.co.uk> <20021015181928.GH15552@clusterfs.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20021015181928.GH15552@clusterfs.com>
User-Agent: Mutt/1.4i
From: Joe Thornber <joe@fib011235813.fsnet.co.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 15, 2002 at 12:19:28PM -0600, Andreas Dilger wrote:
> On Oct 15, 2002  18:46 +0100, Joe Thornber wrote:
> > [Device-mapper]
> > The linear target maps a contigous range of logical sectors onto an
> > range of physical sectors.
> > 
> > +struct linear_c {
> > +	long delta;		/* FIXME: we need a signed offset type */
> > +	long start;		/* For display only */
> > +	struct dm_dev *dev;
> > +};
> 
> Should those not be sector_t type fields?

'start' certainly should be, it looks like 'delta' will have to split
into a sign and a sector_t.  Maybe I should read my own FIXMEs
sometime rather than having you do it for me :)

   Joe
