Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132503AbREENtv>; Sat, 5 May 2001 09:49:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132511AbREENtb>; Sat, 5 May 2001 09:49:31 -0400
Received: from smtp1.cern.ch ([137.138.128.38]:22034 "EHLO smtp1.cern.ch")
	by vger.kernel.org with ESMTP id <S132503AbREENt3>;
	Sat, 5 May 2001 09:49:29 -0400
Date: Sat, 5 May 2001 15:49:20 +0200
From: Jamie Lokier <lk@tantalophile.demon.co.uk>
To: Chris Mason <mason@suse.com>
Cc: Andreas Dilger <adilger@turbolinux.com>,
        Linux kernel development list <linux-kernel@vger.kernel.org>
Subject: Re: Maximum files per Directory
Message-ID: <20010505154920.A4571@pcep-jamie.cern.ch>
In-Reply-To: <200105041915.f44JFNeM024068@webber.adilger.int> <392230000.989006902@tiny>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <392230000.989006902@tiny>; from mason@suse.com on Fri, May 04, 2001 at 04:08:22PM -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Chris Mason wrote:
> > Is there a reason that
> > reiserfs chose to have "large number of directories" represented by "1"
> > and not "LINK_MAX+1"?
> 
> find and a few others consider a link count of 1 to mean there is no link
> count tracking being done.

Indeed, and thank you for getting this right!

Btw, is it possible to add dirent->d_type information to reiserfs, and
would there be any performance gain in doing so?

I have code to add d_type for every other filesystem that can support it
without additional disk reads, but I couldn't figure out whether
reiserfs can do it or whether stat() following readdir() is cheap anyway.

-- Jamie (who has written a find-like program)
