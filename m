Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316161AbSGATDJ>; Mon, 1 Jul 2002 15:03:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316163AbSGATDI>; Mon, 1 Jul 2002 15:03:08 -0400
Received: from dingo.clsp.jhu.edu ([128.220.34.67]:43784 "EHLO bug.ucw.cz")
	by vger.kernel.org with ESMTP id <S316161AbSGATDH>;
	Mon, 1 Jul 2002 15:03:07 -0400
Date: Mon, 1 Jul 2002 04:29:58 +0200
From: Pavel Machek <pavel@ucw.cz>
To: Matti Aarnio <matti.aarnio@zmailer.org>
Cc: "Salvatore D'Angelo" <dangelo.sasaman@tiscalinet.it>,
       Chris McDonald <chris@cs.uwa.edu.au>, linux-kernel@vger.kernel.org
Subject: Re: gettimeofday problem
Message-ID: <20020701022957.GD829@elf.ucw.cz>
References: <3D16DE83.3060409@tiscalinet.it> <200206240934.g5O9YL524660@budgie.cs.uwa.edu.au> <3D16F252.90309@tiscalinet.it> <20020624154620.P19520@mea-ext.zmailer.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20020624154620.P19520@mea-ext.zmailer.org>
User-Agent: Mutt/1.3.28i
X-Warning: Reading this can be dangerous to your mental health.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > In this piece of code I convert seconds and microseconds in 
> > milliseconds. I think the problem is not in my code, in fact I wrote the 
> > following piece of code in Java, and it does not work too. In the for 
> > loop the 90% of times b > a while for 10% of times not.
> > 
> ...
> >                     long a = System.currentTimeMillis();
> >                     long b = System.currentTimeMillis();
> >                     if (a > b) {
> >                          System.out.println("Wrong!!!!!!!!!!!!!");
> >                     }
> 
> 
>    So in 10% of the cases, two successive calls yield time
>    rolling BACK ?
> 
>    I used  gettimeofday()  call, and compared the original data
>    from the code.
> 
>    At a modern uniprocessor machine I never get anything except
>    monotonously increasing time (TSC is used in betwen timer ticks
>    to supply time increase.)   At a dual processor machine, on
>    occasion I do get SAME value twice.   I have never seen time
>    rolling backwards.
> 
>    Uh..  correction:  216199245  0:-1  -- it did step backwards,
>    but only once within about 216 million gettimeofday() calls.
>    (I am running 2.4.19-pre8smp at the test box.)

Hmm, so it is buggy even for you. He probably has way crappier
hardware. Neptun chipsets and via chipsets have bugs in time
implementation.
									Pavel
-- 
(about SSSCA) "I don't say this lightly.  However, I really think that the U.S.
no longer is classifiable as a democracy, but rather as a plutocracy." --hpa
