Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932478AbVJYXc2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932478AbVJYXc2 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 25 Oct 2005 19:32:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932479AbVJYXc2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 25 Oct 2005 19:32:28 -0400
Received: from mx2.suse.de ([195.135.220.15]:64745 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S932478AbVJYXc2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 25 Oct 2005 19:32:28 -0400
From: Andi Kleen <ak@suse.de>
To: Blaisorblade <blaisorblade@yahoo.it>
Subject: Re: [PATCH 4/6] x86_64: fix L1_CACHE_SHIFT_MAX for Intel EM64T [for 2.6.14?]
Date: Wed, 26 Oct 2005 01:33:03 +0200
User-Agent: KMail/1.8
Cc: Andrew Morton <akpm@osdl.org>, Jeff Dike <jdike@addtoit.com>,
       linux-kernel@vger.kernel.org,
       user-mode-linux-devel@lists.sourceforge.net
References: <20051025221105.21106.95194.stgit@zion.home.lan> <200510260024.17241.ak@suse.de> <200510260044.26138.blaisorblade@yahoo.it>
In-Reply-To: <200510260044.26138.blaisorblade@yahoo.it>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200510260133.03425.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 26 October 2005 00:44, Blaisorblade wrote:

> For what I see, that's based on the tradeoff between space and contention -
> for instance there are few zones only, so there's no big waste.

If space is precious it shouldn't be padded at all.

> In  practice, interpreting !X86_GENERIC as "I will run this kernel on _this_
> processor" could also be done.

That is what it always meant yes.

> However, in case you didn't note, max_align is never enough on EM64T
> currently, right?

I will prepare patches for .15 to remove it completely, that should fix that 
problem.

-Andi
