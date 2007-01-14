Return-Path: <linux-kernel-owner+w=401wt.eu-S1751299AbXANWpE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751299AbXANWpE (ORCPT <rfc822;w@1wt.eu>);
	Sun, 14 Jan 2007 17:45:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751695AbXANWpE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 14 Jan 2007 17:45:04 -0500
Received: from einhorn.in-berlin.de ([192.109.42.8]:53219 "EHLO
	einhorn.in-berlin.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751299AbXANWpB convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 14 Jan 2007 17:45:01 -0500
X-Envelope-From: stefanr@s5r6.in-berlin.de
Date: Sun, 14 Jan 2007 23:44:45 +0100 (CET)
From: Stefan Richter <stefanr@s5r6.in-berlin.de>
Subject: Re: [RFC] How to (automatically) find the correct maintainer(s)
To: Richard Knutsson <ricknu-0@student.ltu.se>
cc: linux-kernel@vger.kernel.org
In-Reply-To: <45AAA090.6010701@student.ltu.se>
Message-ID: <tkrat.fe0c382d998fca1c@s5r6.in-berlin.de>
References: <45A9092F.7060503@student.ltu.se>
 <tkrat.428a51215926acac@s5r6.in-berlin.de> <45A93069.5080906@student.ltu.se>
 <tkrat.343d5eb8f1097532@s5r6.in-berlin.de> <45A96C3F.3090307@student.ltu.se>
 <tkrat.af9f8565dea59963@s5r6.in-berlin.de> <45AAA090.6010701@student.ltu.se>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; CHARSET=iso-8859-1
Content-Transfer-Encoding: 8BIT
Content-Disposition: INLINE
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 14 Jan, Richard Knutsson wrote:
> Stefan Richter wrote:
>> gcc -o test3.o test.c test.c
>>   
> That produces just an executable file with a misleading name :)

#-)

[...]
>> 3. When people notice that patches are misdirected too often, they will
>>    update MAINTAINERS.
>>   
> You mean they update other maintainers entries? That would be good...

Strictly spoken, only Linus updates MAINTAINERS. Everybody else merely
sends change requests which are forwarded or rejected. If newbie John
Doe finds there is something missing in MAINTAINERS, he could send a
proper patch *to the proper contacts*, et voilà. In short, people
including John Doe updated MAINTAINERS.

[...]
>> May I remind that whoever uses scripts to figure out contacts should
>> better double-check what the script found out for him.
[...]
> During development, that's a given. But I would hope that when its more 
> stable it will always find the right answer or no answer at all (if 
> there is errors in ex MAINTAINERS, even the human will bother the receiver)

Note, if people build scripts which look up contacts, I hope they don't
become careless and forget to search elsewhere for proper contacts if
_no_ contact was found automatically.

[...]
>> It is already somewhat
>> costly to backtrack .c files from .o files from config options, but
>> considerably more so with .h files.
>> 
> I think it is to early to be thinking about what is easier, first a 
> "algorithm" that does what we want is needed, then I'm more then happy 
> to write a script/program for it :)
> Costly?? It is even simple in bash:
> C_FILE=${O_FILE/'.o'/'.c'}

When I wrote "somewhat costly" I didn't refer to a 1:1 mapping between
.c and .o. That's not what it takes. I mostly referred to having to
implement a parser for parts of the Linux Makefile language. On the
bright side, the more indirection you introduce, the less people will
write their own scripts and the less scripts with bugs will be out
there. :-)

[...]
> (I: for "include". Btw, what is F: standing for? Is it instead of P:?)
[...]

Doesn't need to be F. "Files" happens to start with F.
-- 
Stefan Richter
-=====-=-=== ---= -===-
http://arcgraph.de/sr/

