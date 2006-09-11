Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751456AbWIKNTj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751456AbWIKNTj (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 11 Sep 2006 09:19:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751477AbWIKNTj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Sep 2006 09:19:39 -0400
Received: from jaguar.mkp.net ([192.139.46.146]:23493 "EHLO jaguar.mkp.net")
	by vger.kernel.org with ESMTP id S1751456AbWIKNTi (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Sep 2006 09:19:38 -0400
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Jesse Barnes <jbarnes@virtuousgeek.org>,
       David Miller <davem@davemloft.net>, jeff@garzik.org, paulus@samba.org,
       torvalds@osdl.org, linux-kernel@vger.kernel.org, akpm@osdl.org,
       segher@kernel.crashing.org, jeremy@sgi.com
Subject: Re: Opinion on ordering of writel vs. stores to RAM
References: <17666.11971.416250.857749@cargo.ozlabs.ibm.com>
	<45028F87.7040603@garzik.org>
	<20060909.030854.78720744.davem@davemloft.net>
	<200609101018.06930.jbarnes@virtuousgeek.org>
	<1157916919.23085.24.camel@localhost.localdomain>
	<1157923513.31071.256.camel@localhost.localdomain>
	<1157926993.23085.29.camel@localhost.localdomain>
	<1157926708.31071.259.camel@localhost.localdomain>
From: Jes Sorensen <jes@sgi.com>
Date: 11 Sep 2006 09:19:36 -0400
In-Reply-To: <1157926708.31071.259.camel@localhost.localdomain>
Message-ID: <yq0venufslz.fsf@jaguar.mkp.net>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> "Ben" == Benjamin Herrenschmidt <benh@kernel.crashing.org> writes:

Ben> On Sun, 2006-09-10 at 23:23 +0100, Alan Cox wrote:
>> Ar Llu, 2006-09-11 am 07:25 +1000, ysgrifennodd Benjamin
>> Herrenschmidt: > I'm copying that from a private discussion I
>> had. Please let me know if > you have comments. This proposal
>> includes some questions too so please > answer :)
>> 
>> Looks sane and Linus seems to like mmiowb. Only other question:
>> what are the guarantees of memcpy_to/fromio. Does it access the
>> memory in ordered fashion or not, does it guarantee only ordering
>> at the end of the copy or during it ?

Ben> Well, Linus is also ok with writel not ordering memory an IO
Ben> accesses :) Though he also mentioned that if we go that route
Ben> (which is what we have now in fact), we take the burden of having
Ben> to test and fix drivers who don't get it...

We have to do this on SN2 anyway, so this way we can benefit from
each other's work :)

Cheers,
Jes
