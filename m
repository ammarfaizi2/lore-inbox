Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312917AbSDYFNs>; Thu, 25 Apr 2002 01:13:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312920AbSDYFNr>; Thu, 25 Apr 2002 01:13:47 -0400
Received: from samba.sourceforge.net ([198.186.203.85]:58498 "HELO
	lists.samba.org") by vger.kernel.org with SMTP id <S312917AbSDYFNr>;
	Thu, 25 Apr 2002 01:13:47 -0400
Date: Thu, 25 Apr 2002 15:12:49 +1000
From: Anton Blanchard <anton@samba.org>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] gcc 3.1 breaks wchan
Message-ID: <20020425051249.GB22384@krispykreme>
In-Reply-To: <20020425014325.GA22384@krispykreme> <Pine.LNX.4.44.0204242158140.6714-100000@home.transmeta.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 
> ABSOLUTELY NOT!
>
> "extern inline" does not guarantee inlining. It only guarantees that _if_
> the code isn't inlined, it also won't be compiled as a static function.

Isnt that the correct behaviour for this function? We rely on that code
being inlined so if it doesnt get inlined we should fail to link. Im
not solving the problem with this patch, I'll leave that to the gcc
guys.

> Complain to the gcc guys, they've made up some not-backwards-compatible
> thing called "always_inline" or something, apparently without any way to
> know whether it is supported or not.

Yes, Alan Modra just pointed me to __attribute__ ((always_inline)).

Anton
