Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261729AbUK2Pcs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261729AbUK2Pcs (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 29 Nov 2004 10:32:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261730AbUK2Pcs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 29 Nov 2004 10:32:48 -0500
Received: from thunk.org ([69.25.196.29]:20701 "EHLO thunker.thunk.org")
	by vger.kernel.org with ESMTP id S261729AbUK2Pcq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 29 Nov 2004 10:32:46 -0500
Date: Mon, 29 Nov 2004 10:32:31 -0500
From: "Theodore Ts'o" <tytso@mit.edu>
To: Herbert Xu <herbert@gondor.apana.org.au>
Cc: David Wagner <daw-usenet@taverner.cs.berkeley.edu>,
       linux-kernel@vger.kernel.org
Subject: Re: no entropy and no output at /dev/random  (quick question)
Message-ID: <20041129153231.GA6060@thunk.org>
Mail-Followup-To: Theodore Ts'o <tytso@mit.edu>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	David Wagner <daw-usenet@taverner.cs.berkeley.edu>,
	linux-kernel@vger.kernel.org
References: <coak1s$suq$1@abraham.cs.berkeley.edu> <E1CYIZ7-0005D3-00@gondolin.me.apana.org.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <E1CYIZ7-0005D3-00@gondolin.me.apana.org.au>
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Nov 28, 2004 at 05:29:45PM +1100, Herbert Xu wrote:
> David Wagner <daw@taverner.cs.berkeley.edu> wrote:
> > 
> > Yes, for almost all purposes, applications should use /dev/urandom,
> > not /dev/random.  (The names for these devices are unfortunate.)
> > Sadly, many applications fail to follow these rules, and consequently
> > /dev/random's entropy pool often ends up getting depleted much faster
> > than it has to be.
> 
> I agree with your conclusion that applications should use urandom.
> However, IIRC /dev/urandom depletes the entropy pool just as fast
> as /dev/random...

More specifically, most applications should use /dev/urandom to seed a
cryptographic random number generator which operates in userspace.  

						- Ted
