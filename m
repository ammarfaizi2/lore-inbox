Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268735AbUJEC1R@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268735AbUJEC1R (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 4 Oct 2004 22:27:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268739AbUJEC1R
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 4 Oct 2004 22:27:17 -0400
Received: from omx2-ext.sgi.com ([192.48.171.19]:48077 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S268735AbUJEC1Q (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 4 Oct 2004 22:27:16 -0400
From: Jesse Barnes <jbarnes@sgi.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH] I/O space write barrier
Date: Mon, 4 Oct 2004 19:26:56 -0700
User-Agent: KMail/1.7
Cc: Albert Cahalan <albert@users.sourceforge.net>,
       linux-kernel mailing list <linux-kernel@vger.kernel.org>
References: <1096922369.2666.177.camel@cube> <1096936344.2674.198.camel@cube> <1096939347.24537.2.camel@gaston>
In-Reply-To: <1096939347.24537.2.camel@gaston>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200410041926.57205.jbarnes@sgi.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday, October 04, 2004 6:22 pm, Benjamin Herrenschmidt wrote:
> On Tue, 2004-10-05 at 10:32, Albert Cahalan wrote:
> > Ideally, it would be eieio, and the eieio in each
> > of the IO operations would be removed. Finding and
> > fixing all the drivers that break looks impossible
> > though; most driver developers will be on x86 boxes.
>
> I don't agree. IO operations shouldn't be relaxed by
> default. That's really asking too much of driver writers

I agree, it's hard to get right, especially when you've got a large base of 
drivers with hard to find assumptions about ordering.

What about mmiowb()?  Should it be eieio?  I don't want to post another patch 
if I don't have to...

Thanks,
Jesse
