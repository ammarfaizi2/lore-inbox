Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932294AbWAQTnV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932294AbWAQTnV (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 Jan 2006 14:43:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932424AbWAQTnV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 Jan 2006 14:43:21 -0500
Received: from kanga.kvack.org ([66.96.29.28]:23982 "EHLO kanga.kvack.org")
	by vger.kernel.org with ESMTP id S932294AbWAQTnU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 Jan 2006 14:43:20 -0500
Date: Tue, 17 Jan 2006 14:39:13 -0500
From: Benjamin LaHaise <bcrl@kvack.org>
To: Cynbe ru Taren <cynbe@muq.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: FYI: RAID5 unusably unstable through 2.6.14
Message-ID: <20060117193913.GD3714@kvack.org>
References: <E1EywcM-0004Oz-IE@laurel.muq.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <E1EywcM-0004Oz-IE@laurel.muq.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 17, 2006 at 01:35:46PM -0600, Cynbe ru Taren wrote:
> In principle, RAID5 should allow construction of a
> disk-based store which is considerably MORE reliable
> than any individual drive.
> 
> In my experience, at least, using Linux RAID5 results
> in a disk storage system which is considerably LESS
> reliable than the underlying drives.

That is a function of how RAID5 works.  A properly configured RAID5 array 
will have a spare disk to take over in case one of the members fails, as 
otherwise you run a serious risk of not being able to recover any data.

> What happens repeatedly, at least in my experience over
> a variety of boxes running a variety of 2.4 and 2.6
> Linux kernel releases, is that any transient I/O problem
> results in a critical mass of RAID5 drives being marked
> 'failed', at which point there is no longer any supported
> way of retrieving the data on the RAID5 device, even
> though the underlying drives are all fine, and the underlying
> data on those drives almost certainly intact.

Underlying disks should not be experiencing transient failures.  Are you 
sure the problem isn't with the disk controller you're building your array 
on top of?  At the very least any bug report requires that information to 
be able to provide even a basic analysis of what is going wrong.

Personally, I am of the opinion that RAID5 should not be used by the 
vast majority of people as the failure modes it entails are far too 
complex for most people to cope with.

		-ben
-- 
"You know, I've seen some crystals do some pretty trippy shit, man."
Don't Email: <dont@kvack.org>.
