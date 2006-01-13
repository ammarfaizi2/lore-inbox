Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161573AbWAMVwf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161573AbWAMVwf (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 13 Jan 2006 16:52:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161575AbWAMVwf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 13 Jan 2006 16:52:35 -0500
Received: from omx3-ext.sgi.com ([192.48.171.26]:32211 "EHLO omx3.sgi.com")
	by vger.kernel.org with ESMTP id S1161573AbWAMVwe (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 Jan 2006 16:52:34 -0500
Date: Fri, 13 Jan 2006 13:52:10 -0800
From: Paul Jackson <pj@sgi.com>
To: Adrian Bunk <bunk@stusta.de>
Cc: rdunlap@xenotime.net, akpm@osdl.org, adobriyan@gmail.com,
       linux-kernel@vger.kernel.org
Subject: Re: 2.6.15-mm2: alpha broken
Message-Id: <20060113135210.80aabc8d.pj@sgi.com>
In-Reply-To: <20060113213259.GT29663@stusta.de>
References: <20060107052221.61d0b600.akpm@osdl.org>
	<20060107210646.GA26124@mipter.zuzino.mipt.ru>
	<20060107154842.5832af75.akpm@osdl.org>
	<20060110182422.d26c5d8b.pj@sgi.com>
	<20060113141154.GL29663@stusta.de>
	<20060113101054.d62acb0d.pj@sgi.com>
	<Pine.LNX.4.58.0601131014160.5563@shark.he.net>
	<20060113210848.GS29663@stusta.de>
	<Pine.LNX.4.58.0601131310060.5563@shark.he.net>
	<20060113213259.GT29663@stusta.de>
Organization: SGI
X-Mailer: Sylpheed version 2.1.7 (GTK+ 2.4.9; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Which less extreme approach would for sure have prevented this?

Clearly, if what I said leads inexorably to such extreme measures,
then what I said is full of crock.

And Andrew made a good point, that matches up well with your mention
of your "puny 1.8 GHz CPU."  There is some efficiency to be gained
from doing crosstool builds against 100 changes at once, rather than
100 developers each doing them for their one change.

Personally, I recommend a half-way effort.  Do crosstool builds
against a few arch's when doing more risky stuff; sometimes batch
up crosstool builds for several fixes at once (which may mean that
I actually send in the fix before the crosstool build succeeds);
send in some fixes for what you see broken if it looks "easy enough"
to you; post a description of some of the other breakages you don't
have time or expertise to track down; sometimes just say to heck with
it, and don't crosstool test, or ignore some of the breakage if it
doesn't look like your problem.

But I'm still relatively junior around here.  Those with more battle
scars than I are worth paying more attention to than I am.

My basic rule of thumb, that I suspect scales rather well, is to
try to clean up more crap of others than I drop on them.  If we all
kept a slightly positive balance in our crap cleanup versus dropping
statement, then life would be good.

-- 
                  I won't rest till it's the best ...
                  Programmer, Linux Scalability
                  Paul Jackson <pj@sgi.com> 1.925.600.0401
