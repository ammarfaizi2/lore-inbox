Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268323AbUHFVN3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268323AbUHFVN3 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 6 Aug 2004 17:13:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268328AbUHFVM2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 6 Aug 2004 17:12:28 -0400
Received: from sccrmhc13.comcast.net ([204.127.202.64]:26817 "EHLO
	sccrmhc13.comcast.net") by vger.kernel.org with ESMTP
	id S268323AbUHFVKN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 6 Aug 2004 17:10:13 -0400
Subject: Re: [proc.txt] Fix /proc/pid/statm documentation
From: Albert Cahalan <albert@users.sf.net>
To: "Martin J. Bligh" <mbligh@aracnet.com>
Cc: Albert Cahalan <albert@users.sourceforge.net>,
       Roger Luethi <rl@hellgate.ch>,
       William Lee Irwin III <wli@holomorphy.com>,
       linux-kernel mailing list <linux-kernel@vger.kernel.org>,
       linux-mm@kvack.org
In-Reply-To: <283440000.1091825375@flay>
References: <1091754711.1231.2388.camel@cube>
	 <20040806094037.GB11358@k3.hellgate.ch>
	 <20040806104630.GA17188@holomorphy.com>
	 <20040806120123.GA23081@k3.hellgate.ch> <1091800948.1231.2454.camel@cube>
	 <20040806170832.GA898@k3.hellgate.ch> <1091805296.3547.2522.camel@cube>
	 <283440000.1091825375@flay>
Content-Type: text/plain
Organization: 
Message-Id: <1091817534.1232.2542.camel@cube>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.4 
Date: 06 Aug 2004 14:38:54 -0400
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2004-08-06 at 16:49, Martin J. Bligh wrote:

> > As long as I can fall back to the old /proc files when truly
> > radical kernel changes happen, exposure of kernel internals
> > isn't a serious problem.
> > 
> > If I had the DWARF2 data alone, /dev/mem might be enough.
> > (sadly, "top" would require some major work before I'd trust it)
> 
> We did that on PTX ... walking tasklists lockless is a bitch.

It's fast. Lockless tasklist walking looks easy enough.
Find the process, grab the data, then find the process
again. If the process went away, discard the data.

I guess I'd like to have a /dev/ram-only device, for protection
against touching device memory (including AGP mem) by mistake.
It's odd that there doesn't seem to be such a device already.
Without this, I'd need to re-verify much more often.

Any problem I'm not seeing?


