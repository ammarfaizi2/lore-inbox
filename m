Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267553AbUJNWZ5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267553AbUJNWZ5 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 14 Oct 2004 18:25:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268031AbUJNWPs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 14 Oct 2004 18:15:48 -0400
Received: from holomorphy.com ([207.189.100.168]:27269 "EHLO holomorphy.com")
	by vger.kernel.org with ESMTP id S267916AbUJNWLx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 14 Oct 2004 18:11:53 -0400
Date: Thu, 14 Oct 2004 15:11:46 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: Hugh Dickins <hugh@veritas.com>
Cc: Andrea Arcangeli <andrea@novell.com>, linux-kernel@vger.kernel.org,
       Andrew Morton <akpm@osdl.org>
Subject: Re: per-process shared information
Message-ID: <20041014221146.GC5607@holomorphy.com>
References: <20041013231042.GQ17849@dualathlon.random> <Pine.LNX.4.44.0410142205450.2702-100000@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0410142205450.2702-100000@localhost.localdomain>
Organization: The Domain of Holomorphy
User-Agent: Mutt/1.5.6+20040722i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 14, 2004 at 10:49:28PM +0100, Hugh Dickins wrote:
> Sounds horrid to me!  I'm not inclined to volunteer for that: plus this
> is very much Bill's territory, though he might be glad to surrender it!
> But how about the patch below?  Really a mixture of four patches...
> One, support anon_rss as a subset of rss, "shared" being (rss - anon_rss).
> Yes, that's a slight change in meaning of "shared" from in 2.4, but easy
> to support and I think very reasonable.  On the one hand, yes, of course
> we know an anon page may actually be shared between several mms of the
> fork group, whereas it won't be counted in "shared" with this patch. But
> the old definition of "shared" was considerably more stupid, wasn't it?
> for example, a private page in pte and swap cache got counted as shared.

This is all very reasonable.


-- wli
