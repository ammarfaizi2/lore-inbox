Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261751AbVDKOfq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261751AbVDKOfq (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 11 Apr 2005 10:35:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261752AbVDKOfq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Apr 2005 10:35:46 -0400
Received: from pat.uio.no ([129.240.130.16]:14038 "EHLO pat.uio.no")
	by vger.kernel.org with ESMTP id S261751AbVDKOfk convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Apr 2005 10:35:40 -0400
Subject: Re: bdflush/rpciod high CPU utilization, profile does not make
	sense
From: Trond Myklebust <trond.myklebust@fys.uio.no>
To: Jakob Oestergaard <jakob@unthought.net>
Cc: Greg Banks <gnb@sgi.com>, linux-kernel@vger.kernel.org
In-Reply-To: <20050411134703.GC13369@unthought.net>
References: <20050406160123.GH347@unthought.net>
	 <20050406231906.GA4473@sgi.com> <20050407153848.GN347@unthought.net>
	 <1112890671.10366.44.camel@lade.trondhjem.org>
	 <20050409213549.GW347@unthought.net>
	 <1113083552.11982.17.camel@lade.trondhjem.org>
	 <20050411074806.GX347@unthought.net>
	 <1113222939.14281.17.camel@lade.trondhjem.org>
	 <20050411134703.GC13369@unthought.net>
Content-Type: text/plain; charset=UTF-8
Date: Mon, 11 Apr 2005 10:35:25 -0400
Message-Id: <1113230125.9962.7.camel@lade.trondhjem.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 
Content-Transfer-Encoding: 8BIT
X-UiO-Spam-info: not spam, SpamAssassin (score=-3.857, required 12,
	autolearn=disabled, AWL 1.14, UIO_MAIL_IS_INTERNAL -5.00)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

må den 11.04.2005 Klokka 15:47 (+0200) skreiv Jakob Oestergaard:

> Certainly;
> 
> http://unthought.net/binary.dmp.bz2
> 
> I got an 'invalid snaplen' with the 90000 you suggested, the above dump
> is done with 9000 - if you need another snaplen please just let me know.

So, the RPC itself looks good, but it also looks as if after a while you
are running into some heavy retransmission problems with TCP too (at the
TCP level now, instead of at the RPC level). When you get into that
mode, it looks as if every 2nd or 3rd TCP segment being sent from the
client is being lost...

That can mean either that the server is dropping fragments, or that the
client is dropping the replies. Can you generate a similar tcpdump on
the server?

Cheers,
  Trond
-- 
Trond Myklebust <trond.myklebust@fys.uio.no>

