Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268750AbUJEDKJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268750AbUJEDKJ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 4 Oct 2004 23:10:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268752AbUJEDKI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 4 Oct 2004 23:10:08 -0400
Received: from gate.crashing.org ([63.228.1.57]:23177 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S268750AbUJEDKE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 4 Oct 2004 23:10:04 -0400
Subject: Re: [PATCH] I/O space write barrier
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Jesse Barnes <jbarnes@sgi.com>
Cc: Albert Cahalan <albert@users.sourceforge.net>,
       linux-kernel mailing list <linux-kernel@vger.kernel.org>
In-Reply-To: <200410041926.57205.jbarnes@sgi.com>
References: <1096922369.2666.177.camel@cube>
	 <1096936344.2674.198.camel@cube> <1096939347.24537.2.camel@gaston>
	 <200410041926.57205.jbarnes@sgi.com>
Content-Type: text/plain
Message-Id: <1096945479.24537.15.camel@gaston>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Tue, 05 Oct 2004 13:04:39 +1000
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> I agree, it's hard to get right, especially when you've got a large base of 
> drivers with hard to find assumptions about ordering.
> 
> What about mmiowb()?  Should it be eieio?  I don't want to post another patch 
> if I don't have to...

I don't understand the whole story...

If normal accesses aren't relaxed (and I think they shouldn't be), then
there is no point in a barrier here.... If you need an explicit barrier
for explicitely relaxed accesses, then yes.

That doesn't solve my need of MMIO vs. memory unless you are trying to
cover that as well, in which case it should be a sync.

Ben.


