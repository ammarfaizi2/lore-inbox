Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262517AbUCLUxX (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 12 Mar 2004 15:53:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262519AbUCLUxV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 Mar 2004 15:53:21 -0500
Received: from ns.virtualhost.dk ([195.184.98.160]:8872 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S262517AbUCLUvQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 Mar 2004 15:51:16 -0500
Date: Fri, 12 Mar 2004 21:51:04 +0100
From: Jens Axboe <axboe@suse.de>
To: Chris Mason <mason@suse.com>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       kenneth.w.chen@intel.com
Subject: Re: [PATCH] per-backing dev unplugging #2
Message-ID: <20040312205104.GE16880@suse.de>
References: <20040311083619.GH6955@suse.de> <1079121113.4181.189.camel@watt.suse.com> <20040312120322.0108a437.akpm@osdl.org> <20040312200253.GA16880@suse.de> <1079123647.4186.211.camel@watt.suse.com> <20040312203452.GD16880@suse.de> <1079124097.4187.216.camel@watt.suse.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1079124097.4187.216.camel@watt.suse.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 12 2004, Chris Mason wrote:
> On Fri, 2004-03-12 at 15:34, Jens Axboe wrote:
> 
> > 
> > I don't see how this can make too much of a difference, aside of perhaps
> > just moving the window a little. If page->mapping can disappear here,
> > that's still a possibility.
> 
> As Andrew pointed out, the mapping struct won't disappear, but
> page->mapping may go null.  So the idea is to use barriers to get a
> trusted copy of page->mapping, and use the copy everywhere.

So trusting an atomic assignment of mapping = page->mapping, it should
work. It feels a bit icky, though.

-- 
Jens Axboe

