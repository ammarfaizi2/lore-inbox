Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131624AbRCOD1v>; Wed, 14 Mar 2001 22:27:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131626AbRCOD1b>; Wed, 14 Mar 2001 22:27:31 -0500
Received: from smtp01.mrf.mail.rcn.net ([207.172.4.60]:63927 "EHLO
	smtp01.mrf.mail.rcn.net") by vger.kernel.org with ESMTP
	id <S131624AbRCOD13>; Wed, 14 Mar 2001 22:27:29 -0500
Date: Wed, 14 Mar 2001 22:26:42 -0500
From: Tom Vier <thomassr@erols.com>
To: Denis Perchine <dyp@perchine.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: O_DSYNC flag for open
Message-ID: <20010314222642.A19634@zero>
In-Reply-To: <01031013035702.00608@dyp.perchine.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
User-Agent: Mutt/1.0.1i
In-Reply-To: <01031013035702.00608@dyp.perchine.com>; from dyp@perchine.com on Sat, Mar 10, 2001 at 01:03:57PM +0600
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

fdatasync() is the same as fsync(), in linux. until fdatasync() is
implimented (ie, syncs the data only), there's no reason to define O_DSYNC.
just use:

#ifndef O_DSYNC
# define O_DSYNC O_SYNC
#endif

On Sat, Mar 10, 2001 at 01:03:57PM +0600, Denis Perchine wrote:
> one small question... Will O_DSYNC flag be available in Linux?
> It is available at least on AIX, and HP-UX. The difference with O_SYNC is the 
> same as between fsync and fdatasync.

-- 
Tom Vier <thomassr@erols.com>
DSA Key id 0x27371A2C
