Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262474AbTIENDr (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 5 Sep 2003 09:03:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262568AbTIENDr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 5 Sep 2003 09:03:47 -0400
Received: from auth22.inet.co.th ([203.150.14.104]:23315 "EHLO
	auth22.inet.co.th") by vger.kernel.org with ESMTP id S262474AbTIENDo convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 5 Sep 2003 09:03:44 -0400
From: Michael Frank <mhf@linuxmail.org>
To: insecure@mail.od.ua, Yann Droneaud <yann.droneaud@mbda.fr>,
       fruhwirth clemens <clemens-dated-1063536166.2852@endorphin.org>
Subject: Re: nasm over gas?
Date: Fri, 5 Sep 2003 20:59:47 +0800
User-Agent: KMail/1.5.2
Cc: linux-kernel@vger.kernel.org,
       =?iso-8859-1?q?J=F6rn=20Engel?= <joern@wohnheim.fh-wedel.de>
References: <20030904104245.GA1823@leto2.endorphin.org> <200309042257.12739.mhf@linuxmail.org> <200309050128.47002.insecure@mail.od.ua>
In-Reply-To: <200309050128.47002.insecure@mail.od.ua>
X-OS: KDE 3 on GNU/Linux
MIME-Version: 1.0
Content-Disposition: inline
Message-Id: <200309052058.11982.mhf@linuxmail.org>
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 05 September 2003 06:28, insecure wrote:
> On Thursday 04 September 2003 17:57, Michael Frank wrote:
> > Concur, not worthwhile to start using a fairly unsupported tool in the
> > kernel.
> >
> > As to using assembler, It is better to get rid of it but in special
> > cases. Todays compilers are the better coders in 98+% of applications,
> > and if you
>
> Better coders? Show me the evidence.
>
> > follow some of the discussions here on the list, you will be amazed what
> > people do with a C compiler - all portable and much more maintainable.
>
> Portable yes. Maintainable yes. Better code _no_.
>
> I'd say compiler generated asm code quality can be anywhere in between of
> "hair raising crawling horror" and "not so bad although I can do better".
>
> I have never seen really clever compiler yet. Writing a good compiler
> is a very tough thing to do.

Just got another reply to this thread which helps to explain what I meant by
"better coders in 98+% of applications"

On Friday 05 September 2003 19:42, Jörn Engel wrote:
> How big is the .text of the asm and c variant?  If the text of yours
> is much bigger, you just traded 2fish performance for general
> performance.  Everything else will suffer from cache misses.  Forget
> your microbenchmark, your variant will make the machine slower.
>
> How many bugs are in your code?  Are there any buffer overflows or
> other security holes?  How can you be sure about it?  (Most people
> aren't sure about c either, but it is much easier to check.)
>
> If your code fails on any one of these questions, forget about it.  If
> it survives them, post your results and have someone else verify them.

There is another technical argument - which I am not very familiar with:
Modern and future CPU's are optimized for high level languages, it is
just too troublesome to arrange all the instructions best-case for the
hardware to be well utilized. 

Back to my original message, my implied definition of "Better coders" 
is the compromise between performance, development effort, stability 
and security (and more).

It does not just refer to the best possible "perfect" code.

Let me give you a example of "best possible code" (to the best of my ability): 

I do mostly embedded applications,  years ago did consumer design for this
kind of Hong Kong made $19.99 gimmicks ($6 FOB) priced to be purchased 
"on impulse" by joe consumer. 

For one of those gimmicks, I used a 4bit running on 1.5V with 1K 
instruction ROM and 64 nibbles RAM doing 32KIPS (32768 instructions per 
second) to establish the speed of a tennis ball it was built into. 
It required floating point calculations and display on a built-in 
LCD display with 64 segments.

This takes __clever__ __optimized__ code, and is at least a week of work, 
and affordable only in high-volume applications.

Consider, one week of work for what you can do in C using GLIBC within 
1 hour or less!

Now, please consider a real life (linux) system, which you use everyday,
of course you could make every piece of code "better" by hand coding and
optimizing, but what is the real benefit?

Assuming these millions of lines of C having been implemented in optimized
assembly, could it perform that much faster (if that is what you call 
"better"), or would you use "half" the memory for the same job? 

Now, what about it's stability and maintainability - not to mention COST,
even you could find all those great human coders?

Guess the pioneering days are over ;)

Regards
Michael





