Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751290AbVJJWWV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751290AbVJJWWV (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 10 Oct 2005 18:22:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751289AbVJJWWV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 10 Oct 2005 18:22:21 -0400
Received: from mx1.redhat.com ([66.187.233.31]:12974 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1751286AbVJJWWU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 10 Oct 2005 18:22:20 -0400
Date: Mon, 10 Oct 2005 17:22:02 -0500
From: David Teigland <teigland@redhat.com>
To: Al Viro <viro@ftp.linux.org.uk>
Cc: Greg KH <greg@kroah.com>, linux-kernel@vger.kernel.org, akpm@osdl.org,
       linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 11/16] GFS: mount and tuning options
Message-ID: <20051010222202.GB25691@redhat.com>
References: <20051010171052.GL22483@redhat.com> <20051010210108.GA13457@kroah.com> <20051010211429.GA25691@redhat.com> <20051010211918.GA13920@kroah.com> <20051010213025.GP7992@ftp.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051010213025.GP7992@ftp.linux.org.uk>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 10, 2005 at 10:30:26PM +0100, Al Viro wrote:
> On Mon, Oct 10, 2005 at 02:19:18PM -0700, Greg KH wrote:
> > > > > +	rv += sprintf(buf + rv, "bsize %u\n", sdp->sd_sb.sb_bsize);
> > > > > +	rv += sprintf(buf + rv, "total %lld\n", sc.sc_total);
> > > > > +	rv += sprintf(buf + rv, "free %lld\n", sc.sc_free);
> > > > > +	rv += sprintf(buf + rv, "dinodes %lld\n", sc.sc_dinodes);
> > > > 
> > > > No, 1 value per sysfs file please.
> > > 
> > > I'm aware of that rule and have followed it everywhere else.  This is a
> > > special case where the one statfs produces three results.
> > 
> > Then why not have 4 different files, for the result of the last "statfs"
> > command?
> 
> More to the point, what the hell is that doing in sysfs in the first place?

It gave extended, gfs-specific usage information not available through df.
It's not valuable enough to keep around for the confusion and questions
it's raised so I've removed it.

Dave

