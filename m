Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319087AbSIJJf7>; Tue, 10 Sep 2002 05:35:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319090AbSIJJf7>; Tue, 10 Sep 2002 05:35:59 -0400
Received: from dp.samba.org ([66.70.73.150]:52707 "EHLO lists.samba.org")
	by vger.kernel.org with ESMTP id <S319087AbSIJJf6>;
	Tue, 10 Sep 2002 05:35:58 -0400
From: Rusty Russell <rusty@rustcorp.com.au>
To: "David S. Miller" <davem@redhat.com>
Cc: pavel@suse.cz, torvalds@transmeta.com, linux-kernel@vger.kernel.org,
       akpm@zip.com.au
Subject: Re: [PATCH] Important per-cpu fix. 
In-reply-to: Your message of "Mon, 09 Sep 2002 01:15:39 MST."
             <20020909.011539.122194350.davem@redhat.com> 
Date: Tue, 10 Sep 2002 19:41:05 +1000
Message-Id: <20020910094045.695DD2C363@lists.samba.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In message <20020909.011539.122194350.davem@redhat.com> you write:
>    I want *you* to feel the pain, not spread it around by leaving turds
>    throughout the code long after the bug is forgotten:
>    
> Aha, but it is you putting the turd comments all over.  I'm
> suggesting to put the turd in one place, the header file.

.... and every user of it...

> And how difficult is it to discern which initializers were
> needed?  Hmmm let me see, if it was all zero --> removing it
> is harmless.

Let's not get onto initializer wars: I initialize all my variables
exactly once, so there's serious semantic difference between "static
int x;" and "static int x = 0;" in my code.

> Both of us are advocating adding shit to the tree, the only argument
> is which stinks less from a maintainence perspective.

Hey, I'm not stopping you sending a patch to Linus, but given how we
deprecated compilers on x86, I don't think he'll have sympathy for
you in 2.6.

Rusty.
--
  Anyone who quotes me in their sig is an idiot. -- Rusty Russell.
