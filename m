Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261377AbVARBEr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261377AbVARBEr (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 17 Jan 2005 20:04:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261393AbVARBEr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 17 Jan 2005 20:04:47 -0500
Received: from dialin-159-80.tor.primus.ca ([216.254.159.80]:59776 "EHLO
	node1.opengeometry.net") by vger.kernel.org with ESMTP
	id S261377AbVARBEg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 17 Jan 2005 20:04:36 -0500
Date: Mon, 17 Jan 2005 20:03:42 -0500
From: William Park <opengeometry@yahoo.ca>
To: Al Viro <viro@parcelfarce.linux.theplanet.co.uk>
Cc: Daniel Drake <dsd@gentoo.org>, Andrew Morton <akpm@osdl.org>,
       Joseph Fannin <jhf@rivenstone.net>, linux-kernel@vger.kernel.org,
       Neil Brown <neilb@cse.unsw.edu.au>
Subject: Re: [PATCH] Wait and retry mounting root device (revised)
Message-ID: <20050118010342.GA24328@node1.opengeometry.net>
Mail-Followup-To: Al Viro <viro@parcelfarce.linux.theplanet.co.uk>,
	Daniel Drake <dsd@gentoo.org>, Andrew Morton <akpm@osdl.org>,
	Joseph Fannin <jhf@rivenstone.net>, linux-kernel@vger.kernel.org,
	Neil Brown <neilb@cse.unsw.edu.au>
References: <20050114002352.5a038710.akpm@osdl.org> <20050116005930.GA2273@zion.rivenstone.net> <41EC7A60.9090707@gentoo.org> <20050118003413.GA26051@parcelfarce.linux.theplanet.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050118003413.GA26051@parcelfarce.linux.theplanet.co.uk>
User-Agent: Mutt/1.4.2i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 18, 2005 at 12:34:13AM +0000, Al Viro wrote:
> On Tue, Jan 18, 2005 at 02:54:24AM +0000, Daniel Drake wrote:
> > Retry up to 20 times if mounting the root device fails.  This fixes
> > booting from usb-storage devices, which no longer make their
> > partitions immediately available.
> 
> Sigh...  So we can very well get device coming up in the middle of a
> loop and get the actual attempts to mount the sucker in wrong order.
> How nice...
> 
> Folks, that's not a solution.  And kludges like that really have no
> business being there - they only hide the problem and make it harder
> to reproduce.

The problem at hand is that USB key drive (which is my immediate
concern) takes 5sec to show up.  So, it's much better approach than
'initrd'.

-- 
William Park <opengeometry@yahoo.ca>, Toronto, Canada
Slackware Linux -- because I can type.
