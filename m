Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263167AbUFBP2M@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263167AbUFBP2M (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Jun 2004 11:28:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263173AbUFBP2M
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Jun 2004 11:28:12 -0400
Received: from mail.fh-wedel.de ([213.39.232.194]:6030 "EHLO mail.fh-wedel.de")
	by vger.kernel.org with ESMTP id S263167AbUFBP2J (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Jun 2004 11:28:09 -0400
Date: Wed, 2 Jun 2004 17:27:42 +0200
From: =?iso-8859-1?Q?J=F6rn?= Engel <joern@wohnheim.fh-wedel.de>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Horst von Brand <vonbrand@inf.utfsm.cl>, Pavel Machek <pavel@suse.cz>,
       Andrew Morton <akpm@osdl.org>, Arjan van de Ven <arjanv@redhat.com>,
       Ingo Molnar <mingo@elte.hu>, Andrea Arcangeli <andrea@suse.de>,
       Rik van Riel <riel@redhat.com>, linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH] explicitly mark recursion count
Message-ID: <20040602152741.GC26474@wohnheim.fh-wedel.de>
References: <200406011929.i51JTjGO006174@eeyore.valparaiso.cl> <Pine.LNX.4.58.0406011255070.14095@ppc970.osdl.org> <20040602131623.GA23017@wohnheim.fh-wedel.de> <Pine.LNX.4.58.0406020712180.3403@ppc970.osdl.org> <20040602142748.GA25939@wohnheim.fh-wedel.de> <Pine.LNX.4.58.0406020743260.3403@ppc970.osdl.org> <20040602150440.GA26474@wohnheim.fh-wedel.de> <Pine.LNX.4.58.0406020807270.3403@ppc970.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Pine.LNX.4.58.0406020807270.3403@ppc970.osdl.org>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2 June 2004 08:12:00 -0700, Linus Torvalds wrote:
> On Wed, 2 Jun 2004, Jörn Engel wrote:
> > 
> > Can I read this as:
> > Linus himself will use strong words to enforce all recursions in the
> > kernel to be either removed or properly documented.
> 
> If we have a good detector that is reliable and easy to run, why not?

Great!  So the official format to document recursions is plain english
for human readers?

> It will take some time, but I think the problem so far has been that the
> recursion can be hard to see. Some "core" cases are well-known (memory
> allocations during memory allocation, and filename lookup), and they 
> should be trivial to annotate. Knock wood. Others might be worse.

For sure.  There are some functions with multiple recursions around
them, real fun! :)

> > In that case, you have 273 recursions to deal with.  They are all in
> > the data I attached a few posts back.  Recursions would basically be
> > in the same league as huge stack hogs, sounds good.
> 
> Yes. And with huge stack hogs, we've not exactly "fixed them all in a 
> weekend", have we? But having a few people run the checking tools and 
> nagging every once in a while ends up eventually fixing things. At least 
> the most common ones.

s/a few people/Jörn/

Legal reasons.  I'll try to do this from time to time.

Jörn

-- 
To recognize individual spam features you have to try to get into the
mind of the spammer, and frankly I want to spend as little time inside
the minds of spammers as possible.
-- Paul Graham
