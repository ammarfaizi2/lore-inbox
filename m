Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261488AbTCJVn2>; Mon, 10 Mar 2003 16:43:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261489AbTCJVn2>; Mon, 10 Mar 2003 16:43:28 -0500
Received: from ns.splentec.com ([209.47.35.194]:40455 "EHLO pepsi.splentec.com")
	by vger.kernel.org with ESMTP id <S261488AbTCJVn1>;
	Mon, 10 Mar 2003 16:43:27 -0500
Message-ID: <3E6D096A.1080006@splentec.com>
Date: Mon, 10 Mar 2003 16:53:46 -0500
From: Luben Tuikov <luben@splentec.com>
Organization: Splentec Ltd.
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.1) Gecko/20020826
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: root@chaos.analogic.com
CC: LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] coding style addendum
References: <Pine.LNX.3.95.1030310162308.14367A-100000@chaos>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Richard B. Johnson wrote:
> On Mon, 10 Mar 2003, Luben Tuikov wrote:
> 
> 
>>Someone may find this helpful and descriptive of how kernel code
>>should be developed.
> 
> [SNIPPED...]
> 
> 
>>+      Make sure every module/subroutine hides something.
> 
> 
> This is not correct. Well known example:
> 
> #include <math.h>
> 
> double hypot(double x, double y) {
>     return sqrt((x * x) + (y * y));
> }
> 
> This subroutine hides nothing. It receives input parameters

It does hide something.  It hides *the implementation* of
the function hypot().

In effect, elsewhere in your code you could have the explicit
	... = sqrt((x * x) + (y * y));
or,
	... = hypot(x, y);

It's just eliminating (code) redundancy and duplication.

I.e. this addendum was meant on a more abstract/logical ground, thus the
name of the chapter.

[cut]
> locally stored and therefore not hidden. Your rule would require
> the replication of three floating-point variables NotGood(tm).

This isn't really my rule.  I didn't invent or came up with anything
new here.

Documentation/CodingStyle is remarkably similar to most of what
you'd find in [1], and those rules are more or less from that
same book.

Actually, the whole point of my posting the patch is the last rule,
since well thought out data representation makes or breaks the code.

References:
[1] ``The Elements of Programming Style'' by Kernighan
and Plauger, 2nd ed, 1988, McGraw-Hill.

-- 
Luben


