Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267734AbUIUScz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267734AbUIUScz (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Sep 2004 14:32:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267934AbUIUScz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Sep 2004 14:32:55 -0400
Received: from mail.enyo.de ([212.9.189.167]:19470 "EHLO mail.enyo.de")
	by vger.kernel.org with ESMTP id S267734AbUIUScy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Sep 2004 14:32:54 -0400
To: Herbert Xu <herbert@gondor.apana.org.au>
Cc: paul@clubi.ie, alan@lxorguk.ukuu.org.uk, vph@iki.fi,
       toon@hout.vanvergehaald.nl, admin@wolfpaw.net,
       kaukasoi@elektroni.ee.tut.fi, linux-kernel@vger.kernel.org
Subject: Re: Linux 2.4.27 SECURITY BUG - TCP Local and REMOTE(verified) Denial of Service Attack
References: <E1C9aB6-0007Gk-00@gondolin.me.apana.org.au>
From: Florian Weimer <fw@deneb.enyo.de>
Date: Tue, 21 Sep 2004 20:32:12 +0200
In-Reply-To: <E1C9aB6-0007Gk-00@gondolin.me.apana.org.au> (Herbert Xu's
	message of "Tue, 21 Sep 2004 12:14:48 +1000")
Message-ID: <873c1bjwwj.fsf@deneb.enyo.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Herbert Xu:

> Florian Weimer <fw@deneb.enyo.de> wrote:
>> 
>>>> TCP-MD5 has no effect on ICMP based attacks.,
>>>
>>> Hmm, good point. Which attacks, and what could be done about them? 
>>> (other than IPsec protect all traffic between peers).
>> 
>> You just filter ICMP packets, in the way RST packets are already
>> filtered (i.e. rate limit).
>
> Rate-limiting has no effect on ICMP attacks unless your limit is such
> that you're effectively dropping them all.

Yes, that's the idea.  Keep in mind that all this is about traffic
destined to a router interface address, not about forwarded traffic.

> But then you get PMTU problems...

PMTU discovery is not an issue because it's turned off anyway, at
least by default.
