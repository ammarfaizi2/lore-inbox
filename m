Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751264AbVJJVaa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751264AbVJJVaa (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 10 Oct 2005 17:30:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751262AbVJJVa3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 10 Oct 2005 17:30:29 -0400
Received: from zeniv.linux.org.uk ([195.92.253.2]:63208 "EHLO
	ZenIV.linux.org.uk") by vger.kernel.org with ESMTP id S1751260AbVJJVa3
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 10 Oct 2005 17:30:29 -0400
Date: Mon, 10 Oct 2005 22:30:26 +0100
From: Al Viro <viro@ftp.linux.org.uk>
To: Greg KH <greg@kroah.com>
Cc: David Teigland <teigland@redhat.com>, linux-kernel@vger.kernel.org,
       akpm@osdl.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 11/16] GFS: mount and tuning options
Message-ID: <20051010213025.GP7992@ftp.linux.org.uk>
References: <20051010171052.GL22483@redhat.com> <20051010210108.GA13457@kroah.com> <20051010211429.GA25691@redhat.com> <20051010211918.GA13920@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051010211918.GA13920@kroah.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 10, 2005 at 02:19:18PM -0700, Greg KH wrote:
> > > > +	rv += sprintf(buf + rv, "bsize %u\n", sdp->sd_sb.sb_bsize);
> > > > +	rv += sprintf(buf + rv, "total %lld\n", sc.sc_total);
> > > > +	rv += sprintf(buf + rv, "free %lld\n", sc.sc_free);
> > > > +	rv += sprintf(buf + rv, "dinodes %lld\n", sc.sc_dinodes);
> > > 
> > > No, 1 value per sysfs file please.
> > 
> > I'm aware of that rule and have followed it everywhere else.  This is a
> > special case where the one statfs produces three results.
> 
> Then why not have 4 different files, for the result of the last "statfs"
> command?

More to the point, what the hell is that doing in sysfs in the first place?
