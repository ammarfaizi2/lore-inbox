Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965287AbWFIUwy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965287AbWFIUwy (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 Jun 2006 16:52:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965280AbWFIUwy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 Jun 2006 16:52:54 -0400
Received: from mx1.redhat.com ([66.187.233.31]:20407 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S965255AbWFIUwx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 Jun 2006 16:52:53 -0400
Subject: Re: [Ext2-devel] [RFC 0/13] extents and 48bit ext3
From: "Stephen C. Tweedie" <sct@redhat.com>
To: Jeff Garzik <jeff@garzik.org>
Cc: Alex Tomas <alex@clusterfs.com>, Andrew Morton <akpm@osdl.org>,
       "ext2-devel@lists.sourceforge.net" <ext2-devel@lists.sourceforge.net>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       Linus Torvalds <torvalds@osdl.org>, Mingming Cao <cmm@us.ibm.com>,
       linux-fsdevel@vger.kernel.org, Andreas Dilger <adilger@clusterfs.com>,
       Stephen Tweedie <sct@redhat.com>
In-Reply-To: <44899A1C.7000207@garzik.org>
References: <1149816055.4066.60.camel@dyn9047017069.beaverton.ibm.com>
	 <4488E1A4.20305@garzik.org>	<20060609083523.GQ5964@schatzie.adilger.int>
	 <44898EE3.6080903@garzik.org> <448992EB.5070405@garzik.org>
	 <Pine.LNX.4.64.0606090836160.5498@g5.osdl.org>	<448997FA.50109@garzik.org>
	 <m3irnacohp.fsf@bzzz.home.net>  <44899A1C.7000207@garzik.org>
Content-Type: text/plain
Date: Fri, 09 Jun 2006 21:52:42 +0100
Message-Id: <1149886363.5776.109.camel@sisko.sctweedie.blueyonder.co.uk>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.2 (2.0.2-27) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Fri, 2006-06-09 at 11:56 -0400, Jeff Garzik wrote:

> Think about how this will be deployed in production, long term.
> 
> If extents are not made default at some point, then no one will use the 
> feature, and it should not be merged.

Features such as ACLs and SELinux are still not on by default and are
most *definitely* used.  This is a bogus argument.

> And when extents are default, you have this blizzard-of-feature-flags 
> stealth upgrade event occur _sometime_ after they boot into the new fs 
> for the first time.

No.  I don't see it ever being forced on in the kernel by default, so
there will be no such "stealth upgrades".

Rather, if it is "made default", that will be done by setting the flag
by default on newly-created filesystems in mke2fs.  We won't be playing
magic on existing filesystems.

And to avoid confusion, I am *entirely* open to the idea of making it
only ever default to on in mke2fs at some point in the future where we
batch a set of incompat features with the "ext4" label, so that "mke2fs
-O ext4", or "mke4fs", would set it.  That has already been proposed on
ext2-devel; we're nowhere near the stage of making that default yet.

--Stephen


