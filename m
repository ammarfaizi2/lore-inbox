Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132471AbRDCDE5>; Mon, 2 Apr 2001 23:04:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132459AbRDCDEq>; Mon, 2 Apr 2001 23:04:46 -0400
Received: from sgi.SGI.COM ([192.48.153.1]:23640 "EHLO sgi.com")
	by vger.kernel.org with ESMTP id <S132421AbRDCDEe>;
	Mon, 2 Apr 2001 23:04:34 -0400
Message-ID: <3AC93D2A.760CE67F@sgi.com>
Date: Mon, 02 Apr 2001 20:02:02 -0700
From: LA Walsh <law@sgi.com>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.2 i686)
X-Accept-Language: en, en-US, en-GB, fr
MIME-Version: 1.0
To: Quim K Holland <qkholland@my-deja.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: [QUESTION] 2.4.x nice level
In-Reply-To: <200104022304.QAA19333@mail6.bigmailbox.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Quim K Holland wrote:
> 
> >>>>> "BS" == BERECZ Szabolcs <szabi@inf.elte.hu> writes:
> 
> BS> ... a setiathome running at nice level 19, and a bladeenc at
> BS> nice level 0. setiathome uses 14 percent, and bladeenc uses
> BS> 84 percent of the processor. I think, setiathome should use
> BS> max 2-3 percent.  the 14 percent is way too much for me.
> BS> ...
> BS> with kernel 2.2.16 it worked for me.
> BS> now I use 2.4.2-ac20
---
	I was running 2 copies of setiathome on a 4 CPU server
@ work.  The two processes ran nice'd -19.  The builds we were 
running still took 20-30% longer as opposed to when setiathome wasn't
running (went from 45 minutes up to about an hour).  This machine
has 1G, so I don't think it was hurting from swapping.

I finally wrote a script that checked every 30 seconds -- if the
load on the machine climbed over '4', the script would SIGSTOP the
seti jobs.  Once the load on the machine fell below 2, it would 
send a SIGCONT to them.  

I was also running setiathome on my laptop for a short while --
but the fan kept coming on and the computer would get really hot.
So I stopped that.  Linux @ idle doesn't seem to ever kick on
the fan, but turn on a CPU cruching program and it sure seemed
to heat up the machine.  I still wonder how many kilo or mega watts
go to running dispersed computation programs.  Just one of those
things I may never know....

-l

-- 
The above thoughts and           | They may have nothing to do with
writings are my own.             | the opinions of my employer. :-)
L A Walsh                        | Trust Technology, Core Linux, SGI
law@sgi.com                      | Voice: (650) 933-5338
