Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262124AbVF0XZG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262124AbVF0XZG (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Jun 2005 19:25:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262137AbVF0XUw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Jun 2005 19:20:52 -0400
Received: from serv01.siteground.net ([70.85.91.68]:700 "EHLO
	serv01.siteground.net") by vger.kernel.org with ESMTP
	id S262124AbVF0XSc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Jun 2005 19:18:32 -0400
Date: Mon, 27 Jun 2005 16:17:41 -0700 (PDT)
From: christoph <christoph@scalex86.org>
X-X-Sender: christoph@ScMPusgw
To: Anton Blanchard <anton@samba.org>
cc: Andi Kleen <ak@suse.de>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org, shai@scalex86.org
Subject: Re: [PATCH] Move some variables into the "most_readonly" section??
In-Reply-To: <20050617135536.GB6434@krispykreme>
Message-ID: <Pine.LNX.4.62.0506271611500.10036@ScMPusgw>
References: <Pine.LNX.4.62.0506071253020.2850@ScMPusgw> <20050608131839.GP23831@wotan.suse.de>
 <Pine.LNX.4.62.0506141551350.3676@ScMPusgw> <20050614162354.6aabe57e.akpm@osdl.org>
 <Pine.LNX.4.62.0506141644160.4099@ScMPusgw> <20050614165818.6f83fa6c.akpm@osdl.org>
 <Pine.LNX.4.62.0506141704150.4225@ScMPusgw> <20050614171602.12bfa245.akpm@osdl.org>
 <20050615004153.GX11898@wotan.suse.de> <20050617135536.GB6434@krispykreme>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - serv01.siteground.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [0 0] / [47 12]
X-AntiAbuse: Sender Address Domain - scalex86.org
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 17 Jun 2005, Anton Blanchard wrote:

> > I think it would be better to first still see numbers for
> > this questionable optimizations.
> 
> Agreed, it would be nice to see some benchmark numbers.

Sorry seem to have lost track of this thread of thought.

These are optimizations that try to avoid false aliasing as
a result of the linker placing hot spots into the same cacheline. These
are not predictable per se. Some future patch may rearrange variables that 
then produce another case of false aliasing.

In order to demonstrate the effect, I would need to be allowed to put 
some hot variables into the same cacheline. And that seem to be pointless 
because we all know the outcome.
