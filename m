Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264399AbTKMT2o (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 13 Nov 2003 14:28:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264400AbTKMT2o
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 13 Nov 2003 14:28:44 -0500
Received: from ipcop.bitmover.com ([192.132.92.15]:60049 "EHLO
	work.bitmover.com") by vger.kernel.org with ESMTP id S264399AbTKMT2n
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 13 Nov 2003 14:28:43 -0500
Date: Thu, 13 Nov 2003 11:28:39 -0800
From: Larry McVoy <lm@bitmover.com>
To: Andrew Walrond <andrew@walrond.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: kernel.bkbits.net off the air
Message-ID: <20031113192839.GA13330@work.bitmover.com>
Mail-Followup-To: Larry McVoy <lm@work.bitmover.com>,
	Andrew Walrond <andrew@walrond.org>, linux-kernel@vger.kernel.org
References: <fa.eto0cvm.1v20528@ifi.uio.no> <200311131010.27315.andrew@walrond.org> <20031113162712.GA2462@work.bitmover.com> <200311131917.11773.andrew@walrond.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200311131917.11773.andrew@walrond.org>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 13, 2003 at 07:17:11PM +0000, Andrew Walrond wrote:
> And I still maintain that a stripped out, redistributable, clone/pull only 
> binary tool without the restrictive license would be a real smart business 
> move.

I'm trying to see why.

Our commercial customers don't care about this so there isn't any business
incentive there.

The actual BK users don't care about this, they use BK.

The BK detractors aren't going to touch anything that we produce, they are 
convinced we're out to do them harm somehow.

So who's left?

And a better question is why doesn't some open source person do this?  All 
you need to do is create a network daemon which responds to clone requests
and pull requests.  The clone request sends across a tarball and the client
side untars it.  The pull request sends a changeset key (which was sent in
the last clone/pull) and gets a tarball of new/changed files, the new 
top of trunk changeset key, and a list of renames.  Actually the easier way
is to do it more like diff does, for each file that has been changed, send
across a "delete this file and any directories the deletion leaves empty"
list, and then you unpack the tarball on top of the tree.

This would be easy to build but I don't see it solving anything.  All it
does is act as a replacement for rsync.  It doesn't have revision history,
you can't do diffs, etc.  As soon as this exists, people will ask you
for all the other features.  Which is why I don't want to build it, I
don't want to get sucked into the "please rebuild BK as a GPLed product"
business.

What am I missing?
-- 
---
Larry McVoy              lm at bitmover.com          http://www.bitmover.com/lm
