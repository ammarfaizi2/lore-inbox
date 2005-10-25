Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932431AbVJYWXb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932431AbVJYWXb (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 25 Oct 2005 18:23:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932443AbVJYWXb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 25 Oct 2005 18:23:31 -0400
Received: from cantor.suse.de ([195.135.220.2]:59582 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S932431AbVJYWXa (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 25 Oct 2005 18:23:30 -0400
From: Andi Kleen <ak@suse.de>
To: "Paolo 'Blaisorblade' Giarrusso" <blaisorblade@yahoo.it>
Subject: Re: [PATCH 4/6] x86_64: fix L1_CACHE_SHIFT_MAX for Intel EM64T [for 2.6.14?]
Date: Wed, 26 Oct 2005 00:24:16 +0200
User-Agent: KMail/1.8
Cc: Andrew Morton <akpm@osdl.org>, Jeff Dike <jdike@addtoit.com>,
       linux-kernel@vger.kernel.org,
       user-mode-linux-devel@lists.sourceforge.net
References: <20051025221105.21106.95194.stgit@zion.home.lan> <20051025221253.21106.22572.stgit@zion.home.lan>
In-Reply-To: <20051025221253.21106.22572.stgit@zion.home.lan>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200510260024.17241.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> No correctness issues, obviously. So this could even be merged for 2.6.14
> (I'm not a fan of this idea, though).

I don't think it's a good idea to mess with this for 2.6.14

In general the maxaligned stuff is imho bogus and should be removed. That is 
what CONFIG_X86_GENERIC is for. It doesn't make sense imho to separate
the variables in two aligned classes - either they should be aligned in 
all cases or they shouldn't.

-Andi


