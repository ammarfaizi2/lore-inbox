Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264788AbTFBB4H (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 1 Jun 2003 21:56:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264789AbTFBB4H
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 1 Jun 2003 21:56:07 -0400
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:2054 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id S264788AbTFBB4E (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 1 Jun 2003 21:56:04 -0400
To: linux-kernel@vger.kernel.org
From: torvalds@transmeta.com (Linus Torvalds)
Subject: Re: Question about style when converting from K&R to ANSI C.
Date: 2 Jun 2003 02:09:17 GMT
Organization: Transmeta Corp
Message-ID: <1054519757.161606@palladium.transmeta.com>
References: <1054446976.19557.23.camel@spc> <20030601132626.GA3012@work.bitmover.com>
X-Trace: palladium.transmeta.com 1054519757 9865 127.0.0.1 (2 Jun 2003 02:09:17 GMT)
X-Complaints-To: news@transmeta.com
NNTP-Posting-Date: 2 Jun 2003 02:09:17 GMT
X-Newsreader: trn 4.0-test76 (Apr 2, 2001)
Originator: torvalds@penguin.transmeta.com (Linus Torvalds)
Cache-Post-Path: palladium.transmeta.com!unknown@penguin.transmeta.com
X-Cache: nntpcache 2.4.0b5 (see http://www.nntpcache.org/)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <20030601132626.GA3012@work.bitmover.com>,
Larry McVoy  <lm@bitmover.com> wrote:
>On Sat, May 31, 2003 at 11:56:16PM -0600, Steven Cole wrote:
>> Proposed conversion:
>> 
>> int foo(void)
>> {
>>    	/* body here */
>> }	
>
>Sometimes it is nice to be able to see function names with a 
>
>	grep '^[a-zA-Z].*(' *.c
>
>which is why I've always preferred
>
>int
>foo(void)
>{
>	/* body here */
>}	

That makes no sense.

Do you write your normal variable definitions like

	int
	a,b,c;

too? No you don't, because that would be totally idiotic.

A function declaration is no different. The type of the function is very
important to the function itself (along with the arguments), and I
personally want to see _all_ of it when I grep for functions. 

You should just do

	grep -i '^[a-z_ ]*(' *.c 

and you'll get a nice function declaration with the standard kernel
coding style.

And I personally don't normally do "grep for random function
declarations", that just sounds like a contrieved example.  I grep for
specific function names to find usage, and then it's _doubly_ important
to see that the return (and argument) types match and make sense.

So I definitely prefer all the arguments on the same line too, even if
that makes the line be closer to 100 chars than 80.  The zlib K&R->ANSI
conversion was a special case, and I'd be happy if somebody were to have
the energy to convert it all the way (which implies moving comments
around etc). 

			Linus
