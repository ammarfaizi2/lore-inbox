Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261662AbUBVDbP (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 21 Feb 2004 22:31:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261664AbUBVDbO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 21 Feb 2004 22:31:14 -0500
Received: from uslink-66.173.43-133.uslink.net ([66.173.43.133]:54144 "EHLO
	dingdong.cryptoapps.com") by vger.kernel.org with ESMTP
	id S261662AbUBVDbM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 21 Feb 2004 22:31:12 -0500
Date: Sat, 21 Feb 2004 19:31:11 -0800
From: Chris Wedgwood <cw@f00f.org>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Mike Fedyk <mfedyk@matchmail.com>, linux-kernel@vger.kernel.org
Subject: Re: Large slab cache in 2.6.1
Message-ID: <20040222033111.GA14197@dingdong.cryptoapps.com>
References: <4037FCDA.4060501@matchmail.com> <20040222023638.GA13840@dingdong.cryptoapps.com> <Pine.LNX.4.58.0402211901520.3301@ppc970.osdl.org> <20040222031113.GB13840@dingdong.cryptoapps.com> <Pine.LNX.4.58.0402211919360.3301@ppc970.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0402211919360.3301@ppc970.osdl.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Feb 21, 2004 at 07:28:24PM -0800, Linus Torvalds wrote:

> What happened to the experiment of having slab pages on the
> (in)active lists and letting them be free'd that way? Didn't
> somebody already do that? Ed Tomlinson and Craig Kulesa?

Just as a data point:

cw@taniwha:~/wk/linux/bk-2.5.x$ grep -E '(LowT|Slab)' /proc/meminfo
LowTotal:       898448 kB
Slab:           846260 kB

So the slab pressure I have right now is simply because there is
nowhere else it has to grow...


