Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267898AbUGaCHI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267898AbUGaCHI (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 30 Jul 2004 22:07:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267897AbUGaCHH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 30 Jul 2004 22:07:07 -0400
Received: from waste.org ([209.173.204.2]:31622 "EHLO waste.org")
	by vger.kernel.org with ESMTP id S267898AbUGaCFi (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 30 Jul 2004 22:05:38 -0400
Date: Fri, 30 Jul 2004 21:05:34 -0500
From: Matt Mackall <mpm@selenic.com>
To: David Wagner <daw@cs.berkeley.edu>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Delete cryptoloop
Message-ID: <20040731020534.GX5414@waste.org>
References: <1091193219.11944.17.camel@leto.cs.pocnet.net> <200407310044.i6V0iOZe032440@taverner.CS.Berkeley.EDU>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200407310044.i6V0iOZe032440@taverner.CS.Berkeley.EDU>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 30, 2004 at 05:44:24PM -0700, David Wagner wrote:
> > But we identified more problems (I don't if these are all real issues).
> > Assuming the attacker has access to both plaintext and the encrypted
> > disk. (shared storage, user account on the machine or something)
> [...]
> 
> Yes, there are a host of potential attacks in this scenario.  That's why I
> wrote that, if you find yourself in this threat model, it would be prudent
> to assume that the current disk encryption scheme can potentially be
> defeated.  Does anyone care about these threat models?  From the design,
> I had assumed that no one cared, but if they are relevant in practice,
> then it might make sense to investigate additional defenses.

Here's a probable scenario: encrypted mail spool in maildir format.
Attacker can send mail of his choosing and then later capture the
machine with the hope of breaking in.

Ideally, we'd ship a requirements and specification document that
describes the security trade-offs of cryptoloop/dm-crypt in some
detail. There are way too many unstated assumptions here.

-- 
Mathematics is the supreme nostalgia of our time.
