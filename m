Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932485AbVKUXed@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932485AbVKUXed (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Nov 2005 18:34:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932481AbVKUXed
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Nov 2005 18:34:33 -0500
Received: from 22.107.233.220.exetel.com.au ([220.233.107.22]:28678 "EHLO
	arnor.apana.org.au") by vger.kernel.org with ESMTP id S932484AbVKUXec
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Nov 2005 18:34:32 -0500
Date: Tue, 22 Nov 2005 10:34:17 +1100
To: Alexey Kuznetsov <kuznet@ms2.inr.ac.ru>
Cc: Christopher Friesen <cfriesen@nortel.com>, netdev@vger.kernel.org,
       linux-kernel@vger.kernel.org, davem@davemloft.net
Subject: Re: netlink nlmsg_pid supposed to be pid or tid?
Message-ID: <20051121233417.GA27327@gondor.apana.org.au>
References: <438220C3.4040602@nortel.com> <E1EeIcx-0006i3-00@gondolin.me.apana.org.au> <20051121213549.GA28187@ms2.inr.ac.ru> <4382406D.1040508@nortel.com> <20051121224913.GA31287@ms2.inr.ac.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051121224913.GA31287@ms2.inr.ac.ru>
User-Agent: Mutt/1.5.9i
From: Herbert Xu <herbert@gondor.apana.org.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 22, 2005 at 01:49:13AM +0300, Alexey Kuznetsov wrote:
> 
> Actually, I remember one discussion. Herbert, wait a minute...
> That's it: February 2005, Subject: [PATCH] Add audit uid to netlink credentials
> We decided (or not?) that binding to anything but tgid and pid
> must be prohibited by security reasons. Apaprently, the finding was lost.

Thanks for reminding me.  We may still need to track that down (we
have now serialised most of the netlink processing so this my not be
as bad as it was).

However, I think explicit binding should still be allowed for root,
so nobody should take the PID for granted.

Cheers,
-- 
Visit Openswan at http://www.openswan.org/
Email: Herbert Xu ~{PmV>HI~} <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
