Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263859AbTDVUkw (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Apr 2003 16:40:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263861AbTDVUkw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Apr 2003 16:40:52 -0400
Received: from air-2.osdl.org ([65.172.181.6]:2760 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S263859AbTDVUks (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Apr 2003 16:40:48 -0400
Date: Tue, 22 Apr 2003 13:51:39 -0700
From: "Randy.Dunlap" <rddunlap@osdl.org>
To: Valdis.Kletnieks@vt.edu
Cc: miller@techsource.com, linux-kernel@vger.kernel.org
Subject: Re: Can one build 2.5.68 with allyesconfig?
Message-Id: <20030422135139.0a1ab3cd.rddunlap@osdl.org>
In-Reply-To: <200304222041.h3MKfILq027562@turing-police.cc.vt.edu>
References: <3EA5AABF.4090303@techsource.com>
	<200304222041.h3MKfILq027562@turing-police.cc.vt.edu>
Organization: OSDL
X-Mailer: Sylpheed version 0.8.11 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 22 Apr 2003 16:41:18 -0400 Valdis.Kletnieks@vt.edu wrote:

| On Tue, 22 Apr 2003 16:49:03 EDT, Timothy Miller <miller@techsource.com>  said:
| > Is anyone else able to build 2.5.68 with allyesconfig?
| > 
| > I'm using RH7.2, so the first thing I did was edit the main Makefile to 
| > replace gcc with "gcc3" (3.0.4).  Maybe the compiler is STILL my 
| >
| 
| 1) I think the 3.0.4 compiler had some issues - 3.2.2 may be a better idea.
| 
| 2) allyesconfig is probably NOT able to build an actual kernel that will
| work - in particular, there are a number of pairs/sets of drivers that are
| mutually exclusive for a given device. And as you noticed, allyesconfig
| will try to build stuff that's known to be b0rken.
| 
| 3) Even if it works, it will be a huge kernel with lots of stuff you almost
| certainly don't need (got an ISDN card? I didn't think so ;).  You would more
| likely want to customize the kernel for what you need, or at least consider
| using 'allmodconfig' so you can insmod the parts you need and skip the rest.

After you weed out the 50 or so drivers that won't compile (disable them),
you'll end up with a kernel that is way to big to boot.
I did this about 2 months ago and posted the results to lkml.

But it's a good build-only tool.

--
~Randy
