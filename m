Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268216AbUJOREQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268216AbUJOREQ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 15 Oct 2004 13:04:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268213AbUJOREQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 15 Oct 2004 13:04:16 -0400
Received: from mail-relay-4.tiscali.it ([213.205.33.44]:46011 "EHLO
	mail-relay-4.tiscali.it") by vger.kernel.org with ESMTP
	id S268214AbUJORD6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 15 Oct 2004 13:03:58 -0400
Date: Fri, 15 Oct 2004 19:02:36 +0200
From: Andrea Arcangeli <andrea@novell.com>
To: Albert Cahalan <albert@users.sf.net>
Cc: William Lee Irwin III <wli@holomorphy.com>,
       Hugh Dickins <hugh@veritas.com>,
       linux-kernel mailing list <linux-kernel@vger.kernel.org>,
       Andrew Morton OSDL <akpm@osdl.org>,
       Albert Cahalan <albert@users.sourceforge.net>
Subject: Re: per-process shared information
Message-ID: <20041015170236.GC17849@dualathlon.random>
References: <Pine.LNX.4.44.0410151207140.5682-100000@localhost.localdomain> <1097846353.2674.13298.camel@cube> <20041015142825.GI5607@holomorphy.com> <1097851258.2666.13421.camel@cube>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1097851258.2666.13421.camel@cube>
X-GPG-Key: 1024D/68B9CB43 13D9 8355 295F 4823 7C49  C012 DFA1 686E 68B9 CB43
X-PGP-Key: 1024R/CB4660B9 CC A0 71 81 F4 A0 63 AC  C0 4B 81 1D 8C 15 C8 E5
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 15, 2004 at 10:40:58AM -0400, Albert Cahalan wrote:
> Why not get rid of rss too then? It's overhead.

"rss" is O(1), old "shared" is O(N). With N being a few terabytes of
data divided by PAGE_SIZE...

on any desktop machine you couldn't notice the difference, it only
matters on the high end.

But I believe Hugh's proposal will make everyone happy. Anything that we
stuff in statm must have O(1) complexity (or at least O(log(N)),
otherwise ps v will nearly stop running in the big boxes.
