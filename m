Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264365AbTLYU7l (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 25 Dec 2003 15:59:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264366AbTLYU7l
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 25 Dec 2003 15:59:41 -0500
Received: from [213.94.3.94] ([213.94.3.94]:1409 "EHLO sacarino.pirispons.net")
	by vger.kernel.org with ESMTP id S264365AbTLYU7X (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 25 Dec 2003 15:59:23 -0500
Date: Thu, 25 Dec 2003 21:59:17 +0100
From: Kiko Piris <kernel@pirispons.net>
To: linux-kernel@vger.kernel.org
Subject: Re: Make ppp_async callable from hard interrupt
Message-ID: <20031225205917.GA7238@sacarino.pirispons.net>
Mail-Followup-To: linux-kernel@vger.kernel.org
References: <16356.60597.133074.809551@cargo.ozlabs.ibm.com> <20031225100850.GA6629@penguin.localdomain> <20031225022228.69f78d18.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20031225022228.69f78d18.akpm@osdl.org>
User-Agent: Mutt
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 25/12/2003 at 02:22, Andrew Morton wrote:

> (Marcel Sebek) wrote:

> >  If this is true, skb will be used uninitialized.
> 
> True.    Here's an updated patch.

I applied the first patch to 2.6.0-ben1 (benH's tree) and had a couple
of hard freezes on my iBook. Not on the first ppp connection since boot,
but around 4th or 5th).

I _suspect_ (with absolutely no evidence) this was the same problem as
the ppp oopses pointed by other people with 2.6.0-mm1.

But I was under X and nothing was written to the logs (ie. no info at
all about the error), so I couldn't tell if the culprit was ppp_async.

And this was the very first time I used my modem (rs-232 with usb-serial
/ ftdi_sio) with 2.6, so I had too little info to post anything here.


But the fact is that with this lastest patch (w/ the correction pointed
by Marcel Sebek, everything seems to work ok here (about half a dozen
connections w/o problems).

Just wanted to add some info in case it could be useful to track this
issue.

Feel free to ask any additional info, I'll be glad if I can help in any
way.

A big thank you to everyone and season's greetings

-- 
Kiko
