Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293588AbSCFPVh>; Wed, 6 Mar 2002 10:21:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293599AbSCFPV1>; Wed, 6 Mar 2002 10:21:27 -0500
Received: from atrey.karlin.mff.cuni.cz ([195.113.31.123]:39951 "EHLO
	atrey.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id <S293588AbSCFPVK>; Wed, 6 Mar 2002 10:21:10 -0500
Date: Wed, 6 Mar 2002 16:21:06 +0100
From: Pavel Machek <pavel@suse.cz>
To: "Richard B. Johnson" <root@chaos.analogic.com>
Cc: kernel list <linux-kernel@vger.kernel.org>, torvalds@transmeta.com,
        "Marcelo W. Tosatti" <marcelo@conectiva.com.br>
Subject: Re: execve() fails to report errors
Message-ID: <20020306152106.GD21479@atrey.karlin.mff.cuni.cz>
In-Reply-To: <20020305233437.GA130@elf.ucw.cz> <Pine.LNX.3.95.1020306090414.31541A-100000@chaos.analogic.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.3.95.1020306090414.31541A-100000@chaos.analogic.com>
User-Agent: Mutt/1.3.27i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > Take this trivial .c program. Obviously correct.
> > 
> > 
> > struct foo {
> >         char fill[1*1024*1024*1024];
> > };
> > 
> > struct foo a;
> > 
> > void
> > main(void)
> > {
> > }
> > 
> > Compile. Run. Segfault.
> > 
> > Whose fault? Kernels; it fails to corectly report not enough address
> > space.
> 
> I think the bug has to be found earlier on up the food chain.
> If you do:

Well, nothing earlier can know if there  will be enough address space
at runtime. (It depends on kernel config .. 3GB vs 2GB ...)
								Pavel

-- 
Casualities in World Trade Center: ~3k dead inside the building,
cryptography in U.S.A. and free speech in Czech Republic.
