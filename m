Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261340AbVBVXUJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261340AbVBVXUJ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Feb 2005 18:20:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261358AbVBVXTy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Feb 2005 18:19:54 -0500
Received: from mail.kroah.org ([69.55.234.183]:11401 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S261340AbVBVXQH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Feb 2005 18:16:07 -0500
Date: Tue, 22 Feb 2005 15:14:50 -0800
From: Greg KH <greg@kroah.com>
To: mikem <mikem@beardog.cca.cpqcorp.net>
Cc: linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org
Subject: Re: CSMI questions
Message-ID: <20050222231450.GB10067@kroah.com>
References: <20050222171656.GA5953@beardog.cca.cpqcorp.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050222171656.GA5953@beardog.cca.cpqcorp.net>
User-Agent: Mutt/1.5.8i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 22, 2005 at 11:16:56AM -0600, mikem wrote:
> All,
> I hate to dredge this up again, but, when Eric Moore submitted changes for MPT
> Fusion driver containing the CSMI ioctls it was rejected. There was talk on
> the linux-scsi list about it being a horrible interface, among other things.
> There were also comments about there being a Linux only approach. Personally,
> I like that idea but it's not good from a business perspective. Especially
> because HP, Dell, and others support more than one OS. Having a unique set of
> management apps for each OS would be very cumbersome.

Honestly, the kernel developers don't care about cross-OS platform
management utilities from a business perspective.  :)

> We've also been looking at how to use sysfs rather than ioctls.

Good.

> Some look reasonable, others seem to be restricted by sysfs itself. 
> 1. only ASCII files are allowed

With 1 value in that file.

> 2. if multiple attributes are contained in one file, who parses out the data?

multiple attributes are not allowed to be contained in a single file.

> 3. one buffer of size (PAGE_SIZE) may not hold all of the data required

You have a _single_ attribute that is bigger than PAGE_SIZE?  What is
it?

> I'd also like an (brief) explanation of why ioctls are so bad. I've seen the 
> reasons of them never going away, etc. But from the beginning of time (UNIX)
> ioctls have been the preferred method of user space/kernel communication.

That's because there was no other method.  See the lkml archives for why
ioctls are considered bad, I don't want to dredge it up again.

Hope this helps,

greg k-h
