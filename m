Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269536AbUJLJJo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269536AbUJLJJo (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Oct 2004 05:09:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269534AbUJLJJo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Oct 2004 05:09:44 -0400
Received: from dsl-kpogw5jd0.dial.inet.fi ([80.223.105.208]:54760 "EHLO
	safari.iki.fi") by vger.kernel.org with ESMTP id S269536AbUJLJJR
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Oct 2004 05:09:17 -0400
Date: Tue, 12 Oct 2004 12:09:15 +0300
From: Sami Farin <7atbggg02@sneakemail.com>
To: Kernel Mailing List <linux-kernel@vger.kernel.org>
Cc: Linus Torvalds <torvalds@osdl.org>
Subject: [PATCH] tcp_output.c: tcp_set_skb_tso_factor ---> tcp_set_skb_tso_segs [Was: Re: Linux 2.6.9-rc4 - pls test (and no more patches)]
Message-ID: <20041012090915.GA12087@m.safari.iki.fi>
Mail-Followup-To: Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Linus Torvalds <torvalds@osdl.org>
References: <Pine.LNX.4.58.0410102016180.3897@ppc970.osdl.org> <20041012080537.GA6092@merlin.emma.line.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041012080537.GA6092@merlin.emma.line.org>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 12, 2004 at 10:05:37AM +0200, Matthias Andree wrote:
> On Sun, 10 Oct 2004, Linus Torvalds wrote:
> 
> >  trying to make ready for the real 2.6.9 in a week or so, so please give
> > this a beating, and if you have pending patches, please hold on to them
> > for a bit longer, until after the 2.6.9 release. It would be good to have
> > a 2.6.9 that doesn't need a dot-release immediately ;)
> 
> How about Marcelo's policy that the -final version should differ from
> the last -rc only in the Makefile VERSION and nothing else (well,
> documentation perhaps if someone else has proofread it).
> 
> Would you be ready to have the last -rc out for, say, five days, before
> releasing the official, final, blessed, however 2.6.9, in order to catch
> the showstoppers?

Like this one?  2.6.9-rc4 does not build with
gcc-2.95.3 + binutils-2.15.92.0.2.

Signed-Off-By: Sami Farin <7atbggg02@sneakemail.com>

--- linux/net/ipv4/tcp_output.c.bak	2004-10-11 18:24:06.000000000 +0300
+++ linux/net/ipv4/tcp_output.c	2004-10-11 22:12:32.000000000 +0300
@@ -445,7 +445,7 @@ void tcp_set_skb_tso_segs(struct sk_buff
 		skb_shinfo(skb)->tso_size = mss_std;
 	}
 }
-EXPORT_SYMBOL_GPL(tcp_set_skb_tso_factor);
+EXPORT_SYMBOL_GPL(tcp_set_skb_tso_segs);
 
 /* Function to create two new TCP segments.  Shrinks the given segment
  * to the specified size and appends a new segment with the rest of the

-- 
