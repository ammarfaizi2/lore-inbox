Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261647AbUK2KHV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261647AbUK2KHV (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 29 Nov 2004 05:07:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261649AbUK2KHV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 29 Nov 2004 05:07:21 -0500
Received: from unthought.net ([212.97.129.88]:38306 "EHLO unthought.net")
	by vger.kernel.org with ESMTP id S261647AbUK2KHJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 29 Nov 2004 05:07:09 -0500
Date: Mon, 29 Nov 2004 11:07:08 +0100
From: Jakob Oestergaard <jakob@unthought.net>
To: linux-kernel@vger.kernel.org
Cc: Neil Brown <neilb@cse.unsw.edu.au>
Subject: Re: raid1 oops in 2.6.9 (debian package 2.6.9-1-686-smp)
Message-ID: <20041129100707.GX4469@unthought.net>
Mail-Followup-To: Jakob Oestergaard <jakob@unthought.net>,
	linux-kernel@vger.kernel.org, Neil Brown <neilb@cse.unsw.edu.au>
References: <20041128142840.GA4119@mur.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041128142840.GA4119@mur.org.uk>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Nov 28, 2004 at 02:28:41PM +0000, Robert Murray wrote:
> Hi
> 
> The complete console log can be found at http://haylott.plus.com/~robbie/md-oops.txt
> 
> hde is a failed drive. In this log, hdg (the other drive in the raid1
> array) is not present. This oops also occurs when hdg is present. I
> don't know why it tries to use hde when it has been failed for some
> time now.  This doesn't occur with 2.6.8 (also a debian kernel). I
> don't have a log of the oops when hdg was present, but I can provide
> one if necessary.
> 
> Please let me know if there is any other information I can provide to
> help to debug this.  For now I have removed hde and everything is
> working fine.

On a second note:  Could someone please provide an explanation of why
the raid10 driver exists?  People have created RAID-10 sets for years
using the RAID-0 driver on top of several RAID-1 arrays - this works
beautifully, it's simple, and it's easy to explain to people.

Why oh why, do we need raid10 ?

(I don't mean to bitch and moan over it - I just assume that there is a
good reason for it which was somehow never conveyed, or that I
overlooked in my search for this explanation)

And; if raid10 does not provide new functionality that was not possible
with raid1 + raid0, why oh why does this get accepted in a stable kernel
series?   (ok, 2.6 is not stable, but I assume the intention is to make
it stable eventually, and accepting new functionality does not help this
process - all in all I do not understand the raid10 submission at all,
but I hope to be enlightened by someone (Neil?))

Also, I'd love to add a mention of raid10 in the HOWTO, but I need to
know why raid10 even exists before I can reasonably do that.

-- 

 / jakob "baffled Software-RAID HOWTO co-author"

