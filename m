Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267587AbTGWKpx (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Jul 2003 06:45:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268047AbTGWKpx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Jul 2003 06:45:53 -0400
Received: from arnor.apana.org.au ([203.14.152.115]:57608 "EHLO
	arnor.me.apana.org.au") by vger.kernel.org with ESMTP
	id S267587AbTGWKpw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Jul 2003 06:45:52 -0400
Date: Wed, 23 Jul 2003 20:59:03 +1000
To: "David S. Miller" <davem@redhat.com>
Cc: a.marsman@aYniK.com, alan@lxorguk.ukuu.org.uk,
       linux-kernel@vger.kernel.org
Subject: Re: 2.4.22-pre7: are security issues solved?
Message-ID: <20030723105903.GA2582@gondor.apana.org.au>
References: <Pine.LNX.4.44.0307212234390.3580-100000@localhost.localdomain> <E19fGMZ-0000Zm-00@gondolin.me.apana.org.au> <20030723033505.145db6b8.davem@redhat.com> <20030723104753.GA2479@gondor.apana.org.au> <20030723035022.23a75bc5.davem@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030723035022.23a75bc5.davem@redhat.com>
User-Agent: Mutt/1.5.4i
From: Herbert Xu <herbert@gondor.apana.org.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 23, 2003 at 03:50:22AM -0700, David S. Miller wrote:
>
> > It's much smaller if you didn't know that it was at most 7 characters
> > long.  However, if you did know the upper bound, or you were just
> > brute forcing all passwords starting from 1 character, then the
> > difference is relatively minor.  This is because
> > 
> > n + n^2 + n^3 + n^4 + n^5 + n^6
> > 
> > is much smaller than n^7 where n is something like 62 for a reasonable
> > password.
> 
> "7" in my example is an arbitrary number, increase it to any larger
> number you like.

Well, as m gets larger, the number

(n + n^2 + ... + n^(m-1)) / n^m

tends to 1 / (n - 1).

In other words, if you can break n^m, then you can probably break

n + n^2 + ... + n^m

Anyway, I'm not that bothered with making /proc/tty/driver root-only,
even if it is only for what seems to me to be dubious reasons.
-- 
Debian GNU/Linux 3.0 is out! ( http://www.debian.org/ )
Email:  Herbert Xu ~{PmV>HI~} <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
