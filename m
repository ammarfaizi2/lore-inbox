Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261467AbVFZCqk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261467AbVFZCqk (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 25 Jun 2005 22:46:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261804AbVFZCqk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 25 Jun 2005 22:46:40 -0400
Received: from 69-18-3-179.lisco.net ([69.18.3.179]:48391 "EHLO
	ninja.slaphack.com") by vger.kernel.org with ESMTP id S261467AbVFZCq2
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 25 Jun 2005 22:46:28 -0400
Message-ID: <42BE1702.4000106@slaphack.com>
Date: Sat, 25 Jun 2005 21:46:26 -0500
From: David Masover <ninja@slaphack.com>
User-Agent: Mozilla Thunderbird 1.0.2 (X11/20050325)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Hubert Chan <hubert@uhoreg.ca>
Cc: Valdis.Kletnieks@vt.edu, Horst von Brand <vonbrand@inf.utfsm.cl>,
       Hans Reiser <reiser@namesys.com>, Jeff Garzik <jgarzik@pobox.com>,
       Christoph Hellwig <hch@infradead.org>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org, ReiserFS List <reiserfs-list@namesys.com>
Subject: Re: reiser4 plugins
References: <200506240241.j5O2f1eb005609@laptop11.inf.utfsm.cl>	<42BCD93B.7030608@slaphack.com>	<200506251420.j5PEKce4006891@turing-police.cc.vt.edu>	<42BDA377.6070303@slaphack.com>	<200506252031.j5PKVb4Y004482@turing-police.cc.vt.edu> <87fyv6ezhi.fsf@evinrude.uhoreg.ca>
In-Reply-To: <87fyv6ezhi.fsf@evinrude.uhoreg.ca>
X-Enigmail-Version: 0.89.6.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Hubert Chan wrote:
> On Sat, 25 Jun 2005 16:31:37 -0400, Valdis.Kletnieks@vt.edu said:
> 
> [...]
> 
> 
>>Meanwhile, PGP was designed to be used in an environment where you
>>could do this: "Today's secret plans are AES256 encrypted.  The key is
>>the next key in your one-time-pad book, XOR'ed with your 128-bit
>>secret key - do it in your head".  (And yes, you can easily memorize a
>>16-digit hex number and learn to do an XOR with another 16-digit
>>number, if failing to do so means you could end up dead).

[...]

> [1] I have no idea what kind of interface the crypto plugin in Reiser4
> will have.  I'm assuming that there will be some commands for adding and
> removing keys from the plugin.  If such commands don't exist, then we
> have a seriously broken system.

If we do meta-files as was originally intended, the command will be a
shell script could look something like this:

#!/bin/bash
read -sp 'passphrase: ' key
echo "$key" > "$0"/.../plugins/cryptocompress/key

The syntax of that echo command may change, but this is what we like
about metas -- less namespace fragmentation, less random interfaces.

>>Two words: "phishing e-mail".

[...]

> I'd rather have people encrypting all their stuff and still be
> vulnerable to phishing but secure from someone stealing their computer
> and fetching all their personal data, than having people not encrypt
> their stuff and have all their personal data harvested when they lose
> their computers and still be vulnerable to phishing.

Thank you, I was just about to say that.

There's a quote about this.  Someone once asked Mohammed, "Should we tie
up the horses or trust in Allah?"  Mohammed said, "Trust in Allah.
...But, tie up the horses."

> P.S.  Is the custom on the linux-kernel list really to Cc: everyone and
> their dog?  I'm seeing a lot of long Cc: lists here...

It seems to be the custom of any list to just hit "reply-to-all".  That
way, even if someone posted a reply after reading the archives or from a
forwarded mail, or even if they unsubscribe from the list, or even if
someone simply opened up their client and started a thread by mailing
linux-kernel@vger.kernel.org directly, or if someone just randomly adds
someone who might be interested to the CC list directly -- no matter
what, someone who's posted on a topic will see replies to that post
until the topic dies.

Of course, this isn't true of all lists.  Some lists munge headers,
meaning that either "reply" or "reply-to-all" goes to the same place,
meaning no automatic CC's.  I don't like that, because then it's harder
to take something off-list, and easier to accidently send something
supposedly private to the entire list.

If you take something off-list when you don't mean to, you can just
re-send it, but if you put something on-list when it was supposed to be
private, there isn't much you can do...

Of course, there's the annoying side-effect that if you are subscribed
to the list, you'll get lots of dupes, but so what?  Bandwidth is cheap.
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://enigmail.mozdev.org

iQIVAwUBQr4XAngHNmZLgCUhAQK+JRAAgg4YlZ9cb0S5hp9JzGdZHm0FeJDoKIok
voT5LvqgooQpJZk3mwyagYqvP5uvY2UgFA74seMqzTHRnynCDp4orCPGgADofaFU
KfjGcVUS6SuY3VgeF7WBEjFj1NHSwDp3h0LfeRocEglbFxoPGJvw3gWSnX1QDZ68
nmuSRGVSB7nb1Os6c2zsM0uXvJA43HNJ+W/UrEPOFjiRI1bOOioxzphgVwCAQH3j
8Vb2/HWmPLTCqXoOYESZ5OBQOR6iZViegh/x/Rn+O99UfiENdacoX5xwGM68SAXM
CR3JjRA3JEA1iScz9I2byD2dZyb2596Q09Xh/5/5PQxK8zGm0FtWWEbOvDeF7Re7
cQiXkZB9uLQDJel+jlwatKGCPRVlx9wDJ8puIMf47QOsWhx0TY8lAxCebu4zorjz
K2vQiF/ZMOYXFB5nBCvgHL7XG24FRpuaU0wWo7+0cY2o4WBhvfBO5o+93Klwa7Na
ltPKRFPv6B6KBDD71quSwZ9M1YkjfR0vaPZWV9T5TFBklfRv26N1DhNmW1o2KjRI
wX3yrsIbAAG9dK3Vs71oxWIw0hqmfpo4UZTZGRoi8GL+drHBNvHxzNtaeSBF4AeO
fxYnQHXO1+Us3zbb/oBR4Hm3ugvsRYXMyArm1hHHFlmcXdggjz+K36IiCK7wKpfp
2gVec7JaEkY=
=3Mkk
-----END PGP SIGNATURE-----
