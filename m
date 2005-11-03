Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030286AbVKCCtD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030286AbVKCCtD (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Nov 2005 21:49:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030285AbVKCCtD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Nov 2005 21:49:03 -0500
Received: from pop.ispwest.com ([216.52.245.18]:36108 "EHLO
	ispwest-email1.mdeinc.com") by vger.kernel.org with ESMTP
	id S1030274AbVKCCtC convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Nov 2005 21:49:02 -0500
X-Modus-BlackList: 216.52.245.25=OK;kjak@ispwest.com=OK
X-Modus-Trusted: 216.52.245.25=YES
Message-ID: <3dd4936961ae4324937d19838bad898b.kjak@ispwest.com>
X-EM-APIVersion: 2, 0, 1, 0
X-Priority: 3 (Normal)
Reply-To: "Kris Katterjohn" <kjak@users.sourceforge.net>
From: "Kris Katterjohn" <kjak@ispwest.com>
To: "Herbert Xu" <herbert@gondor.apana.org.au>
CC: jschlst@samba.org, torvalds@osdl.org, linux-kernel@vger.kernel.org,
       davem@davemloft.net, acme@ghostprotocols.net, netdev@vger.kernel.org
Subject: Re: [PATCH] Merge __load_pointer() and load_pointer() in net/core/filter.c; kernel 2.6.14
Date: Wed, 2 Nov 2005 18:48:59 -0800
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Forgive me because this is one of my first attempts at anything related to the
kernel, but...

1) How would I go about benchmarking this?
2) If the out-of-line code is executed anyway (since load_pointer() calls __load_pointer()),
would it really effect it very much?

I've been programming as a hobby for a few years, but I never really worried
about inlining my code. Most likely because when I was learning C, I was using
books etc. that were written before C99 was out.

Thanks


----- Original Message -----
From: Herbert Xu [mailto:herbert@gondor.apana.org.au]
Subject: Re: [PATCH] Merge __load_pointer() and load_pointer() in net/core/filter.c; kernel 2.6.14
> Kris Katterjohn <kjak@ispwest.com> wrote:
> > I wasn't actually changing it to add performance, but to make the code look
> > cleaner. The new load_pointer() is virtually the same as having the seperate
> > functions that are currently there, but the code, I think, is "better looking".
> > If you look at the current net/core/filter.c and then my patched version, the
> > steps are done in the exact same order and same way, but all in that one
> > function.
> 
> You've just changed an out-of-line function (__load_pointer) into an
> inlined function.  There may be a cost to that.
> -- 
> Visit Openswan at http://www.openswan.org/
> Email: Herbert Xu ~{PmV>HI~} <herbert@gondor.apana.org.au>
> Home Page: http://gondor.apana.org.au/~herbert/
> PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt

