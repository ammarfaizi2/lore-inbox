Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261456AbSLMGVF>; Fri, 13 Dec 2002 01:21:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261492AbSLMGVF>; Fri, 13 Dec 2002 01:21:05 -0500
Received: from e5.ny.us.ibm.com ([32.97.182.105]:57997 "EHLO e5.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id <S261456AbSLMGVE>;
	Fri, 13 Dec 2002 01:21:04 -0500
Message-ID: <3DF97DAF.C4C49013@us.ibm.com>
Date: Thu, 12 Dec 2002 22:26:55 -0800
From: Nivedita Singhvi <niv@us.ibm.com>
X-Mailer: Mozilla 4.78 [en] (Win98; U)
X-Accept-Language: en
MIME-Version: 1.0
To: Matti Aarnio <matti.aarnio@zmailer.org>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Andreani Stefano <stefano.andreani.ap@h3g.it>,
       "David S. Miller" <davem@redhat.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       linux-net@vger.kernel.org
Subject: Re: R: Kernel bug handling TCP_RTO_MAX?
References: <047ACC5B9A00D741927A4A32E7D01B73D66178@RMEXC01.h3g.it> <1039727809.22174.38.camel@irongate.swansea.linux.org.uk> <3DF94565.2C582DE2@us.ibm.com> <20021213033928.GK32122@mea-ext.zmailer.org> <3DF965E4.95DEA1F9@us.ibm.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Nivedita Singhvi wrote:

> our default init rto is 300, so currently we're going to timeout
> on anything thats a 100ms over the min of 200. that is far
> less conservative than setting an rto of 200 when your round
> trip time is a thousand or 10,000 times less..does that make sense?

Doh! init rto is NOT 300ms, its 3 seconds. That minor blooper
shreds my comparison argument a tad :)..but Dave's point renders
that moot, in any case..

"David S. Miller" wrote:

> Actually, TCP_RTO_MIN cannot be made any smaller without
> some serious thought.
> 
> The reason it is 200ms is due to the granularity of the BSD
> TCP socket timers.
> 
> In short, the repercussions are not exactly well known, so it's
> a research problem to fiddle here.

Ack.

Sometime in the not too distant future, the next generation of 
infrastructure will require this to be reworked  :).

thanks,
Nivedita
