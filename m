Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266462AbSKUJYb>; Thu, 21 Nov 2002 04:24:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266464AbSKUJYb>; Thu, 21 Nov 2002 04:24:31 -0500
Received: from ns.tasking.nl ([195.193.207.2]:29711 "EHLO ns.tasking.nl")
	by vger.kernel.org with ESMTP id <S266462AbSKUJYa>;
	Thu, 21 Nov 2002 04:24:30 -0500
Message-ID: <3DDCA7C9.9040501@netscape.net>
Date: Thu, 21 Nov 2002 10:30:49 +0100
From: David Zaffiro <davzaffiro@netscape.net>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.0) Gecko/20020623 Debian/1.0.0-0.woody.1
X-Accept-Language: nl, en-us
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Re: Compiling x86 with and without frame pointer
References: <19005.1037854033@kao2.melbourne.sgi.com> <20021121050607.GA1554@mark.mielke.cc>
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I use -momit-leaf-frame-pointer for optimization in some own projects, 
instead of the "-fomit-frame-pointer". For me, this results in better 
codesize/speed compared to both "-fomit-frame-pointer" or no option at 
all. Actually gcc-2.95 seems to support this feature as well, but it 
never made it into the 2.95 docs... It makes debugging a lot easier too.

So anyone "caring to benchmark", could you please test the 
"-momit-leaf-frame-pointer" option for x86 as well...


Mark Mielke wrote:
> A few weeks ago I was surprised to find that code compiled with
> -fomit-frame-pointers reliably executed a few percentages slower.
> Since the functions I was testing were not anywhere big enough to
> fill even the I1 cache, I wrote it off as 'the CPU is obviously
> optimized to expect certain instruction sequences after call and
> before ret'. Something to think about anyways...

