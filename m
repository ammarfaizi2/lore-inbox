Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S279257AbRKAQ1B>; Thu, 1 Nov 2001 11:27:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S279250AbRKAQ0v>; Thu, 1 Nov 2001 11:26:51 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:44038 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S279257AbRKAQ0f>; Thu, 1 Nov 2001 11:26:35 -0500
To: linux-kernel@vger.kernel.org
From: torvalds@transmeta.com (Linus Torvalds)
Subject: Re: Stress testing 2.4.14-pre6
Date: Thu, 1 Nov 2001 16:24:09 +0000 (UTC)
Organization: Transmeta Corporation
Message-ID: <9rrsv9$b9l$1@penguin.transmeta.com>
In-Reply-To: <3BE073B6.BDCB3D56@redhat.com>
X-Trace: palladium.transmeta.com 1004631988 14366 127.0.0.1 (1 Nov 2001 16:26:28 GMT)
X-Complaints-To: news@transmeta.com
NNTP-Posting-Date: 1 Nov 2001 16:26:28 GMT
Cache-Post-Path: palladium.transmeta.com!unknown@penguin.transmeta.com
X-Cache: nntpcache 2.4.0b5 (see http://www.nntpcache.org/)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <3BE073B6.BDCB3D56@redhat.com>,
Bob Matthews  <bmatthews@redhat.com> wrote:
>Hi Linus,
>
>We've been doing some stress-testing on 2.4.14-pre6 and have encountered
>a couple of problems.  The platform is an 8xPIII with 8G RAM and 32G
>swap.  After running Cerberus for about 3 hours, the machine hung
>completely.  I was not able to switch VC's.

There is some race somewhere - I've found one interrupt race (that
actually seems to exist in the 2.2.x VM too, but is probably _much_
harder to trigger where an interrupt at _just_ the right time will
corrupt the per-process local page list.  That looks so unlikely that I
doubt that is it, but I'm looking for others (the irq one wasn't even a
SMP race - it's on UP too, surprise surprise). 

Working on it, in other words.

		Linus
