Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030549AbWFIVxV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030549AbWFIVxV (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 Jun 2006 17:53:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030548AbWFIVxV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 Jun 2006 17:53:21 -0400
Received: from srv5.dvmed.net ([207.36.208.214]:33190 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S1030544AbWFIVxU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 Jun 2006 17:53:20 -0400
Message-ID: <4489EDCA.5040808@garzik.org>
Date: Fri, 09 Jun 2006 17:53:14 -0400
From: Jeff Garzik <jeff@garzik.org>
User-Agent: Thunderbird 1.5.0.2 (X11/20060501)
MIME-Version: 1.0
To: Michael Poole <mdpoole@troilus.org>
CC: Theodore Tso <tytso@mit.edu>, Gerrit Huizenga <gh@us.ibm.com>,
       Andrew Morton <akpm@osdl.org>, ext2-devel@lists.sourceforge.net,
       linux-kernel@vger.kernel.org, Christoph Hellwig <hch@infradead.org>,
       cmm@us.ibm.com, linux-fsdevel@vger.kernel.org
Subject: Re: [Ext2-devel] [RFC 0/13] extents and 48bit ext3
References: <E1Fomsf-0007hZ-7S@w-gerrit.beaverton.ibm.com>	<4489D36C.3010000@garzik.org> <20060609203523.GE10524@thunk.org>	<4489EAFE.6090303@garzik.org> <87ac8matr2.fsf@graviton.dyn.troilus.org>
In-Reply-To: <87ac8matr2.fsf@graviton.dyn.troilus.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Score: -4.2 (----)
X-Spam-Report: SpamAssassin version 3.1.1 on srv5.dvmed.net summary:
	Content analysis details:   (-4.2 points, 5.0 required)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Michael Poole wrote:
> Jeff Garzik writes:
> 
>> Theodore Tso wrote:
>>> And I'd also dispute with your "weren't really suited for the original
>>> ext2-style design" comment.  Ext2/3 was always designed to be
>>> extensible from the start, and we've successfully added features quite
>>> successfully for quite a while.
>> Although not the only disk format change, extents are a pretty big
>> one. Will this be the last major on-disk format change?
> 
> You keep making "straw that broke the camel's back" type arguments
> without saying why this particular straw (rather than the other
> compatibility-breaking features that are already in ext3) is the one
> that must not be allowed.  Is it a matter of taste, or is there some
> objective threshold that extents cross?

Yes, it's not a small change to the on-disk format.

If you write tools that read an ext3 filesystem, you won't be able to 
read file data at all, without updating your code.

That's a much bigger deal than say 32-bit uids.

	Jeff



