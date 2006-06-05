Return-Path: <linux-kernel-owner+akpm=40zip.com.au-S1751189AbWFEPkc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751189AbWFEPkc (ORCPT <rfc822;akpm@zip.com.au>);
	Mon, 5 Jun 2006 11:40:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751192AbWFEPkc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 Jun 2006 11:40:32 -0400
Received: from [198.99.130.12] ([198.99.130.12]:2238 "EHLO
	saraswathi.solana.com") by vger.kernel.org with ESMTP
	id S1751189AbWFEPkc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 Jun 2006 11:40:32 -0400
Date: Mon, 5 Jun 2006 11:40:17 -0400
From: Jeff Dike <jdike@addtoit.com>
To: Blaisorblade <blaisorblade@yahoo.it>
Cc: user-mode-linux-devel@lists.sourceforge.net, akpm@osdl.org,
        linux-kernel@vger.kernel.org
Subject: Re: [uml-devel] Re: [PATCH 2/8] UML - Define jmpbuf access constants
Message-ID: <20060605154017.GA24405@ccure.user-mode-linux.org>
References: <200602070223.k172NpJa009654@ccure.user-mode-linux.org> <a36005b50602071123r8179c7di8e95bf0a336f1b0c@mail.gmail.com> <20060208164301.GC5240@ccure.user-mode-linux.org> <200606042020.00120.blaisorblade@yahoo.it>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200606042020.00120.blaisorblade@yahoo.it>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jun 04, 2006 at 08:19:59PM +0200, Blaisorblade wrote:
> What about #ifdef'ing out the offending code #ifndef one of these constants 
> (they'll be defined or not altogether). As expectable, this wasn't yet 
> implemented - let's give the right priority to things.
> (I've just met this on my SuSE, btw, which prompted me to write this email).

I think hpa just came to our rescue.  There's a setjmp/longjmp
implementation in klibc.  If we pull that in and use it, we don't need
our own copy.

				Jeff
