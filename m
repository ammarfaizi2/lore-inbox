Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267474AbUIUC0v@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267474AbUIUC0v (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Sep 2004 22:26:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267475AbUIUC0v
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Sep 2004 22:26:51 -0400
Received: from c211-30-229-77.rivrw4.nsw.optusnet.com.au ([211.30.229.77]:53005
	"EHLO arnor.apana.org.au") by vger.kernel.org with ESMTP
	id S267474AbUIUC0o (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Sep 2004 22:26:44 -0400
From: Herbert Xu <herbert@gondor.apana.org.au>
To: fw@deneb.enyo.de (Florian Weimer)
Subject: Re: Linux 2.4.27 SECURITY BUG - TCP Local and REMOTE(verified) Denial of Service Attack
Cc: paul@clubi.ie, alan@lxorguk.ukuu.org.uk, vph@iki.fi,
       toon@hout.vanvergehaald.nl, admin@wolfpaw.net,
       kaukasoi@elektroni.ee.tut.fi, linux-kernel@vger.kernel.org
Organization: Core
In-Reply-To: <87zn3kmwe1.fsf@deneb.enyo.de>
X-Newsgroups: apana.lists.os.linux.kernel
User-Agent: tin/1.7.4-20040225 ("Benbecula") (UNIX) (Linux/2.4.27-hx-1-686-smp (i686))
Message-Id: <E1C9aB6-0007Gk-00@gondolin.me.apana.org.au>
Date: Tue, 21 Sep 2004 12:14:48 +1000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Florian Weimer <fw@deneb.enyo.de> wrote:
> 
>>> TCP-MD5 has no effect on ICMP based attacks.,
>>
>> Hmm, good point. Which attacks, and what could be done about them? 
>> (other than IPsec protect all traffic between peers).
> 
> You just filter ICMP packets, in the way RST packets are already
> filtered (i.e. rate limit).

Rate-limiting has no effect on ICMP attacks unless your limit is such
that you're effectively dropping them all.  But then you get PMTU
problems...
-- 
Visit Openswan at http://www.openswan.org/
Email: Herbert Xu ~{PmV>HI~} <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
