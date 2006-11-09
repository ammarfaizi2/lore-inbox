Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1423985AbWKIPP4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423985AbWKIPP4 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Nov 2006 10:15:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423875AbWKIPP4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Nov 2006 10:15:56 -0500
Received: from caffeine.uwaterloo.ca ([129.97.134.17]:17126 "EHLO
	caffeine.csclub.uwaterloo.ca") by vger.kernel.org with ESMTP
	id S1423985AbWKIPPz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Nov 2006 10:15:55 -0500
Date: Thu, 9 Nov 2006 10:15:46 -0500
To: Suzuki <suzuki@linux.vnet.ibm.com>, reiserfs-list@namesys.com,
       lkml <linux-kernel@vger.kernel.org>, Jan Kara <jack@suse.cz>
Subject: Re: Problem with multiple mounts
Message-ID: <20061109151546.GA8236@csclub.uwaterloo.ca>
References: <45522E67.7050907@linux.vnet.ibm.com> <20061108203323.GA8238@csclub.uwaterloo.ca> <45525C82.5080303@linux.vnet.ibm.com> <20061108230623.GZ6012@schatzie.adilger.int>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061108230623.GZ6012@schatzie.adilger.int>
User-Agent: Mutt/1.5.9i
From: Lennart Sorensen <lsorense@csclub.uwaterloo.ca>
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: lsorense@csclub.uwaterloo.ca
X-SA-Exim-Scanned: No (on caffeine.csclub.uwaterloo.ca); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 08, 2006 at 04:06:23PM -0700, Andreas Dilger wrote:
> I would suggest that even while this is not supported, it would be prudent
> to fix such a bug.  It might be possible to hit a similar problem if there
> is corruption of the on-disk data in the journal and oopsing the kernel
> isn't a graceful way to deal with bad data on disk.

On the other hand corrupt data at least doesn't change under you while
you are trying to figure out the filesystem.  This particular use would
have meta data changing while you are trying to read it, making things
not be consistent with each other from one moment to another.  There may
be nothing that can be done about it.

--
Len Sorensen
