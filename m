Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268177AbUIKPop@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268177AbUIKPop (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 11 Sep 2004 11:44:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268169AbUIKPop
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 11 Sep 2004 11:44:45 -0400
Received: from smtp005.mail.ukl.yahoo.com ([217.12.11.36]:23469 "HELO
	smtp005.mail.ukl.yahoo.com") by vger.kernel.org with SMTP
	id S268184AbUIKPnc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 11 Sep 2004 11:43:32 -0400
From: BlaisorBlade <blaisorblade_spam@yahoo.it>
To: Jeff Dike <jdike@addtoit.com>, linux-kernel@vger.kernel.org
Subject: Re: [patch 1/1] uml-update-2.6.8-finish
Date: Sat, 11 Sep 2004 17:40:12 +0200
User-Agent: KMail/1.6.1
Cc: Andrew Morton <akpm@osdl.org>
References: <20040908173855.68F518D0B@zion.localdomain> <200409102028.54580.blaisorblade_personal@yahoo.it> <200409102103.i8AL3b0O004288@ccure.user-mode-linux.org>
In-Reply-To: <200409102103.i8AL3b0O004288@ccure.user-mode-linux.org>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200409111740.12121.blaisorblade_spam@yahoo.it>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 10 September 2004 23:03, Jeff Dike wrote:
> blaisorblade_personal@yahoo.it said:
> > About the one from Jeff Dike, it's dangerous because I don't know
> > whether or  not we would see any introduced bug.

> The ghash removal?  That's necessary, for one, and that code isn't
> currently used anyway, so any bugs that I introduced can be sorted out
> later.  For now, it's sufficient that it compiles.
And making it compile with the hash code, rather than the rb_tree one? I know 
ghash.h must be removed, but there is no reason at all to switch to Red-Black 
trees. Even because, later, we will just see "Hey, I get a panic here" + 
backtrace. Doing things right in first place is better.

Andrew, what's your opinion about this? Do you prefer staying with the same 
code (but without having a ghash.h) or using the new one?

My idea is to move the needed #defines (not everything) inside physmem.c for 
now, so that ghash.h does not appear in 2.6.9; then, after fixing the 
breakage for mainline, we can look at the code to see if it needs any change; 
however that should be tested for a while (probably in Jeff Dike's tree, 
which is going to become for experimental stuff, now that UML gets merged in 
mainline).

Bye
-- 
Paolo Giarrusso, aka Blaisorblade
Linux registered user n. 292729
