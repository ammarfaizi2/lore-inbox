Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265060AbUGSOPk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265060AbUGSOPk (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 19 Jul 2004 10:15:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265264AbUGSOPk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 19 Jul 2004 10:15:40 -0400
Received: from host-65-117-135-105.timesys.com ([65.117.135.105]:2288 "EHLO
	kartuli.timesys") by vger.kernel.org with ESMTP id S265060AbUGSOPi
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 19 Jul 2004 10:15:38 -0400
Message-ID: <40FBD734.5040306@timesys.com>
Date: Mon, 19 Jul 2004 10:14:12 -0400
From: "La Monte H.P. Yarroll" <piggy@timesys.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040113
X-Accept-Language: en-us, en, de-de
MIME-Version: 1.0
To: Sridhar Samudrala <sri@us.ibm.com>
CC: Carl Spalletta <cspalletta@yahoo.com>, lkml <linux-kernel@vger.kernel.org>,
       netdev@oss.sgi.com, ML lksctp <lksctp-developers@lists.sourceforge.net>
Subject: Re: [PATCH] Remove prototypes of nonexistent functions from net/sctp
 files
References: <20040718194826.6164.qmail@web53805.mail.yahoo.com>
In-Reply-To: <20040718194826.6164.qmail@web53805.mail.yahoo.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This function went away in Februrary (change 1.67 on associola.c) due to
changing the assoc id from a kernel address to an abstract address. The
check is now done by looking at a single field in the association struct.

Signed-off-by: La Monte H.P. Yarroll <piggy@baqaqi.chi.il.us>

Carl Spalletta wrote:

>diff -ru linux-2.6.7-orig/net/sctp/socket.c linux-2.6.7-new/net/sctp/socket.c
>--- linux-2.6.7-orig/net/sctp/socket.c  2004-06-15 22:20:26.000000000 -0700
>+++ linux-2.6.7-new/net/sctp/socket.c   2004-07-18 08:54:08.000000000 -0700
>@@ -109,7 +109,6 @@
> static char *sctp_hmac_alg = SCTP_COOKIE_HMAC_ALG;
>
> extern kmem_cache_t *sctp_bucket_cachep;
>-extern int sctp_assoc_valid(struct sock *sk, struct sctp_association *asoc);
>
> /* Look up the association by its id.  If this is not a UDP-style
>  * socket, the ID field is always ignored.
>
>-
>To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
>the body of a message to majordomo@vger.kernel.org
>More majordomo info at  http://vger.kernel.org/majordomo-info.html
>Please read the FAQ at  http://www.tux.org/lkml/
>
>  
>

-- 
  Anyone who quotes me in their sig is an idiot. -- Rusty Russell's sig

