Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268200AbUJOTiD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268200AbUJOTiD (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 15 Oct 2004 15:38:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268392AbUJOTiD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 15 Oct 2004 15:38:03 -0400
Received: from rwcrmhc12.comcast.net ([216.148.227.85]:62623 "EHLO
	rwcrmhc12.comcast.net") by vger.kernel.org with ESMTP
	id S268397AbUJOTge (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 15 Oct 2004 15:36:34 -0400
Subject: Re: per-process shared information
From: Albert Cahalan <albert@users.sf.net>
To: William Lee Irwin III <wli@holomorphy.com>
Cc: Andrea Arcangeli <andrea@novell.com>, Hugh Dickins <hugh@veritas.com>,
       linux-kernel mailing list <linux-kernel@vger.kernel.org>,
       Andrew Morton OSDL <akpm@osdl.org>,
       Albert Cahalan <albert@users.sourceforge.net>
In-Reply-To: <20041015171047.GM5607@holomorphy.com>
References: <Pine.LNX.4.44.0410151207140.5682-100000@localhost.localdomain>
	 <1097846353.2674.13298.camel@cube>
	 <20041015162000.GB17849@dualathlon.random>
	 <1097857912.2669.13548.camel@cube>  <20041015171047.GM5607@holomorphy.com>
Content-Type: text/plain
Organization: 
Message-Id: <1097868590.2669.13838.camel@cube>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.4 
Date: 15 Oct 2004 15:29:51 -0400
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2004-10-15 at 13:10, William Lee Irwin III wrote:
> On Fri, Oct 15, 2004 at 12:31:52PM -0400, Albert Cahalan wrote:
> > Currently, ps uses /proc/*/stat for that. The /proc/*/statm
> > file is read to determine TRS and DRS, which are broken now.
> > That it, unless you count "ps -o OL_m" format.
> > The top program uses /proc/*/statm for many more fields:
> 
> And here I refute every last field with a description of what 2.4.x
> actually implemented and how its implementation renders the field
> gibberish.
...
> Thus we are left with exactly zero fields which are not gibberish in 2.4,
> and 2.4.x semantics have no leg left to stand upon.

Many are reasonable.

Jim developed "top" partly with a 2.2.xx kernel. He had
avoided the statm values at first, for performance, but
went back to using them when he found that the numbers
made more sense than the status and stat numbers did.

It is only recently that Debian stopped defaulting to
the 2.2.xx kernel. This isn't ancient history anywhere
beyond the linux-kernel mailing list.

Changing the columns offered may screw people up.
Believe it or not, people actually use top in scripts.
(everybody together now: "Eeeeeeew!")

Let /proc/*/statm be as slow as it needs to be.
It'll work right on normal systems then, and the
Altix users can simply configure top to display
columns that don't involve the statm files.


