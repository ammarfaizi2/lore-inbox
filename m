Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263618AbTIBIPL (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 2 Sep 2003 04:15:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263620AbTIBIPL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 Sep 2003 04:15:11 -0400
Received: from dyn-ctb-203-221-73-133.webone.com.au ([203.221.73.133]:13574
	"EHLO chimp.local.net") by vger.kernel.org with ESMTP
	id S263618AbTIBIPI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 Sep 2003 04:15:08 -0400
Message-ID: <3F545175.1080505@cyberone.com.au>
Date: Tue, 02 Sep 2003 18:14:45 +1000
From: Nick Piggin <piggin@cyberone.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030827 Debian/1.4-3
X-Accept-Language: en
MIME-Version: 1.0
To: Mitchell Blank Jr <mitch@sfgoth.com>
CC: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] might_sleep() improvements
References: <20030902075145.GA12817@sfgoth.com>
In-Reply-To: <20030902075145.GA12817@sfgoth.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Mitchell Blank Jr wrote:

>Andrew - I thought this might be appropriate for -mm kernels.
>
>This patch makes the following improvements to might_sleep():
>
> o Add a "might_sleep_if()" macro for when we might sleep only if some
>   condition is met.  I think this is a bit better than the currently used
>   "if (cond) might_sleep();" since it's clearer that the test won't be
>   compiled in if spinlock sleep debugging is turned off.  (Obviously
>   gcc is smart enough to omit simple conditions in that case)  It also
>   looks cleaner, IMO.  Think of it as analogous to BUG()/BUG_ON().
>

I think these should be pushed down to where the sleeping
actually happens if possible.


