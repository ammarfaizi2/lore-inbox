Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262668AbUBZDaR (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 25 Feb 2004 22:30:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262706AbUBZD3y
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 25 Feb 2004 22:29:54 -0500
Received: from mail-01.iinet.net.au ([203.59.3.33]:7582 "HELO
	mail.iinet.net.au") by vger.kernel.org with SMTP id S262700AbUBZD3b
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 25 Feb 2004 22:29:31 -0500
Message-ID: <403D6816.1020000@cyberone.com.au>
Date: Thu, 26 Feb 2004 14:29:26 +1100
From: Nick Piggin <piggin@cyberone.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040122 Debian/1.6-1
X-Accept-Language: en
MIME-Version: 1.0
To: Mike Fedyk <mfedyk@matchmail.com>
CC: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: 2.6.3-mm3
References: <20040222172200.1d6bdfae.akpm@osdl.org>	<403BCE9E.7080607@matchmail.com> <20040224143025.36395730.akpm@osdl.org> <403D1347.8090801@matchmail.com> <403D468D.2090901@cyberone.com.au> <403D4CBE.9080805@matchmail.com> <403D5174.6050302@cyberone.com.au> <403D5B4C.3020309@matchmail.com> <403D5CB1.50409@cyberone.com.au> <403D5E79.5040508@matchmail.com> <403D6278.5010206@cyberone.com.au> <403D65D6.6050203@matchmail.com>
In-Reply-To: <403D65D6.6050203@matchmail.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Mike Fedyk wrote:

>
> So, you think vm-shrink-slab-lowmem.patch shrinks slab too much, or 
> Andrew's patch (IIRC, those comments were for Andrew's patch...)?
>

Mine does.

>
> Hmm, do you think I'd get more slab shrinking with 2.6.3 + 
> zone-balancing-fix.patch?
>


Not really because you shouldn't be hitting the direct reclaim
path. shrink_slab-for-all-zones.patch will help more though.

Nick

