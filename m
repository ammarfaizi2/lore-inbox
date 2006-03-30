Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750913AbWC3Pb3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750913AbWC3Pb3 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 30 Mar 2006 10:31:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750951AbWC3Pb3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 30 Mar 2006 10:31:29 -0500
Received: from unthought.net ([212.97.129.88]:27913 "EHLO unthought.net")
	by vger.kernel.org with ESMTP id S1750896AbWC3Pb3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 30 Mar 2006 10:31:29 -0500
Date: Thu, 30 Mar 2006 17:31:28 +0200
From: Jakob Oestergaard <jakob@unthought.net>
To: Justin Piszcz <jpiszcz@lucidpixels.com>
Cc: Trond Myklebust <trond.myklebust@fys.uio.no>, linux-kernel@vger.kernel.org,
       nfs@lists.sourceforge.net
Subject: Re: NFS/Kernel Problem: getfh failed: Operation not permitted
Message-ID: <20060330153128.GB9811@unthought.net>
Mail-Followup-To: Jakob Oestergaard <jakob@unthought.net>,
	Justin Piszcz <jpiszcz@lucidpixels.com>,
	Trond Myklebust <trond.myklebust@fys.uio.no>,
	linux-kernel@vger.kernel.org, nfs@lists.sourceforge.net
References: <Pine.LNX.4.64.0603300813270.18696@p34> <1143728720.8074.41.camel@lade.trondhjem.org> <Pine.LNX.4.64.0603300929340.18696@p34> <1143729766.8074.49.camel@lade.trondhjem.org> <Pine.LNX.4.64.0603300949000.18696@p34> <1143731364.8074.53.camel@lade.trondhjem.org> <Pine.LNX.4.64.0603301011160.18696@p34>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0603301011160.18696@p34>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 30, 2006 at 10:13:38AM -0500, Justin Piszcz wrote:
> On Thu, 30 Mar 2006, Trond Myklebust wrote:
> 
...
> In the /etc/exports file, I have an entry that looks like this:
> /path	specific-host-001(ro,root_squash,no_sync)
> /path	specific-host-002((ro,root_squash,no_sync)
> /path	*(ro,root_squash,no_sync)

I don't know how this works today, but historically Linux has been
completely unable to deal with any kind of names in /etc/exports.
Netgroups, DNS names, ...  And the results have been the strangest mix
of things sort-of-mostly-but-not-quite working.

I'd put in IP addresses, netmasks or '*', and see if that solves the
problem.

Again, I don't know if this is related to what you're seeing, but I'd
say it's worth a shot :)

-- 

 / jakob

