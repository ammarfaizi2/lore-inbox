Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261439AbVCGBX7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261439AbVCGBX7 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 6 Mar 2005 20:23:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261633AbVCGBX7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 6 Mar 2005 20:23:59 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:37543 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S261439AbVCGBXI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 6 Mar 2005 20:23:08 -0500
Date: Mon, 7 Mar 2005 01:23:06 +0000
From: Christoph Hellwig <hch@infradead.org>
To: Robert Love <rml@novell.com>
Cc: Christoph Hellwig <hch@infradead.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       John McCutchan <ttb@tentacle.dhs.org>, torvalds@osdl.org
Subject: Re: [patch] inotify for 2.6.11
Message-ID: <20050307012306.GA8248@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Robert Love <rml@novell.com>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	John McCutchan <ttb@tentacle.dhs.org>, torvalds@osdl.org
References: <1109961444.10313.13.camel@betsy.boston.ximian.com> <20050306000409.GD31261@infradead.org> <1110069606.12936.42.camel@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1110069606.12936.42.camel@localhost>
User-Agent: Mutt/1.4.1i
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Mar 05, 2005 at 07:40:06PM -0500, Robert Love wrote:
> On Sun, 2005-03-06 at 00:04 +0000, Christoph Hellwig wrote:
> 
> > The user interface is still bogus.
> 
> I presume you are talking about the ioctl.  I have tried to engage you
> and others on what exactly you prefer instead.  I have said that moving
> to a write interface is fine but I don't see how ut is _any_ better than
> the ioctl.  Write is less typed, in fact, since we lose the command
> versus argument delineation.
> 
> But if it is a anonymous decision, I'll switch it.  Or take patches. ;-)
> It isn't a big deal.

See the review I sent.  Write is exactly the right interface for that kind
of thing.  For comment vs argument either put the number first so we don't
have the problem of finding a delinator that isn't a valid filename, or
use '\0' as such.

> > Also now version of it has stayed in -mm long enough because bad
> > bugs pop up almost weekly.
> 
> I don't follow this sentence.

It means that every re3vision of inotify so far has been buggy in some
respect and ig got dropped from -mm again and again.  It should get some
more testing there and not sent firectly for mainline.

