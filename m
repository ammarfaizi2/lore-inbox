Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132704AbRBEEJH>; Sun, 4 Feb 2001 23:09:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132734AbRBEEI5>; Sun, 4 Feb 2001 23:08:57 -0500
Received: from saturn.cs.uml.edu ([129.63.8.2]:3336 "EHLO saturn.cs.uml.edu")
	by vger.kernel.org with ESMTP id <S132704AbRBEEIk>;
	Sun, 4 Feb 2001 23:08:40 -0500
From: "Albert D. Cahalan" <acahalan@cs.uml.edu>
Message-Id: <200102050408.f1548H243178@saturn.cs.uml.edu>
Subject: Re: [reiserfs-list] ReiserFS Oops (2.4.1, deterministic, symlink related)
To: ahzz@terrabox.com (Brian Wolfe)
Date: Sun, 4 Feb 2001 23:08:17 -0500 (EST)
Cc: reiser@namesys.com (Hans Reiser), alan@lxorguk.ukuu.org.uk (Alan Cox),
        ionut@moisil.cs.columbia.edu (Ion Badulescu),
        linux-kernel@vger.kernel.org, reiserfs-list@namesys.com,
        kas@informatics.muni.cz (Jan Kasprzak)
In-Reply-To: <20010204205013.D23921@ironsides.terrabox.com> from "Brian Wolfe" at Feb 04, 2001 08:50:13 PM
X-Mailer: ELM [version 2.5 PL2]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Brian Wolfe writes:

> I hate to say it but I think Hans might have the right answer here.
> As an administrator that has worked in large multi hundred million
> dollar companies where 1 hour of downtime == $75,000 in lost income
...
> From the debate raging here is what I gathered is acceptable....
> 
> make it blow up fataly and immediatly if it detects Red Hat +
> gcc 2.96-red_hat_broken(forgot version num) make it provide a URL
> to get the patch to remove this safeguard if you really want this.
>
> The fatal crash should be VERY carefull to only trigger on a redhat
> system with the broken compiler. And to satisfy your agument that
> people may need to be able to use it, provide a reverse patch to
> remove this safeguard in one easy cat file | patch.

There is another way: directly test for the bug.

In an __init function, have some code that will trigger the bug.
This can be used to disable Reiserfs if the compiler was bad.
Then the admin gets a printk() and the Reiserfs mount fails.
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
