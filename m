Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263965AbRFELnE>; Tue, 5 Jun 2001 07:43:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263966AbRFELmy>; Tue, 5 Jun 2001 07:42:54 -0400
Received: from HSE-MTL-ppp71904.qc.sympatico.ca ([64.229.198.221]:13241 "HELO
	oscar.casa.dyndns.org") by vger.kernel.org with SMTP
	id <S263965AbRFELmg>; Tue, 5 Jun 2001 07:42:36 -0400
Content-Type: text/plain; charset=US-ASCII
From: Ed Tomlinson <tomlins@cam.org>
Organization: me
To: Mike Galbraith <mikeg@wen-online.de>,
        Marcelo Tosatti <marcelo@conectiva.com.br>
Subject: Re: Comment on patch to remove nr_async_pages limit
Date: Tue, 5 Jun 2001 07:42:28 -0400
X-Mailer: KMail [version 1.2]
Cc: Zlatko Calusic <zlatko.calusic@iskon.hr>,
        lkml <linux-kernel@vger.kernel.org>, <linux-mm@kvack.org>
In-Reply-To: <Pine.LNX.4.33.0106051140270.1227-100000@mikeg.weiden.de>
In-Reply-To: <Pine.LNX.4.33.0106051140270.1227-100000@mikeg.weiden.de>
MIME-Version: 1.0
Message-Id: <01060507422800.28232@oscar>
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

To paraphase Mike,

We defer doing IO until we are under short of storage.  Doing IO uses storage.
So delaying IO as much as we do forces us to impose limits.  If we did the IO
earlier we would not need this limit often, if at all.

Does this make any sense?

Maybe we can have the best of both worlds.  Is it possible to allocate the BH
early and then defer the IO?  The idea being to make IO possible without having
to allocate.  This would let us remove the async page limit but would ensure
we could still free.

Thoughts?
Ed Tomlinson
