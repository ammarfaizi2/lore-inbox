Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318427AbSGaSOD>; Wed, 31 Jul 2002 14:14:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318428AbSGaSOD>; Wed, 31 Jul 2002 14:14:03 -0400
Received: from [195.39.17.254] ([195.39.17.254]:2176 "EHLO Elf.ucw.cz")
	by vger.kernel.org with ESMTP id <S318427AbSGaSOC>;
	Wed, 31 Jul 2002 14:14:02 -0400
Date: Tue, 30 Jul 2002 11:17:48 +0200
From: Pavel Machek <pavel@ucw.cz>
To: Ingo Molnar <mingo@elte.hu>
Cc: Russell King <rmk@arm.linux.org.uk>, Christoph Hellwig <hch@lst.de>,
       Linus Torvalds <torvalds@transmeta.com>, Robert Love <rml@tech9.net>,
       linux-kernel@vger.kernel.org
Subject: Re: [patch] cli()/sti() cleanup, 2.5.27-A2
Message-ID: <20020730091747.GA331@elf.ucw.cz>
References: <20020722144626.D2838@flint.arm.linux.org.uk> <Pine.LNX.4.44.0207221546320.9136-100000@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0207221546320.9136-100000@localhost.localdomain>
User-Agent: Mutt/1.3.28i
X-Warning: Reading this can be dangerous to your mental health.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > > It's not that we confuse flags with some other flag all that
> > > frequently that would necessiate some structure-based more abstract
> > > protection of these variables.
> 
> are you sure type-checking is really needed? Sure people can mess up the
> flags variable, but 64-bit archs could do a sizeof at compile-time.

Yes, it is needed; type-checking can be easily implemented as 

{
	unsigned long foo;
	(&foo == &arg);
}

 -- that gives warning when arg is not unsigned long.
								Pavel


-- 
Worst form of spam? Adding advertisment signatures ala sourceforge.net.
What goes next? Inserting advertisment *into* email?
