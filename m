Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S136993AbRATArY>; Fri, 19 Jan 2001 19:47:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S137106AbRATArP>; Fri, 19 Jan 2001 19:47:15 -0500
Received: from saturn.cs.uml.edu ([129.63.8.2]:22022 "EHLO saturn.cs.uml.edu")
	by vger.kernel.org with ESMTP id <S136993AbRATArF>;
	Fri, 19 Jan 2001 19:47:05 -0500
From: "Albert D. Cahalan" <acahalan@cs.uml.edu>
Message-Id: <200101200046.f0K0kgj201065@saturn.cs.uml.edu>
Subject: Re: Coding Style
To: mark4@purplecoder.com (Mark I Manning IV)
Date: Fri, 19 Jan 2001 19:46:42 -0500 (EST)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <3A68809B.E12EF3D9@purplecoder.com> from "Mark I Manning IV" at Jan 19, 2001 12:59:55 PM
X-Mailer: ELM [version 2.5 PL2]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Tabs are 8 characters so NO tabs should be used in ANY source file what 
...
> Rationale:  Tabs force your code out to the right edge of the display
> leaving no room for comments.  You don't need great big gaping spaces to
> delineate the start and end of a block, TWO spaces do this just fine.

Correct, because adjustable tab width is a myth. The comments don't
line up when you muck with tab width.

>   int function(int x)   
>   {
>     body of function    // correctly braced and commented :)
>   }

1. put your head in a PET scanner
2. think about Pascal while the doctors observe
3. get radiation treatment to kill neurons infected with Pascal

> Linus states that the placement of the first brace at the end of the 
> first line keeps your code less vertical and thus saves you some space
> for comments.  This commenting style just plane sucks, it fragments your
> source file creating all kinds of visual clutter making them impossible 
> to read.  New lines ARE A RENEWABLE resource, if they aren't then you need 
> to buy more ram for your 8086 (or is it a z80 ?).

I get 30 to 60 lines on my monitors, but I want over 200 lines.
Such a monitor would be at least $6000, assuming I could find one.
(fuzzy text doesn't count)

> One other thing.  Allot of people neglect to brace a statement if 
> it has a single line body.  This is VERY bad, always brace your
> statements....
> 
>  if (x = 1)
>    if (y = 2)
>      if (z = 3)
>        for (i = 1; i < 10; i++)
>          if ....
>            switch (foo)
>              .....
> 
> ...is really stupid.  DON'T DO IT!

Agreed, but braces are not the fix.

> I would however like to state that the C switch statement is evil and
> to be avoided at all costs.  If you really need to use one for what 
> ever reason then each case in that switch statement should be a

The gcc computed goto extension is better, because it doesn't suffer
the overhead of that stupid built-in default. We need __raw_switch
to overcome this. If I leave out the default and pass in bogus values
then I should get a crash. (this is about performance)

> I have never really liked the C language, it seems to me that it has a
> habit of making ANY idiot think he/she can be a coder.  C is an easy 
> language to learn but to be a good C coder takes years of hard study
> and a TRUE artistic flair for programming.  This means that 99% of all 
> C code is JUNK code.  

I'm still looking for a readable description of C99 aliasing rules
and proper usage of "restrict". It is no wonder that schools are
switching to Java.



-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
