Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264862AbTFRJb4 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 Jun 2003 05:31:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264994AbTFRJb4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 Jun 2003 05:31:56 -0400
Received: from Mail1.kontent.de ([81.88.34.36]:54500 "EHLO Mail1.KONTENT.De")
	by vger.kernel.org with ESMTP id S264862AbTFRJbz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 Jun 2003 05:31:55 -0400
From: Oliver Neukum <oliver@neukum.org>
To: Karl Vogel <karl.vogel@seagha.com>, linux-kernel@vger.kernel.org
Subject: Re: How do I make this thing stop laging?  Reboot?  Sounds like  Windows!
Date: Wed, 18 Jun 2003 11:44:43 +0200
User-Agent: KMail/1.5.1
References: <200306172030230870.01C9900F@smtp.comcast.net> <3EF0214A.3000103@aitel.hist.no> <E19SZ8v-0005Ie-00@relay-1.seagha.com>
In-Reply-To: <E19SZ8v-0005Ie-00@relay-1.seagha.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200306181144.43460.oliver@neukum.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> Swap prefetching? If you have >10% free physical ram and any used swap it
> will start swapping pages back into physical ram. Probably not of real
> benefit but many people like this idea. I have a soft spot for it and like
> using it.
> --
>
> The disadvantage is ofcourse that you will be using up more RAM than is
> really necessary.

No, free RAM is wasted RAM.
You will start wasting RAM once you refuse to free up
pages you just read from swap space for other more
important needs. But that's a general VM problem.

You'll waste IO bandwidth and CPU power to read in pages
that will be evicted unused, but you may get hits and save
page faults. It's just a matter of selecting pages to be preswapped.

But those preswapped pages are either clean and thus immediately
evictable or you were right to preswap them and saved a page fault.

	Regards
		Oliver

