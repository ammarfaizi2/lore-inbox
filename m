Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263307AbVFYDQs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263307AbVFYDQs (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 24 Jun 2005 23:16:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263309AbVFYDQr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 24 Jun 2005 23:16:47 -0400
Received: from 69-18-3-179.lisco.net ([69.18.3.179]:44552 "EHLO
	ninja.slaphack.com") by vger.kernel.org with ESMTP id S263307AbVFYDPD
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 24 Jun 2005 23:15:03 -0400
Message-ID: <42BCCC32.1090802@slaphack.com>
Date: Fri, 24 Jun 2005 22:14:58 -0500
From: David Masover <ninja@slaphack.com>
User-Agent: Mozilla Thunderbird 1.0.2 (X11/20050325)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Horst von Brand <vonbrand@inf.utfsm.cl>, Hans Reiser <reiser@namesys.com>,
       Jeff Garzik <jgarzik@pobox.com>, Christoph Hellwig <hch@infradead.org>,
       Andrew Morton <akpm@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       ReiserFS List <reiserfs-list@namesys.com>
Subject: Re: reiser4 plugins
References: <200506231924.j5NJOvLA031008@laptop11.inf.utfsm.cl>	 <42BB31E9.50805@slaphack.com>	 <1119570225.18655.75.camel@localhost.localdomain>	 <42BB7B32.4010100@slaphack.com> <1119612849.17063.105.camel@localhost.localdomain>
In-Reply-To: <1119612849.17063.105.camel@localhost.localdomain>
X-Enigmail-Version: 0.89.6.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Alan Cox wrote:
> On Gwe, 2005-06-24 at 04:17, David Masover wrote:
> 
>>>False argument. So does the pen, so do hinges on doors. Do you still
>>>have hinges on your doors - probably.
>>
>>Indeed.  Because there's nothing better -- not because I "like it the
>>way it is".
> 
> 
> I chose hinges carefully - there are better technologies than the
> generic hinge and there have been for many many years (plus cool stuff
> like magnetic doors). You of course aren't a door geek (nor am I I'd
> point out) but a computing one...

Right, but even if I was a door geek, changing hinges costs more than
changing code.  Now, if I were building a new house and I happened to
know about other alternatives, I might not still be using hinges.  Also,
I leave enough doors open enough of the time that it's not a serious
impact on my life.

Now, OS design is a place which does affect my productivity, so I do
care about the design, and while it's hard to change that design, it
doesn't actually involve buying stuff.

>>I think Hans (or someone) decided that when hardware stops working, it's
>>not the job of the FS to compensate, it's the job of lower layers, or
>>better, the job of the admin to replace the disk and restore from backups.
> 
> 
> Most desktop users today don't have backups because there is no credible
> backup technology for 500Gb of data. They may have partial backups. Some

Bandwidth is getting faster.  And I just found a nice site for backups
called streamload.com.  They don't seem to support rsync, and allow only
100 meg downloads, but unlimited uploads.

Few desktop users today really need to backup more than 50 megs of data.

> things the fs can't deal with - if the disk goes boom then thats a lower
> level concern. Also certain bits like writing to spare blocks on a
> problem write are indeed handled drive level nowdays.

Right.  And putting them in the FS is unneccesary bloat if you've got
another mechanism for dealing with it.  Anyone with 500 gigs of data can
afford to do a little RAID, or at least some burned DVDs.

DVDs are cheap nowdays:
http://www.newegg.com/Product/Product.asp?Item=N82E16817502002

Ok, you might need two of those.  Still, it's not much, unless that's
500 gigs of data which is actually changing pretty rapidly.  Most users
I know seem to burn CDs or DVDs of static things (like music) and only
keep games and office-type files, plus copies of the stuff they've
burned, on their hard drives.  So, backup for most people I know = not
throwing away game install disks + cron job to send < 50 megs of data to
Streamload.

I agree it's nice to have a more corruption-proof filesystem.
Convenient.  But not absolutely necessary.

>>the issues are fixed, an entirely different crowd of benevolent
>>dictators will come around and say that we can't get in because we
>>change the VFS.  At least some people on this list have said things to
>>that effect.
> 
> 
> There are four important issues I see here
> 
> 1. It must work
> 2. It must be clean code that follows the kernel style
> 3. It must not break other stuff
> 4. It needs a maintainer who won't get bored 12 months later and only
> support reiser5
> 
> #3 is the VFS stuff and getting the VFS locking wrong or unclean is a
> *very* big deal because you'll cause corruption to non reiser4 users.

It's #2 and #3 that I'm worried about.  #4 is a little unfair, and I can
verify that #1 is satisfied.

And, by "worried about", I mean I'm worried about the attitude of other
people.  As far as I'm concerned, Reiser4 is mergeable now.  But I'm not
exactly an authority.
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://enigmail.mozdev.org

iQIVAwUBQrzMMXgHNmZLgCUhAQLqMQ/+LeGfZlmMt8pog6StIbWj3ZtfSXXnOAtu
Os6jMMITPL7QlGfD8ren6nExtS/zxAfua6eQmoc9Lk4qPSFGJsSj8s3APE6p+igr
YLHSD6yKMW+sEwz+9d/jLI22R+Ct6x2AUGeYKbmJ4GnYYSeDMsJieeG/OJJscQFG
ETjSDWYQM8Ba7YgiJBWfJFYfD9LuM2wE1yUY5zmqVlT1hKSEB6rKEpx+J4MpAj6H
u19DCDoluVqTI/4XIFDjpHkwsNfYElCDe6dbdtgeHlDIjcgX8PRu2ZEVAhDjwG3H
wlLc1V6lE/qznf4kUgWg3XAc6P2MbJAJd6S7xg5ifSaEzYE7sYwPrXAaPOh+BpNV
P01T5eqsSoIbDQb1q1w686EVdQKXSXms2W21IFctHi60FBwfBIfLNwJ8I590MIhG
SkhBj/LAnZrFDztf8Z16oBy0zNrVKLQBGkd3FlD8YDv8J7II266yv+aOVEvNp0Sw
5g8RnlxnUqnl1JCo7TRHLe3pknPXms9JISd/wHvjIPuxgOBSVw0nPDde+T/mdlOP
28ef3MDEDwc2cBe3xPLj1nXYjrLvw6zGrSR22IRYDrdZgqPtKjrUEj+0T6pmmHW/
NAH8Ck9zROvadnaB9/st4JJT74axRtwI1HFb4SMfo23vQ6za7RNIHKjDMVsAjtqV
fmgsvO2QUo8=
=MlUY
-----END PGP SIGNATURE-----
