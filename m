Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262031AbVAYRQb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262031AbVAYRQb (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 25 Jan 2005 12:16:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262029AbVAYRQb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 25 Jan 2005 12:16:31 -0500
Received: from mail.tmr.com ([216.238.38.203]:8064 "EHLO gaimboi.tmr.com")
	by vger.kernel.org with ESMTP id S262031AbVAYROs (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 25 Jan 2005 12:14:48 -0500
Message-ID: <41F6816D.1020306@tmr.com>
Date: Tue, 25 Jan 2005 12:27:09 -0500
From: Bill Davidsen <davidsen@tmr.com>
Organization: TMR Associates Inc, Schenectady NY
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7) Gecko/20040616
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Linus Torvalds <torvalds@osdl.org>
CC: Valdis.Kletnieks@vt.edu, John Richard Moser <nigelenki@comcast.net>,
       Arjan van de Ven <arjan@infradead.org>, Ingo Molnar <mingo@elte.hu>,
       Christoph Hellwig <hch@infradead.org>, Dave Jones <davej@redhat.com>,
       Andrew Morton <akpm@osdl.org>, marcelo.tosatti@cyclades.com,
       Greg KH <greg@kroah.com>, chrisw@osdl.org,
       Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: thoughts on kernel security issues
References: <1106157152.6310.171.camel@laptopd505.fenrus.org> <200501191947.j0JJlf3j024206@turing-police.cc.vt.edu> <41F6604B.4090905@tmr.com> <Pine.LNX.4.58.0501250741210.2342@ppc970.osdl.org>
In-Reply-To: <Pine.LNX.4.58.0501250741210.2342@ppc970.osdl.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds wrote:
> 
> On Tue, 25 Jan 2005, Bill Davidsen wrote:
> 
>>Unfortunately if A depends on B to work at all, you have to put A and B 
>>in as a package.
> 
> 
> No. That's totally bogus. You can put in B on its own. You do not have to 
> make A+B be one patch.

No,perhaps it isn't clear. If A changes the way a lock is used (for 
example), then all the places which were using the lock the old way have 
to use it the new way, or lockups or similar bad behaviour occur.

Did I say it more clearly? Some things, like locks, have to have all the 
players using the same rules.
> 
> 
>>There is no really good way (AFAIK) to submit a bunch of patches and
>>say "if any one of these is rejected the whole thing should be ignored."
> 
> 
> But that's done ALL THE TIME. Claiming that there is no good way is not 
> only disingenious (we call them "numbers", and they start at 1, go to 2, 
> then 3. Then there's usually a 0-patch which only contains explanations 
> of the series), but it's clearly not true, since we have patches like that 
> weekly. 

Again, I said later that it depends on the maintainer not to apply one 
part which won't work without the others. Not that it wasn't happening, 
but that there's nothing more formal than human talent. I don't regard 
that as a really good way, since it makes more work for maintainers.

I really think the original post was reasonably clear that I was 
suggesting a more formal means of designating things which should be 
accepted as a unit, not whatever you rea into it.

-- 
bill davidsen <davidsen@tmr.com>
   CTO TMR Associates, Inc
   Doing interesting things with small computers since 1979
