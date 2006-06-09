Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030536AbWFIVrd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030536AbWFIVrd (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 Jun 2006 17:47:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030535AbWFIVrd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 Jun 2006 17:47:33 -0400
Received: from srv5.dvmed.net ([207.36.208.214]:8614 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S1030533AbWFIVrc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 Jun 2006 17:47:32 -0400
Message-ID: <4489EC6B.4010200@garzik.org>
Date: Fri, 09 Jun 2006 17:47:23 -0400
From: Jeff Garzik <jeff@garzik.org>
User-Agent: Thunderbird 1.5.0.2 (X11/20060501)
MIME-Version: 1.0
To: "Stephen C. Tweedie" <sct@redhat.com>
CC: Alex Tomas <alex@clusterfs.com>, Andrew Morton <akpm@osdl.org>,
       "ext2-devel@lists.sourceforge.net" <ext2-devel@lists.sourceforge.net>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       Linus Torvalds <torvalds@osdl.org>, Mingming Cao <cmm@us.ibm.com>,
       linux-fsdevel@vger.kernel.org, Andreas Dilger <adilger@clusterfs.com>
Subject: Re: [Ext2-devel] [RFC 0/13] extents and 48bit ext3
References: <1149816055.4066.60.camel@dyn9047017069.beaverton.ibm.com>	 <4488E1A4.20305@garzik.org>	<20060609083523.GQ5964@schatzie.adilger.int>	 <44898EE3.6080903@garzik.org> <448992EB.5070405@garzik.org>	 <Pine.LNX.4.64.0606090836160.5498@g5.osdl.org>	<448997FA.50109@garzik.org>	 <m3irnacohp.fsf@bzzz.home.net>  <44899A1C.7000207@garzik.org> <1149886363.5776.109.camel@sisko.sctweedie.blueyonder.co.uk>
In-Reply-To: <1149886363.5776.109.camel@sisko.sctweedie.blueyonder.co.uk>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Score: -4.2 (----)
X-Spam-Report: SpamAssassin version 3.1.1 on srv5.dvmed.net summary:
	Content analysis details:   (-4.2 points, 5.0 required)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Stephen C. Tweedie wrote:
> Hi,
> 
> On Fri, 2006-06-09 at 11:56 -0400, Jeff Garzik wrote:
> 
>> Think about how this will be deployed in production, long term.
>>
>> If extents are not made default at some point, then no one will use the 
>> feature, and it should not be merged.
> 
> Features such as ACLs and SELinux are still not on by default and are
> most *definitely* used.  This is a bogus argument.

They are on in SElinux-enabled distro installs, AFAIK?


>> And when extents are default, you have this blizzard-of-feature-flags 
>> stealth upgrade event occur _sometime_ after they boot into the new fs 
>> for the first time.
> 
> No.  I don't see it ever being forced on in the kernel by default, so
> there will be no such "stealth upgrades".
> 
> Rather, if it is "made default", that will be done by setting the flag
> by default on newly-created filesystems in mke2fs.  We won't be playing
> magic on existing filesystems.
> 
> And to avoid confusion, I am *entirely* open to the idea of making it
> only ever default to on in mke2fs at some point in the future where we
> batch a set of incompat features with the "ext4" label, so that "mke2fs
> -O ext4", or "mke4fs", would set it.  That has already been proposed on
> ext2-devel; we're nowhere near the stage of making that default yet.

Sure.  And why not bundle that with a vehicle for separating out the 
_code_ that deals with ancient formats versus newer formats.  A vehicle 
that enables the existing ext3 stuff to stabilize and freeze, while 
enabling parallel development of new features.

	Jeff


