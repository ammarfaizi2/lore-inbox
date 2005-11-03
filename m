Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751168AbVKCGyN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751168AbVKCGyN (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Nov 2005 01:54:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751267AbVKCGyN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Nov 2005 01:54:13 -0500
Received: from mail.ispwest.com ([216.52.245.18]:45584 "EHLO
	ispwest-email1.mdeinc.com") by vger.kernel.org with ESMTP
	id S1751168AbVKCGyL convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Nov 2005 01:54:11 -0500
X-Modus-BlackList: 216.52.245.25=OK;kjak@ispwest.com=OK
X-Modus-Trusted: 216.52.245.25=YES
Message-ID: <b70651b792f248ac8a5ca985a83e875f.kjak@ispwest.com>
X-EM-APIVersion: 2, 0, 1, 0
X-Priority: 3 (Normal)
Reply-To: "Kris Katterjohn" <kjak@users.sourceforge.net>
From: "Kris Katterjohn" <kjak@ispwest.com>
To: "Mitchell Blank Jr" <mitch@sfgoth.com>
CC: "Herbert Xu" <herbert@gondor.apana.org.au>, jschlst@samba.org,
       davem@davemloft.net, acme@ghostprotocols.net, netdev@vger.kernel.org,
       linux-kernel@vger.kernel.org
Subject: Re: Re: [PATCH] Merge __load_pointer() and load_pointer() in net/core/filter.c; kernel 2.6.14
Date: Wed, 2 Nov 2005 22:54:07 -0800
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > > From: Mitchell Blank Jr
> > > > (I trimmed the cc: list a bit; no need for this to be on LKML in my opinion)
> 
> I see you just added it back.  Oh well.

When I emailed (CC:) Herbert Xu (who emailed about this earlier), I got an email
back that said it couldn't send to him. So, I just added linux-kernel back so
he'd see it if he's interested at all.

> > > So I guess use my patch and take "inline" off? What do you think?
> 
> Well the original author presumably thought that the fast-path of
> load_pointer() was critical enough to keep inline (since it can be run many
> times per packet)  So they made the deliberate choice of separating it
> into two functions - one inline, one non-inline.
> 
> So my personal feeling is that the code is probably fine as it stands today.

It probably is. Doesn't really matter I guess.
 
> > Maybe "static" should be removed, too? Oh well.
> 
> Uh, why?  It's clearly a file-local function.

No real reason, just that none of the other functions in filter.c are static.


Thanks


