Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261862AbULOEVG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261862AbULOEVG (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Dec 2004 23:21:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261865AbULOEVG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Dec 2004 23:21:06 -0500
Received: from ozlabs.org ([203.10.76.45]:5310 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S261862AbULOEVC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Dec 2004 23:21:02 -0500
Subject: Re: [netfilter-core] [PATCH] no __initdata in netfilter?
From: Rusty Russell <rusty@rustcorp.com.au>
To: Andries Brouwer <Andries.Brouwer@cwi.nl>
Cc: Harald Welte <laforge@netfilter.org>, Andries Brouwer <aebr@win.tue.nl>,
       Patrick McHardy <kaber@trash.net>, Andrew Morton <akpm@osdl.org>,
       Linus Torvalds <torvalds@osdl.org>,
       Netfilter Core Team <coreteam@netfilter.org>,
       lkml - Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <20041214183911.GA15606@apps.cwi.nl>
References: <20041114013724.GA21219@apps.cwi.nl>
	 <41970FAD.6010501@trash.net> <20041114112610.GB8680@pclin040.win.tue.nl>
	 <20041214130041.GU22577@sunbeam.de.gnumonks.org>
	 <20041214183911.GA15606@apps.cwi.nl>
Content-Type: text/plain
Date: Wed, 15 Dec 2004 15:21:04 +1100
Message-Id: <1103084464.4696.6.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.2 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2004-12-14 at 19:39 +0100, Andries Brouwer wrote:
> I think that argument is valid only when satisfying the static tool
> is especially cumbersome or inefficient, requires ugly code, etc.
> In most cases a trivial rewrite will suffice, and the result is cleaner
> code, easier to maintain, fewer bugs.

Exactly, and Harald just handed you that trivial rewrite.  It's clearer
than before, and shouldn't trip your static checker.

Your patch just ripped out the __initdata, making it suboptimal
*without* making the code clearer.

Rusty.
-- 
A bad analogy is like a leaky screwdriver -- Richard Braakman

