Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314496AbSEFPSH>; Mon, 6 May 2002 11:18:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314505AbSEFPSG>; Mon, 6 May 2002 11:18:06 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.31.123]:18183 "EHLO
	atrey.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id <S314496AbSEFPSE>; Mon, 6 May 2002 11:18:04 -0400
Date: Mon, 6 May 2002 17:18:05 +0200
From: Pavel Machek <pavel@suse.cz>
To: hugang <gang_hu@soul.com.cn>
Cc: Jeff Dike <jdike@karaya.com>, glonnon@ridgerun.com, seasons@fornax.hu,
        linux-kernel@vger.kernel.org
Subject: Re: [PATH] Port software to UML.
Message-ID: <20020506151805.GD12131@atrey.karlin.mff.cuni.cz>
In-Reply-To: <20020505214819.19cb9a86.gang_hu@soul.com.cn> <200205060022.TAA03703@ccure.karaya.com> <20020506105025.217b96e6.gang_hu@soul.com.cn>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.27i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > > Ther problem in bread.
> > 
> > No, the problem is in not understanding UML.
> > 
> > UML's state is somewhat more complicated than the state of a native kernel.
> > 
> > You also need to recreate 
> > 	the host processes
> > 	the ptrace relationships between the tracing thread and the other 
> > processes
> > 	open file descriptors
> > 	and maybe a few other things that aren't coming to mind
> > 
> > 				Jeff
> 
> Now , I found the Problem. Fix that have two way 
> --1 after the register disk , We not close it.
> --2 at prepare_request , We check the dev->count, it not open , must open it first.
> 
> The 1.diff is use the 1 way.
> the 2.diff is use the 2 way.

Jeff is right that you might recreate a little more state...

However, with a little luck, what you do might partly work. Does it
successfully resume for you?
								Pavel
PS: Jeff, any chance of uml going to 2.5. soon? It would be difficult
for me to merge swsusp/uml patches when uml is not in the kernel :-(.
-- 
Casualities in World Trade Center: ~3k dead inside the building,
cryptography in U.S.A. and free speech in Czech Republic.
