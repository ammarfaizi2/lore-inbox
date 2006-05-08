Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932263AbWEHDA2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932263AbWEHDA2 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 7 May 2006 23:00:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932265AbWEHDA2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 7 May 2006 23:00:28 -0400
Received: from waste.org ([64.81.244.121]:37054 "EHLO waste.org")
	by vger.kernel.org with ESMTP id S932263AbWEHDA2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 7 May 2006 23:00:28 -0400
Date: Sun, 7 May 2006 21:55:29 -0500
From: Matt Mackall <mpm@selenic.com>
To: Theodore Tso <tytso@mit.edu>, Thiago Galesi <thiagogalesi@gmail.com>,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH 7/14] random: Remove SA_SAMPLE_RANDOM from network drivers
Message-ID: <20060508025529.GQ15445@waste.org>
References: <20060505203436.GW15445@waste.org> <20060506115502.GB18880@thunk.org> <20060506164808.GY15445@waste.org> <20060506.170810.74552888.davem@davemloft.net> <20060507045920.GH15445@waste.org> <82ecf08e0605070613o7b217a2bw4c71c3a8c33bed28@mail.gmail.com> <20060507160013.GM15445@waste.org> <20060508001333.GA17138@thunk.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060508001333.GA17138@thunk.org>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, May 07, 2006 at 08:13:33PM -0400, Theodore Tso wrote:
> But in answer to your question, what should we do, my suggestion would
> be to sample all interrupts, and calculate the estimated entropy
> credits as we to day, but scaled by an amount that can range from 0 to
> 100%.

I actually posted a patch to add a sysctl to do exactly that a few
years ago.

> But for most normal/modern platforms, I would argue the default
> scaling factor should be 100%.

And I would argue it should be no more than 50%. Just because I've
seen so many would-have-thought-they-were-impossible attacks pan out.

-- 
Mathematics is the supreme nostalgia of our time.
