Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262792AbSKLAZm>; Mon, 11 Nov 2002 19:25:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264758AbSKLAZm>; Mon, 11 Nov 2002 19:25:42 -0500
Received: from momus.sc.intel.com ([143.183.152.8]:14803 "EHLO
	momus.sc.intel.com") by vger.kernel.org with ESMTP
	id <S262792AbSKLAZl>; Mon, 11 Nov 2002 19:25:41 -0500
Message-ID: <A46BBDB345A7D5118EC90002A5072C7806CAC91F@orsmsx116.jf.intel.com>
From: "Perez-Gonzalez, Inaky" <inaky.perez-gonzalez@intel.com>
To: "'Mark Mielke'" <mark@mark.mielke.cc>
Cc: linux-kernel@vger.kernel.org
Subject: RE: PROT_SEM + FUTEX
Date: Mon, 11 Nov 2002 16:31:48 -0800
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain;
	charset="ISO-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> frequently. I would find any application that needed to actively wait
> on 4000 futex objects to be either incorrectly designed, or under
> enough load that I think an investment in a few more CPU's would be
> worthwhile... :-)

Not really; well, yeah really, but on other side; the case 
I am talking about is threaded applications with thousands of threads 
[no  kidding], where for example, 2K are producers and 4K are consumers;
there you have a rough 50% rate of contention for each lock [assume
each producer has a lock that the two consumers need to acquire]; the
contention might not be very bad, but as an average you might have
around 1000 futexes locked, that would add up to, in worst case, 1000
pages locked ...

However, if you do some thousand threads, you better have more memory
so that 1000 pages locked does not really mind :]

Inaky Perez-Gonzalez -- Not speaking for Intel - opinions are my own [or my
fault]
