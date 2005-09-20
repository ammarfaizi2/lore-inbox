Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932737AbVITG2Q@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932737AbVITG2Q (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 Sep 2005 02:28:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932739AbVITG2Q
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 Sep 2005 02:28:16 -0400
Received: from rwcrmhc12.comcast.net ([216.148.227.85]:49300 "EHLO
	rwcrmhc12.comcast.net") by vger.kernel.org with ESMTP
	id S932737AbVITG2P (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 Sep 2005 02:28:15 -0400
Message-ID: <432FABFA.9010406@namesys.com>
Date: Mon, 19 Sep 2005 23:28:10 -0700
From: Hans Reiser <reiser@namesys.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.5) Gecko/20041217
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Nick Piggin <nickpiggin@yahoo.com.au>
CC: Alan Cox <alan@lxorguk.ukuu.org.uk>, thenewme91@gmail.com,
       Christoph Hellwig <hch@infradead.org>,
       Denis Vlasenko <vda@ilport.com.ua>, chriswhite@gentoo.org,
       LKML <linux-kernel@vger.kernel.org>,
       ReiserFS List <reiserfs-list@namesys.com>,
       Nate Diller <ndiller@namesys.com>
Subject: Re: I request inclusion of reiser4 in the mainline kernel
References: <432AFB44.9060707@namesys.com>	 <200509171415.50454.vda@ilport.com.ua>	 <200509180934.50789.chriswhite@gentoo.org>	 <200509181321.23211.vda@ilport.com.ua>	 <20050918102658.GB22210@infradead.org>	 <b14e81f0050918102254146224@mail.gmail.com> <1127079524.8932.21.camel@localhost.localdomain> <432E4786.7010001@namesys.com> <432F8D1E.7060300@yahoo.com.au>
In-Reply-To: <432F8D1E.7060300@yahoo.com.au>
X-Enigmail-Version: 0.90.1.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Nick Piggin wrote:

> Hans Reiser wrote:
>
>> So why is the code in the kernel so hard to read then?
>>
>> Linux kernel code is getting better, and Andrew Morton's code is
>> especially good, but for the most part it's unnecessarily hard to
>> read. Look at the elevator code for instance.  Ugh.
>>
>>
>
> What's wrong with the elevator code?
>
The name for one.  There is no elevator algorithm anywhere in it.  There
is a least block number first algorithm that was called an elevator, but
it does not have the properties described by Ousterhout and sundry CS
textbooks describing elevator algorithms.  The textbook algorithms are
better than least block number first, and it is interesting how nobody
fixed the mislabeling of the algorithm once Linux had gotten to the
point that it was striving for more than making gcc be able to run on it. 

cfq is good code though for many usage patterns. 

I would say more, but I need to talk a customer into ok'ing releasing
some code first, so I can only say what I knew before doing the work for
that customer at this time.

If you would like many more details of coding/commenting inelegance, ask
Nate Diller after the customer oks his talking about it, which will
happen more easily if we say nothing that we did not know before the
work for them until we first get their ok.....

Hans
