Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261181AbUCAJLG (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 1 Mar 2004 04:11:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261188AbUCAJLG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 1 Mar 2004 04:11:06 -0500
Received: from mail-04.iinet.net.au ([203.59.3.36]:59284 "HELO
	mail.iinet.net.au") by vger.kernel.org with SMTP id S261181AbUCAJK6
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 1 Mar 2004 04:10:58 -0500
Message-ID: <4042FE0D.5030603@cyberone.com.au>
Date: Mon, 01 Mar 2004 20:10:37 +1100
From: Nick Piggin <piggin@cyberone.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040122 Debian/1.6-1
X-Accept-Language: en
MIME-Version: 1.0
To: Nick Piggin <piggin@cyberone.com.au>
CC: Mike Fedyk <mfedyk@matchmail.com>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org
Subject: Re: MM VM patches was: 2.6.3-mm4
References: <20040225185536.57b56716.akpm@osdl.org> <4042F38B.8020307@matchmail.com> <4042F7E6.1050904@cyberone.com.au>
In-Reply-To: <4042F7E6.1050904@cyberone.com.au>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Nick Piggin wrote:

>
> There are a few things backed out now in 2.6.4-rc1-mm1, and quite a
> few other changes. I hope we can trouble you to test 2.6.4-rc1-mm1?
>
> Tell me, do you have highmem enabled on this system? If so, swapping
> might be explained by the batching patch. With it, a small highmem
> zone could possibly place quite a lot more pressure on a large
> ZONE_NORMAL.
>
> 2.6.4-rc1-mm1 sould do much better here.


Gah no. It would have the same problem actually, if that is indeed
what is happening.

It will take a bit more work to solve this in rc1-mm1. You would
probably want to explicitly use incremental min limits for kswapd.

(background info in kswapd-avoid-higher-zones.patch)

