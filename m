Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S272498AbRH3V5H>; Thu, 30 Aug 2001 17:57:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S272510AbRH3V45>; Thu, 30 Aug 2001 17:56:57 -0400
Received: from oboe.it.uc3m.es ([163.117.139.101]:22282 "EHLO oboe.it.uc3m.es")
	by vger.kernel.org with ESMTP id <S272498AbRH3V4m>;
	Thu, 30 Aug 2001 17:56:42 -0400
From: "Peter T. Breuer" <ptb@it.uc3m.es>
Message-Id: <200108302156.f7ULujo24456@oboe.it.uc3m.es>
Subject: Re: [IDEA+RFC] Possible solution for min()/max() war
In-Reply-To: <11528.999208069@redhat.com> from "David Woodhouse" at "Aug 30,
 2001 10:47:49 pm"
To: "David Woodhouse" <dwmw2@infradead.org>
Date: Thu, 30 Aug 2001 23:56:45 +0200 (MET DST)
CC: ptb@it.uc3m.es, "Herbert Rosmanith" <herp@wildsau.idv-edu.uni-linz.ac.at>,
        linux-kernel@vger.kernel.org, dhowells@cambridge.redhat.com
X-Anonymously-To: 
Reply-To: ptb@it.uc3m.es
X-Mailer: ELM [version 2.4ME+ PL66 (25)]
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"A month of sundays ago David Woodhouse wrote:"
> Code which relies on "if(0) __call_nonexistent_function();" actually compiling 
> is just broken.

You got me curious enough to try it.  It compiles and links fine with
-O1 and higher under

       gcc version 2.95.2 20000220 (Debian GNU/Linux)
       gcc version 2.8.1
       gcc version 2.7.2.3

> You'd have thought we'd have learned by now to stop relying on the observed 
> current behaviour of gcc and start trying to get it right, wouldn't you?

One CAN rely on this behaviour so long as branch reduction (well,
whatever it's called) is an optimizing step following constant
expression evaluation.  The fn call will never make it outside of gcc's
internal repreentation.

> The answer in this case is that gcc can't safely do what we require for this
> and for other compile-time checks, until something like David's
> __builtin_ct_assertion() is added.


Peter
