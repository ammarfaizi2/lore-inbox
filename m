Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932445AbWEHRnh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932445AbWEHRnh (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 8 May 2006 13:43:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932430AbWEHRnh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 May 2006 13:43:37 -0400
Received: from dsl027-180-168.sfo1.dsl.speakeasy.net ([216.27.180.168]:46016
	"EHLO sunset.davemloft.net") by vger.kernel.org with ESMTP
	id S932424AbWEHRng (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 May 2006 13:43:36 -0400
Date: Mon, 08 May 2006 10:43:22 -0700 (PDT)
Message-Id: <20060508.104322.58430929.davem@davemloft.net>
To: pavel@suse.cz
Cc: hswong3i@gmail.com, netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] TCP congestion module: add TCP-LP supporting for
 2.6.16.14
From: "David S. Miller" <davem@davemloft.net>
In-Reply-To: <20060508112915.GB4162@ucw.cz>
References: <3feffd230605062232m1b9a3951h6d21071cdacc890f@mail.gmail.com>
	<20060508112915.GB4162@ucw.cz>
X-Mailer: Mew version 4.2.53 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Pavel Machek <pavel@suse.cz>
Date: Mon, 8 May 2006 11:29:15 +0000

> Hi!
> 
> > TCP Low Priority is a distributed algorithm whose goal 
> > is to utilize only
> > the excess network bandwidth as compared to the ``fair 
> > share`` of
> > bandwidth as targeted by TCP. Available from:
> >   http://www.ece.rice.edu/~akuzma/Doc/akuzma/TCP-LP.pdf
> 
> Nice... I'd like to use something like this on my (overloaded)
> GPRS/EDGE link.
> 
> Unfortunately, patch does not include documentation update AFAICS. How
> do I use it? net-nice -n 19 rsync would be nice, but I guess that
> would be quite complex...?

You could select it as the default congestion control algorithm
in your kernel config, but that's probably not what you want.

Or, just include it, and select it with the TCP_CONGESTION socket
option when you want it.  Sorry, this does require app modifications.
