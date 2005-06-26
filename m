Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261543AbVFZFSZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261543AbVFZFSZ (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 26 Jun 2005 01:18:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261571AbVFZFSZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 26 Jun 2005 01:18:25 -0400
Received: from 69-18-3-179.lisco.net ([69.18.3.179]:23815 "EHLO
	ninja.slaphack.com") by vger.kernel.org with ESMTP id S261543AbVFZFSN
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 26 Jun 2005 01:18:13 -0400
Message-ID: <42BE3A90.1090403@slaphack.com>
Date: Sun, 26 Jun 2005 00:18:08 -0500
From: David Masover <ninja@slaphack.com>
User-Agent: Mozilla Thunderbird 1.0.2 (X11/20050325)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Lincoln Dale <ltd@cisco.com>
Cc: Hans Reiser <reiser@namesys.com>, Valdis.Kletnieks@vt.edu,
       Horst von Brand <vonbrand@inf.utfsm.cl>,
       Jeff Garzik <jgarzik@pobox.com>, Christoph Hellwig <hch@infradead.org>,
       Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       ReiserFS List <reiserfs-list@namesys.com>
Subject: Re: reiser4 plugins
References: <200506240241.j5O2f1eb005609@laptop11.inf.utfsm.cl> <42BCD93B.7030608@slaphack.com> <200506251420.j5PEKce4006891@turing-police.cc.vt.edu>            <42BDA377.6070303@slaphack.com> <200506252031.j5PKVb4Y004482@turing-police.cc.vt.edu> <42BDC422.6020401@namesys.com> <42BE3645.4070806@cisco.com>
In-Reply-To: <42BE3645.4070806@cisco.com>
X-Enigmail-Version: 0.89.6.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Lincoln Dale wrote:
> Hans Reiser wrote:
> 
>> There has been no response to the technical email asking for what
>> exactly it is that is duplicative, and what exactly it is that ought to
>> be changed in how the code works, as opposed to what file the code is
>> placed in, or who is considered its maintainer.    There has been no
>> response to the questions about whether the difference between class and
>> instance makes our layer non-duplicative.
>>
>> Perhaps no response was possible?
>>  
>>
> Hans,
> 
> the l-k community have asked YOU may times.  any lack of response isn't
> because of the kernel cabal .. its because YOU are refusing to entertain
> any notion that what Reiser4 has implemented is unpalatable to the
> kernel community.
> 
> you can threaten all you want to take your code and move it to BSD.  or
> fork the kernel.  whatever.
> but if you want to get your work into the mainline kernel, you need to
> provide answers to the question that keeps being asked of you - and
> which you patently keep ignoring time & time again.
> 
> in short,  as per Message-ID: <42BBC710.8010906@cisco.com>:
>    posting to l-k on "why Reiser4 cannot use VFS infrastructure for
>    [crypto,compression,blahblah] plugins" - ideally, for each plugin.
> 
> or again, in Message-ID: <42BBB1FA.7070400@cisco.com>:
>    [..] but instead just understand that this is the framework that you
> have to
>    work in to get it into the mainline kernel.
>    if you don't want to go down that path, you're free to do so.
>    its open source, you can keep your own linux-kernel fork.
>    but if you want to get your code into mainline, i don't think its
>    so much a case of l-k folks telling you how to make your code
>    work under VFS.  the onus is on you to say WHY your code
>    and plugins could never be put into VFS.
> 
> or further back in Message-ID: <42BB7083.2070107@cisco.com>
>    you know that VFS is the mechanism in Linux.  you know
>    (i hope..) how it works.  it isn't so hard to see how many
>    of the Reiser4 "plug-ins" could be tied into VFS calls.
>    OR, if they cannot TODAY, propose how VFS _COULD_ be
>    made to do this.
> 
> 
> NB. it doesn't matter what David thinks.  this is linux-kernel, not
> linux-users.

Gee, thanks.  Great attitude.  I'm sure your users love you.
By the way, Groklaw is run by a user.

Ok, I'll bite.  Hans put it best a moment ago:
"Because our code is 90% library routines (aka plugins), eliminating the
plugin layer is like eliminating main() in a user space program."

We want to get a feeling of exactly which plugins you are talking about.
 Because if we pick the wrong ones and spend a few weeks implementing
them, and come back and you think we're still too "layered" or maybe
we've "bloated" VFS too much, and maybe the cycle repeats for another
two years...

What Hans seems to be worried about is having food and rent for two
years, and the fact that in those two years, the XFS guys or the ext3
guys may duplicate enough of the "plugin" architecture that he gets no
credit anymore, AND has to rewrite his stuff to work with theirs.

I have to be neutral on that, as I realize that many of the linux-kernel
people are sick of hearing it and honestly don't care.  And to tell the
truth, I'm a little sick of hearing it, and more than a little sick of
the personal attacks from both sides.

No, as a user, I just want a working plugin architecture to play with
(I'm not *just* a user), and a working Reiser4 'cause it's fast, and I
am eager to see new improvements coming out of Namesys, instead of two
years spent trying to keep up with the vanilla kernel *and* adapt to
some unspecified, possibly unneccessary, decree of a benevolent dictator.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://enigmail.mozdev.org

iQIVAwUBQr46kHgHNmZLgCUhAQKA+g//U9RiQpbaRQTBcYT4WCh+SPKJGheZCQ/S
1Xz1gI/M0phGVjfuLenpbz7CpIdfuZE670xccMXaqlYauW3D8NAkZopwLQQtuX9v
MlctbWDX86Xbq0Ng3Zi6UPgKrY3kuWLP+NIjyq0geu5rnXFCgZLn2qOpZzWn1Uyf
O0PNwKloBFoGeFcCs2F3HmzQ4sw2pVL645UxyatCmB/omNZIFTChkyMR4A7Ybvfc
nUDtH9AMqJ/EROb3LkCQIK79I4yoDJraD64glkp/iIuADUCioVlAbyzTHuGIbFYY
U3QqdOFSoCXJHC8PVSXCN1LBv4YWS2EWsYYiPiKisCHtRQi5jpZEgFdcAGbmiNaA
PNIP6zfcAC8bxJ9aeH9LK+QbfzBU9LFjDIfn4TgrZdkDp+q6rHaS4EO3KWaVubn/
YDbDRd+QCDLgnzjNvQZdTXHrtotFXk+xWkKfN5e4fP5Z56EWXY1SUkv+oRC3vdJI
yE0D+a8qg0XJKuFsEzhOa4Pxhu27eRCVPQ4b+s3ivmJmep3Og6v4MaG/SLTeCGMX
ESHRpYUZfG81mwpI5GmkIm8E6dnZp6YmaQx9ZI9+J1B6mJ/1payL78TBIckq79Tx
mKudpapkH3cZ93Br54f5C+pY/XjaHhepYZbkytl0BNb75R4T3r93s81M2q5N3ghN
3+ruvJY2Kto=
=Skae
-----END PGP SIGNATURE-----
