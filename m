Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932242AbVHVW5n@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932242AbVHVW5n (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 22 Aug 2005 18:57:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932252AbVHVW5l
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 22 Aug 2005 18:57:41 -0400
Received: from zeus1.kernel.org ([204.152.191.4]:28814 "EHLO zeus1.kernel.org")
	by vger.kernel.org with ESMTP id S932247AbVHVW53 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 22 Aug 2005 18:57:29 -0400
From: Herbert Xu <herbert@gondor.apana.org.au>
To: gopal@rgopal.com (Gopalakrishnan Raman)
Subject: Re: tcpdump confused with NAT-T+IPSec Packets
Cc: linux-kernel@vger.kernel.org, gopal@rgopal.com
Organization: Core
In-Reply-To: <20050821165608.A9993@portal.rgopal.com>
X-Newsgroups: apana.lists.os.linux.kernel
User-Agent: tin/1.7.4-20040225 ("Benbecula") (UNIX) (Linux/2.4.27-hx-1-686-smp (i686))
Message-Id: <E1E72tP-0007Zs-00@gondolin.me.apana.org.au>
Date: Mon, 22 Aug 2005 13:22:35 +1000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Gopalakrishnan Raman <gopal@rgopal.com> wrote:
> The problem is that packet_rcv() calls skb_clone() which is the
> right thing to do in all cases except when the data portion of the
> incoming skb is being modified in place. I replaced it with a pskb_copy()
> in the case when the packet is likely to be NAT-T or ESP. The patch
> for this follows the end of this mail and seems to work quite well.

This bug has already been fixed in 2.6.12.
-- 
Visit Openswan at http://www.openswan.org/
Email: Herbert Xu ~{PmV>HI~} <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
