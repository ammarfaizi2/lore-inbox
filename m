Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267548AbTBDXLf>; Tue, 4 Feb 2003 18:11:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267550AbTBDXLf>; Tue, 4 Feb 2003 18:11:35 -0500
Received: from bitmover.com ([192.132.92.2]:6791 "EHLO mail.bitmover.com")
	by vger.kernel.org with ESMTP id <S267548AbTBDXLe>;
	Tue, 4 Feb 2003 18:11:34 -0500
Date: Tue, 4 Feb 2003 15:21:01 -0800
From: Larry McVoy <lm@bitmover.com>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: gcc 2.95 vs 3.21 performance
Message-ID: <20030204232101.GA9034@work.bitmover.com>
Mail-Followup-To: Larry McVoy <lm@work.bitmover.com>,
	Linus Torvalds <torvalds@transmeta.com>,
	linux-kernel@vger.kernel.org
References: <1044385759.1861.46.camel@localhost.localdomain> <200302041935.h14JZ69G002675@darkstar.example.net> <b1pbt8$2ll$1@penguin.transmeta.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b1pbt8$2ll$1@penguin.transmeta.com>
User-Agent: Mutt/1.4i
X-MailScanner: Found to be clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> I'd love to see a small - and fast - C compiler, and I'd be willing to
> make kernel changes to make it work with it.  

I can't offer any immediate help with this but I want the same thing.  At
some point, we're planning on funding some extensions into GCC or whatever
reasonable C compiler is around:

    - associative arrays as a builtin type

      {
      	  assoc	bar = {};	// anonymous, no file backing

	  bar{"some key"} = "some value";
	  if (defined(bar{"some other value"})) ...
      }

    - regular expressions

      {
      	  char	*foo = "blech";

	  if (foo =~ /regex are nice/) {
	  	printf("Well isn't that special?\n");
	  }
      }

    - tk bindings built in

and then we'll port BK to that compiler.  It's likely to be GCC because we
want to support all the different architectures but if a kernel sponsered
cc shows up we'll happily throw money at that.
-- 
---
Larry McVoy            	 lm at bitmover.com           http://www.bitmover.com/lm 
