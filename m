Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030467AbWFIUAx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030467AbWFIUAx (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 Jun 2006 16:00:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030470AbWFIUAw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 Jun 2006 16:00:52 -0400
Received: from srv5.dvmed.net ([207.36.208.214]:28320 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S1030467AbWFIUAw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 Jun 2006 16:00:52 -0400
Message-ID: <4489D36C.3010000@garzik.org>
Date: Fri, 09 Jun 2006 16:00:44 -0400
From: Jeff Garzik <jeff@garzik.org>
User-Agent: Thunderbird 1.5.0.2 (X11/20060501)
MIME-Version: 1.0
To: Gerrit Huizenga <gh@us.ibm.com>
CC: Michael Poole <mdpoole@troilus.org>, Andrew Morton <akpm@osdl.org>,
       ext2-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org,
       Christoph Hellwig <hch@infradead.org>, cmm@us.ibm.com,
       linux-fsdevel@vger.kernel.org
Subject: Re: [Ext2-devel] [RFC 0/13] extents and 48bit ext3
References: <E1Fomsf-0007hZ-7S@w-gerrit.beaverton.ibm.com>
In-Reply-To: <E1Fomsf-0007hZ-7S@w-gerrit.beaverton.ibm.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Score: -4.2 (----)
X-Spam-Report: SpamAssassin version 3.1.1 on srv5.dvmed.net summary:
	Content analysis details:   (-4.2 points, 5.0 required)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Gerrit Huizenga wrote:
> On Fri, 09 Jun 2006 14:55:56 EDT, Jeff Garzik wrote:
>> Because it's called backwards compat, when it isn't?
>> Because it is very difficult to find out which set of kernels you are 
>> locked out of?
>> Because the filesystem upgrade is stealthy, occurring as it does on the 
>> first data write?
> 
> Actually, the *only* point being contended here is running older
> kernels on some newer filesystems (created originally with a newer
> kernel), right?
> 
> Or do you have examples of where current kernels could not deal
> with an ext3 feature at some point in time?
> 
> I would argue that 0.001% of all Linux *users* actually worry about
> this - most of them are right here on the development mailing list.
> So, that group is more vocal, for sure.  But, if it works for 99.99+%
> users, aren't we still on the good path, from the point of view of
> those people who actually *use* Linux the most?

The overall objection is to treating ext3 as a highly mutable, 
one-size-fits-all filesystem.

Maybe there is value in moving some reiser4 concepts -- a set of 
metadata+algorithm plugins -- to the VFS level.  I dunno.

But for ext3 specifically, it seems like bolting on extents, 48bit, 
delayed allocation, and other new features weren't really suited for the 
original ext2-style design.  Outside of the support (and marketing, 
because that's all version numbers are in the end) issues already 
mentioned, I think it falls into the nebulous realm of "taste."

Rather than taking another decade to slowly fix ext2 design decisions, 
why not move the process along a bit more rapidly?  Release early, 
release often...

	Jeff



