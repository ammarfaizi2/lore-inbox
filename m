Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261717AbTD0UNu (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 27 Apr 2003 16:13:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261722AbTD0UNu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 27 Apr 2003 16:13:50 -0400
Received: from smtp-out.comcast.net ([24.153.64.110]:29430 "EHLO
	smtp-out.comcast.net") by vger.kernel.org with ESMTP
	id S261717AbTD0UNr convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 27 Apr 2003 16:13:47 -0400
Date: Sun, 27 Apr 2003 16:24:34 -0400
From: rmoser <mlmoser@comcast.net>
Subject: Re: Re:  Swap Compression
In-reply-to: <20030427195731.GA5759@ime.usp.br>
To: Livio Baldini Soares <livio@ime.usp.br>
Cc: linux-kernel@vger.kernel.org
Message-id: <200304271624340940.020A1D02@smtp.comcast.net>
MIME-version: 1.0
X-Mailer: Calypso Version 3.30.00.00 (3)
Content-type: text/plain; charset=ISO-8859-1
Content-transfer-encoding: 8BIT
References: <200304251848410590.00DEC185@smtp.comcast.net>
 <20030426091747.GD23757@wohnheim.fh-wedel.de>
 <200304261148590300.00CE9372@smtp.comcast.net>
 <20030426160920.GC21015@wohnheim.fh-wedel.de>
 <200304262224040410.031419FD@smtp.comcast.net>
 <20030427090418.GB6961@wohnheim.fh-wedel.de>
 <200304271324370750.01655617@smtp.comcast.net>
 <20030427175147.GA5174@wohnheim.fh-wedel.de>
 <200304271431250990.01A281C7@smtp.comcast.net>
 <20030427190444.GC5174@wohnheim.fh-wedel.de> <20030427195731.GA5759@ime.usp.br>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

First I'd like to note that I'd not seen anything on this topic up until I
actually had said something in #C++.  I got the linuxcompressed
sourceforge site but already had my algorithm and I don't intend to
defame anyone, nor have I attempted to steal anyone's ideas.
I'm not rivaling anyone either.

... But I am starting from scratch.

*********** REPLY SEPARATOR  ***********

On 4/27/2003 at 4:57 PM Livio Baldini Soares wrote:

>Hello,
>
>  Unfortunately, I've missed the  beginning of this discussion, but it
>seems you're trying  to do almost exactly what  the "Compressed Cache"
>project set out to do:
>

Archives.. archives....

http://marc.theaimsgroup.com/?l=linux-kernel&m=105130405702475&w=2

>http://linuxcompressed.sourceforge.net/
>

Saw that.  I'm going for plain swap-on-ram tying right in to the normal
swap code.  This means that all of these extensions (compression) will
go right to the swap-on-ram driver too.  Of course, the kernel should be
smart enough to make a swap-on-ram the first choice by default, meaning
that it goes to SoR before going to disk swaps.

It's a lot less thought-out I'll grant you that, but I'm not the type to start
with someone else's code (I can never understand it).  Besides that, I'm
just working on the compression algo.

Both ways can go into the kernel, you know.  But I've got time to do this
and I'm gonna funnel whatever I can into it.

>  _Please_ take a  look at it. Rodrigo de Castro  (the author) spent a
>_lot_ of time working out the issues and corner details which a system
>like this entail. I've been also  involved in the project, even if not
>actively  coding, but  giving suggestions  and helping  out  when time
>permitted.   This   project  has  been   the  core  of   his  Master's
>dissertation, which  he has just finished writting  recently, and will
>soon defend.
>

>  It would be foolish (IMHO) to start from scratch. Take a look at the
>web site. There is a nice sketch of the degin he has chosen here:
>
>http://linuxcompressed.sourceforge.net/design/
>

Cool I know, but:

<QUOTE>
Bottom line in swap issue: (increasing) space isn't a issue,
 only performance

Discussing these issues we've come to the conclusion that
we should not aim for making swap bigger (keeping compressed
pages in it), that doesn't seem to be an issue for anyone...
Specially because disks nowadays are so low-cost compared
to RAM and CPU. We should design our cache to be tuned for
speed. 
</QUOTE>

I'm working on this for handheld devices mainly, but my aim IS size.
Speed is important, though.  I hope my algo is fast enough to give
no footprint in that sense :)

>  Scott Kaplan, a researcher  interested in compression of memory, has
>also helped a bit. This article is something definitely worth reading,
>and was one of Rodrigo's "starting point":
>
>http://www.cs.amherst.edu/~sfkaplan/papers/compressed-caching.ps.gz
>
>  (There are other relevant sources available on the web page).
>
>  Rodrigo has also written a  paper about his compressed caching which
>has much  more up-to-date information  than the web page.   His newest
>benchmarks  of  the  newest  compressed  cache  version  shows  better
>improvements then the numbers on the web page too. I'll ask him to put
>it somewhere public, if he's willing.
>
>Jörn Engel writes:
>> On Sun, 27 April 2003 14:31:25 -0400, rmoser wrote:
>
>[...]
>
>> Another thing: Did you look at the links John Bradford gave yet? It
>> doesn't hurt to try something alone first, but once you have a good
>> idea about what the problem is and how you would solve it, look for
>> existing code.
>
>  I think the compressed cache project is the one John mentioned.
>
>> Most times, someone else already had the same idea and the same
>> general solution. Good, less work. Sometimes you were stupid and the
>> existing solution is much better. Good to know. And on very rare
>> occasions, your solution is better, at least in some details.
>> 
>> Well, in this case, the sourceforge project appears to be silent since
>> half a year or so, whatever that means.
>
>  It means Rodrigo has been  busy writting his dissertation, and, most
>recently, looking  for a job :-)  I've talked to him  recently, and he
>intends to continue on with the project, as he might have some time to
>devote to it.
>
>  On a side  note, though, one thing that has  still not been explored
>is compressed  _swap_. Since the project's focus  has been performance
>gains, and it  was not clear from the  beginning that compressing swap
>actually  results  in  performance   gains,  it  still  has  not  been
>implemented. That said, this *is* on the project's to-study list. 
>

I'm going for size gains.  Performance is something I hope to not hurt,
but an increase there is alright.

>
>  Hope this helps,
>
>--  
>  Livio B. Soares
>-
>To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
>the body of a message to majordomo@vger.kernel.org
>More majordomo info at  http://vger.kernel.org/majordomo-info.html
>Please read the FAQ at  http://www.tux.org/lkml/

