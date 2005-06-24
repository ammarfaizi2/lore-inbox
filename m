Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263054AbVFXDV5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263054AbVFXDV5 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Jun 2005 23:21:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263027AbVFXDSi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Jun 2005 23:18:38 -0400
Received: from 69-18-3-179.lisco.net ([69.18.3.179]:2567 "EHLO
	ninja.slaphack.com") by vger.kernel.org with ESMTP id S263024AbVFXDRO
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Jun 2005 23:17:14 -0400
Message-ID: <42BB7B32.4010100@slaphack.com>
Date: Thu, 23 Jun 2005 22:17:06 -0500
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
References: <200506231924.j5NJOvLA031008@laptop11.inf.utfsm.cl>	 <42BB31E9.50805@slaphack.com> <1119570225.18655.75.camel@localhost.localdomain>
In-Reply-To: <1119570225.18655.75.camel@localhost.localdomain>
X-Enigmail-Version: 0.89.6.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Alan Cox wrote:
> On Iau, 2005-06-23 at 23:04, David Masover wrote:
> 
>>>What for? It works just fine as it stands, AFAICS.
>>
>>So does DOS.  Do you use DOS?  I don't even use DOS to run DOS programs.
> 
> 
> False argument. So does the pen, so do hinges on doors. Do you still
> have hinges on your doors - probably.

Indeed.  Because there's nothing better -- not because I "like it the
way it is".

>>"Ain't broke" is the battle cry of stagnation.
> 
> 
> Its also the battle cry of everyone over the age of 20 who also has a
> real job to do 8)

You caught me.  I'm not over 20.  But I have a real job, with a company
that understands the difference between "ain't broke" and "works well".

>>But, there are some things Reiser does better and faster than ext3, even
>>if you don't count file-as-directory and other toys.  There's nothing
>>ext3 does better than Reiser, unless you count the compatibility with
>>random bootloaders and low-level tools.
> 
> 
> Certainly compared with reiser3 you've missed a few out including
> resilience to disk errors (nearly nil on reiser3), and SMP scaling.

Actually, I was talking about reiser4.  And Hans corrected me on that...

Although resilience to disk errors isn't a design decision.  That's what
SMART and new hard drives are for.  And if you're stubborn enough to
keep the same FS around, there's dm-bbr.

I think Hans (or someone) decided that when hardware stops working, it's
not the job of the FS to compensate, it's the job of lower layers, or
better, the job of the admin to replace the disk and restore from backups.

>>You know how many I've had thrashed on Reiser4?  Two.  The first one was
>>with a VERY early alpha/beta, and the second one was when I dropped a
>>laptop and the disk failed.
> 
> 
> Entirely or bad blocks ? The latter should have a minimal cost on a well
> designed fs.

I was able to recover from bad blocks, though of course no Reiser that I
know of has had bad block relocation built in...  But I got all my files
off of it, fortunately.

But the disk did fail, completely, later.  Lots of loud clicking.

>>Duplication of effort.  With plugins, we can optimize the upper layers
>>of ALL filesystems, regardless of the lower layers, in such a way that
> 
> 
> In which case the features belong in the VFS as all those with
> experience and kernel contributions have been arguing.

No one's arguing that.  What we're arguing is that there does seem to be
a bit of prejudice when fuck-me-with-a-chainsaw and YOU ARE A FOOL FOR
ENABLING THIS all got in, and with at least one of those, there doesn't
seem to be any intention of changing it -- all of that, and even with an
expressed intention to fix the aesthetical problems with Reiser4 later,
we can't get the working version in now.

More infuriatingly, I, at least, have a distinct feeling that once all
the issues are fixed, an entirely different crowd of benevolent
dictators will come around and say that we can't get in because we
change the VFS.  At least some people on this list have said things to
that effect.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://enigmail.mozdev.org

iQIVAwUBQrt7MngHNmZLgCUhAQKdXA/+PDpOzZYTVXgF2n4qiFyrmjFeQ6h0n8i6
c/hXx+QUU0Hw5mjq31+jf2vNpDCKQxcE/HTLdJlRfw8az+xklVOfxzEHf9yV41tv
mVKMRJYBhzk2mEvKEDNtnw47SQPBAKo9BtJvl7gOEofiPK/f2K/cy8yMUrow1E9D
02PNT0XX8ysoe86Dqip35+sphczkQN8gilXyUQujNe8edEdkW7PBhbJn92zBQag2
JxA194bquxRyhW78T3tKAEN6/tTPgZYJNy202KC619zzLlK3TslwjjfOQILdRb2i
NNkaSQBdYDK70BiFs5Ri7ZbfJHenY6mgGv7yG0vjGF6zjoXtVNsKGrYt9KBL6E1D
392ayxOlWCvBoG9n9sAUzHzcQxmU1lP6OHcO9xWrL6ySD7Fzv4rCtM0uo7gXOzNB
aDl5vK7q+ysEjOXZJWT0ikj5ndATCv0Ry8wnt1uL/uktOuaE0egwsouU0jgCDgx1
8Ib8KX/B6bhCy13WkYLPTb6Yg0k+ph0BUyONEcN5cxJIcqfcEt/4Un4MYM+CjGck
KLYrrZDclZr8p/paWdNqx1dI9NIBn+F3u78OcWY3NIGfZPh1jmSdG3LRt9DZo5bZ
ua2UlAiAWnEDHNLQyMH2zcji31DMqIUwmQ5bX9isBcxt8LORX+IKxoLdUICoY8JS
Ii5kNWJAjf4=
=Xsdv
-----END PGP SIGNATURE-----
