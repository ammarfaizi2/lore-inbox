Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262308AbVCPJpO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262308AbVCPJpO (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Mar 2005 04:45:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262307AbVCPJpO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Mar 2005 04:45:14 -0500
Received: from arnor.apana.org.au ([203.14.152.115]:52234 "EHLO
	arnor.apana.org.au") by vger.kernel.org with ESMTP id S262308AbVCPJom
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Mar 2005 04:44:42 -0500
Date: Wed, 16 Mar 2005 20:44:06 +1100
To: "David S. Miller" <davem@davemloft.net>
Cc: Peter Chubb <peterc@gelato.unsw.edu.au>, linux-kernel@vger.kernel.org
Subject: Re: Can no longer build ipv6 built-in (2.6.11, today's BK head)
Message-ID: <20050316094406.GA4784@gondor.apana.org.au>
References: <200503160353.j2G3rTKr015647@mail02.syd.optusnet.com.au> <20050315200651.6c0eb372.davem@davemloft.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050315200651.6c0eb372.davem@davemloft.net>
User-Agent: Mutt/1.5.6+20040907i
From: Herbert Xu <herbert@gondor.apana.org.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 15, 2005 at 08:06:51PM -0800, David S. Miller wrote:
> On Wed, 16 Mar 2005 14:53:29 +1100
> Peter Chubb <peterc@gelato.unsw.edu.au> wrote:
> 
> > A simple fix is to delete the __exit from the various functions now that
> > they're called other than at module_exit.
> > 
> > Signed-off-by: Peter Chubb <peterc@gelato.unsw.edu.au>
> 
> Applied, thanks Peter.

Thanks guys.

Calling an __exit function from an __init function is actually fairly
common.  I wonder if it would be useful to have an __initexit marker
that gets dropped when both __init and __exit would be dropped.
-- 
Visit Openswan at http://www.openswan.org/
Email: Herbert Xu ~{PmV>HI~} <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
