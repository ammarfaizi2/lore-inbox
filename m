Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263367AbUJ2PiP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263367AbUJ2PiP (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 29 Oct 2004 11:38:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263386AbUJ2PgN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 29 Oct 2004 11:36:13 -0400
Received: from colin2.muc.de ([193.149.48.15]:24580 "HELO colin2.muc.de")
	by vger.kernel.org with SMTP id S263373AbUJ2PLl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 29 Oct 2004 11:11:41 -0400
Date: 29 Oct 2004 17:11:39 +0200
Date: Fri, 29 Oct 2004 17:11:39 +0200
From: Andi Kleen <ak@muc.de>
To: Linus Torvalds <torvalds@osdl.org>
Cc: linux-os@analogic.com, Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Richard Henderson <rth@redhat.com>, Andrew Morton <akpm@osdl.org>,
       Jan Hubicka <jh@suse.cz>
Subject: Re: Semaphore assembly-code bug
Message-ID: <20041029151139.GA73646@muc.de>
References: <Pine.LNX.4.58.0410181540080.2287@ppc970.osdl.org> <417550FB.8020404@drdos.com> <1098218286.8675.82.camel@mentorng.gurulabs.com> <41757478.4090402@drdos.com> <20041020034524.GD10638@michonline.com> <1098245904.23628.84.camel@krustophenia.net> <1098247307.23628.91.camel@krustophenia.net> <Pine.LNX.4.61.0410200744310.10521@chaos.analogic.com> <Pine.LNX.4.61.0410290805570.11823@chaos.analogic.com> <Pine.LNX.4.58.0410290740120.28839@ppc970.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0410290740120.28839@ppc970.osdl.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Btw, this is another case where we _really_ want "asmlinkage" to mean that
> the compiler does not own the argument stack. Is there any chance of
> getting a function attribute like that into future versions of gcc?  
> Richard, Jan, Andi? Or does it already exist somewhere?

How about just using __attribute__((regparm(1)))  ?  Then the
problem doesn't appear. 
Would be faster too. It should work reliable on all supported compilers.

-Andi

