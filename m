Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932405AbWBGWmp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932405AbWBGWmp (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Feb 2006 17:42:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932409AbWBGWmo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Feb 2006 17:42:44 -0500
Received: from smtp.osdl.org ([65.172.181.4]:11415 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932405AbWBGWmo (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Feb 2006 17:42:44 -0500
Date: Tue, 7 Feb 2006 14:44:33 -0800
From: Andrew Morton <akpm@osdl.org>
To: Jens Axboe <axboe@suse.de>
Cc: mrmacman_g4@mac.com, ak@suse.de, hch@infradead.org, jeffm@suse.com,
       linux-kernel@vger.kernel.org, kernel-bugzilla@luksan.cjb.net
Subject: Re: quality control
Message-Id: <20060207144433.6bdc4f66.akpm@osdl.org>
In-Reply-To: <20060206134415.GZ13598@suse.de>
References: <43E64791.8010302@namesys.com>
	<43E6521F.5020707@suse.com>
	<43E6BF48.5010301@namesys.com>
	<BAFD888C-7E6B-49B1-A394-901D24CFBCBF@mac.com>
	<p73hd7clp5k.fsf@verdi.suse.de>
	<96DB44F5-85D3-4F78-8417-D5AB9303D696@mac.com>
	<20060206134415.GZ13598@suse.de>
X-Mailer: Sylpheed version 1.0.0 (GTK+ 1.2.10; i386-vine-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jens Axboe <axboe@suse.de> wrote:
>
> Look, it's really simple: lets say I make a change that has to do with
> PM, you do a quick compile test with and _without_ PM just to check you
> didn't screw anything up with that change. You change reiserfs acl
> stuff, you do a quick compile test with and without that configured.
> 
> It's a pretty standard procedure, and contrary to what you think, it
> _is_ required before submitting a patch. No one is asking anyone to
> check all possible configure options, but the interesting data set is
> typically extremely easy to guess looking at a change.

<rofl>

bix:/usr/src/op> find patches -name '*build-fix*' | wc -l
    533

bix:/usr/src/op> find patches -name '*fix.patch' | wc -l
   5109

A lot of people don't make the slightest effort.  But it's not a big
problem, really.  Silly build errors are reported early and are almost
always trivial to fix.  The major drawback is that they can wreck a -mm
release for many testers.

