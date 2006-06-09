Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030232AbWFIPvX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030232AbWFIPvX (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 Jun 2006 11:51:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030225AbWFIPvW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 Jun 2006 11:51:22 -0400
Received: from srv5.dvmed.net ([207.36.208.214]:3725 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S1030232AbWFIPvV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 Jun 2006 11:51:21 -0400
Message-ID: <448998F2.5070206@garzik.org>
Date: Fri, 09 Jun 2006 11:51:14 -0400
From: Jeff Garzik <jeff@garzik.org>
User-Agent: Thunderbird 1.5.0.2 (X11/20060501)
MIME-Version: 1.0
To: Matthew Wilcox <matthew@wil.cx>
CC: Andrew Morton <akpm@osdl.org>, Christoph Hellwig <hch@infradead.org>,
       cmm@us.ibm.com, linux-kernel@vger.kernel.org,
       ext2-devel@lists.sourceforge.net, linux-fsdevel@vger.kernel.org
Subject: Re: [RFC 0/13] extents and 48bit ext3
References: <1149816055.4066.60.camel@dyn9047017069.beaverton.ibm.com> <20060609091327.GA3679@infradead.org> <20060609030759.48cd17a0.akpm@osdl.org> <44899653.1020007@garzik.org> <20060609154238.GN1651@parisc-linux.org>
In-Reply-To: <20060609154238.GN1651@parisc-linux.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Score: -4.2 (----)
X-Spam-Report: SpamAssassin version 3.1.1 on srv5.dvmed.net summary:
	Content analysis details:   (-4.2 points, 5.0 required)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Matthew Wilcox wrote:
> On Fri, Jun 09, 2006 at 11:40:03AM -0400, Jeff Garzik wrote:
>> Users are now forced to remember that, if they write to their filesystem 
>> after using either $mmver or $korgver kernels, they are locked out of 
>> using older kernels.
>>
>> From the user's perspective, ext3 has no clear "metadata version 1", 
>> "metadata version 2" division.  Thus they are now forced to keep a 
>> matrix of kernel versions and ext3 feature flag support, to know which 
>> kernels are usable with which data.  It is a support nightmare.
> 
> Hang on, you're going too far.  You have to enable extents with the
> extent mount option.  Otherwise you don't get to use them.  The user
> does, in fact, have a clear division, although maybe the blinky signs
> aren't quite luminous enough.

...and how are distros going to deploy this?  They are going to turn on 
extents by default.

And do we honestly think that is a scalable option _anyway_?  That will 
slowly bloat fstab and mount command lines with an ever-increasing list 
of options.

It's IMO better experience for the user, and gives the developers more 
freedom.Look, I _really_ want extents.  I am a big fan.  But I think 
that extents are good time to make a clean break, and let ext3 live as 
it is.  And it will let ext3 stabilize.

	Jeff



