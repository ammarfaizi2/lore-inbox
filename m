Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261916AbTJXArv (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Oct 2003 20:47:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261920AbTJXArv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Oct 2003 20:47:51 -0400
Received: from wombat.indigo.net.au ([202.0.185.19]:4870 "EHLO
	wombat.indigo.net.au") by vger.kernel.org with ESMTP
	id S261916AbTJXArt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Oct 2003 20:47:49 -0400
Date: Fri, 24 Oct 2003 08:47:57 +0800 (WST)
From: Ian Kent <raven@themaw.net>
X-X-Sender: <raven@wombat.indigo.net.au>
To: Mike Waychison <Michael.Waychison@Sun.COM>
cc: Ingo Oeser <ioe-lkml@rameria.de>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [NFS] RE: [autofs] multiple servers per automount
In-Reply-To: <3F980949.1040201@sun.com>
Message-ID: <Pine.LNX.4.33.0310240839090.14084-100000@wombat.indigo.net.au>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Thanks for the description.

I thought it was bad to call a function that could block while
holding a lock. At least I was close to right this time.

I wasn't aware of the badness I'll see what I can find.

On Thu, 23 Oct 2003, Mike Waychison wrote:

>
> Ingo's patch simply moved the allocation outside the spinlock..  See my
> later patch about moving the allocation to and __init section, which is
> probably the cleaner thing to do and doesn't require grabbing the page
> and using it conditionally.
>

Missed that when I returned to it. Found it now.

That is clearly a better way to do it.

I there any chance this would be accepted into 2.6.0?

I think it's quite important, hopefully others do as well.


-- 

   ,-._|\    Ian Kent
  /      \   Perth, Western Australia
  *_.--._/   E-mail: raven@themaw.net
        v    Web: http://themaw.net/

