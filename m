Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263101AbUFBPFQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263101AbUFBPFQ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Jun 2004 11:05:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263124AbUFBPFQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Jun 2004 11:05:16 -0400
Received: from mail.fh-wedel.de ([213.39.232.194]:61835 "EHLO mail.fh-wedel.de")
	by vger.kernel.org with ESMTP id S263101AbUFBPFK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Jun 2004 11:05:10 -0400
Date: Wed, 2 Jun 2004 17:04:40 +0200
From: =?iso-8859-1?Q?J=F6rn?= Engel <joern@wohnheim.fh-wedel.de>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Horst von Brand <vonbrand@inf.utfsm.cl>, Pavel Machek <pavel@suse.cz>,
       Andrew Morton <akpm@osdl.org>, Arjan van de Ven <arjanv@redhat.com>,
       Ingo Molnar <mingo@elte.hu>, Andrea Arcangeli <andrea@suse.de>,
       Rik van Riel <riel@redhat.com>, linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH] explicitly mark recursion count
Message-ID: <20040602150440.GA26474@wohnheim.fh-wedel.de>
References: <200406011929.i51JTjGO006174@eeyore.valparaiso.cl> <Pine.LNX.4.58.0406011255070.14095@ppc970.osdl.org> <20040602131623.GA23017@wohnheim.fh-wedel.de> <Pine.LNX.4.58.0406020712180.3403@ppc970.osdl.org> <20040602142748.GA25939@wohnheim.fh-wedel.de> <Pine.LNX.4.58.0406020743260.3403@ppc970.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Pine.LNX.4.58.0406020743260.3403@ppc970.osdl.org>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2 June 2004 07:45:10 -0700, Linus Torvalds wrote:
> 
> The programmer had _better_ know that there is some upper limit.
> 
> And I claim: recursion is illegal unless the programmer has some explicit 
> recursion limiter. And if he has that recursion limiter in one of the 
> functions, then he damn well better know it, and know the value it limits 
> recursion to.

Can I read this as:
Linus himself will use strong words to enforce all recursions in the
kernel to be either removed or properly documented.

In that case, you have 273 recursions to deal with.  They are all in
the data I attached a few posts back.  Recursions would basically be
in the same league as huge stack hogs, sounds good.

Jörn

-- 
Write programs that do one thing and do it well. Write programs to work
together. Write programs to handle text streams, because that is a
universal interface. 
-- Doug MacIlroy
