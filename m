Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262040AbVAYSBh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262040AbVAYSBh (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 25 Jan 2005 13:01:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262041AbVAYSBh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 25 Jan 2005 13:01:37 -0500
Received: from sccrmhc13.comcast.net ([204.127.202.64]:16863 "EHLO
	sccrmhc13.comcast.net") by vger.kernel.org with ESMTP
	id S262040AbVAYSBc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 25 Jan 2005 13:01:32 -0500
Message-ID: <41F68975.8010405@comcast.net>
Date: Tue, 25 Jan 2005 13:01:25 -0500
From: John Richard Moser <nigelenki@comcast.net>
User-Agent: Mozilla Thunderbird 1.0 (X11/20041211)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Bill Davidsen <davidsen@tmr.com>
CC: Linus Torvalds <torvalds@osdl.org>, Valdis.Kletnieks@vt.edu,
       Arjan van de Ven <arjan@infradead.org>, Ingo Molnar <mingo@elte.hu>,
       Christoph Hellwig <hch@infradead.org>, Dave Jones <davej@redhat.com>,
       Andrew Morton <akpm@osdl.org>, marcelo.tosatti@cyclades.com,
       Greg KH <greg@kroah.com>, chrisw@osdl.org,
       Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: thoughts on kernel security issues
References: <1106157152.6310.171.camel@laptopd505.fenrus.org> <200501191947.j0JJlf3j024206@turing-police.cc.vt.edu> <41F6604B.4090905@tmr.com> <Pine.LNX.4.58.0501250741210.2342@ppc970.osdl.org> <41F6816D.1020306@tmr.com>
In-Reply-To: <41F6816D.1020306@tmr.com>
X-Enigmail-Version: 0.89.5.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1



Bill Davidsen wrote:
> Linus Torvalds wrote:
> 
>>
>> On Tue, 25 Jan 2005, Bill Davidsen wrote:
>>
>>> Unfortunately if A depends on B to work at all, you have to put A and
>>> B in as a package.
>>
>>
>>
>> No. That's totally bogus. You can put in B on its own. You do not have
>> to make A+B be one patch.
> 
> 
> No,perhaps it isn't clear. If A changes the way a lock is used (for
> example), then all the places which were using the lock the old way have
> to use it the new way, or lockups or similar bad behaviour occur.
> 

Actually, the issue I was looking at was more focused on security
patches which implement multiple security countermeasures which do
precisely dick; except that they cover eachothers' flaws so that
together they create a real solution.

It's kind of like locking your front door, or your back door.  If one is
locked and the other other is still wide open, then you might as well
not even have doors.  If you lock both, then you (finally) create a
problem for an intruder.

That is to say, patch A will apply and work without B; patch B will
apply and work without patch A; but there's no real gain from using
either without the other.

> Did I say it more clearly? Some things, like locks, have to have all the
> players using the same rules.
> 
>>
>>
>>> There is no really good way (AFAIK) to submit a bunch of patches and
>>> say "if any one of these is rejected the whole thing should be ignored."
>>
>>
>>
>> But that's done ALL THE TIME. Claiming that there is no good way is
>> not only disingenious (we call them "numbers", and they start at 1, go
>> to 2, then 3. Then there's usually a 0-patch which only contains
>> explanations of the series), but it's clearly not true, since we have
>> patches like that weekly. 
> 
> 
> Again, I said later that it depends on the maintainer not to apply one
> part which won't work without the others. Not that it wasn't happening,
> but that there's nothing more formal than human talent. I don't regard
> that as a really good way, since it makes more work for maintainers.
> 
> I really think the original post was reasonably clear that I was
> suggesting a more formal means of designating things which should be
> accepted as a unit, not whatever you rea into it.
> 

- --
All content of all messages exchanged herein are left in the
Public Domain, unless otherwise explicitly stated.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.0 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://enigmail.mozdev.org

iD8DBQFB9ol1hDd4aOud5P8RApVuAJ4jPnFcRGp7hThvmDefm6yUaDB4VACeOrqH
bSD9P/v/lyJiIZ675QJfFqY=
=EgxJ
-----END PGP SIGNATURE-----
