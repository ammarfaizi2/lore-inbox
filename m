Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261384AbVARSie@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261384AbVARSie (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 18 Jan 2005 13:38:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261380AbVARSie
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 18 Jan 2005 13:38:34 -0500
Received: from no.rev.vr.org ([65.19.163.244]:28577 "EHLO mail0.rayservers.com")
	by vger.kernel.org with ESMTP id S261384AbVARSiJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 18 Jan 2005 13:38:09 -0500
Message-ID: <41ED57BB.7080504@rayservers.com>
Date: Tue, 18 Jan 2005 13:38:51 -0500
From: Venkat Manakkal <venkat@rayservers.com>
User-Agent: Mozilla Thunderbird 1.0 (X11/20041224)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andries Brouwer <aebr@win.tue.nl>
CC: Jari Ruusu <jariruusu@users.sourceforge.net>,
       Fruhwirth Clemens <clemens@endorphin.org>,
       Paul Walker <paul@black-sun.demon.co.uk>, linux-kernel@vger.kernel.org,
       Bill Davidsen <davidsen@tmr.com>, linux-crypto@nl.linux.org,
       James Morris <jmorris@redhat.com>
Subject: Re: Announce loop-AES-v3.0b file/swap crypto package
References: <41EAE36F.35354DDF@users.sourceforge.net> <41EB3E7E.7070100@tmr.com> <41EBD4D4.882B94D@users.sourceforge.net> <1105989298.14565.36.camel@ghanima> <20050117192946.GT7782@black-sun.demon.co.uk> <1105995889.14565.47.camel@ghanima> <41ED2CD4.B0502FD7@users.sourceforge.net> <20050118172322.GH8747@pclin040.win.tue.nl>
In-Reply-To: <20050118172322.GH8747@pclin040.win.tue.nl>
X-Enigmail-Version: 0.89.6.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Hi Andries et all,

As a loop-aes *user* and ex-cryptoloop user, I can tell you one thing - it
works, and is stable over multiple kernels, and backwards compatibility is
maintained as it evolves.

As for cryptoloop, I'm sorry, I cannot say the same. The password hashing
system being changed in the past year, poor stability and machine lockups are
what I have noticed, besides there is nothing like the readme here:

loop-aes.sourceforge.net/loop-AES.README

Regarding the "backdoor", perhaps it is a poor choice of words, but clearly
exposing yourself to the watermark attack on large volumes is unnecessary and
unwarranted. How would I, a security person, explain to my customer why I did
not choose the better crypto?

Andries Brouwer wrote:
| On Tue, Jan 18, 2005 at 05:35:48PM +0200, Jari Ruusu wrote:
|
|>Fruhwirth Clemens wrote:
|>
|>>Nothing about kernel crypto is backdoored. If Ruusu thinks different, he
|>>should show me source code. Till then, treat it as FUD.
|>
|>I have been submitting fix for this weakness to mainline mount (part of
|>util-linux package) since 2001, about 2 or 3 times a year. Refusing to fix
|>it for *years* counts as intentional backdoor.
|>
|>You call it whatever you want. I call it backdoor.
|
|
| Hi Jari,
|
| Your crypto is good, your language is bad.
|
| Clearly there is no intentional backdoor.
| You do not gain any credibility by saying otherwise.
|
| Next, confusing the kernel with util-linux is a strange trick.

I do not see the confusion. Read the loop-AES readme.

|
| Finally, in the time I maintained util-linux I have asked you
| I don't know how often to come with a series of small clean
| patches instead of a huge ugly all-or-nothing monolithic patch.
| But you didnt.
|
| Maybe you don't understand, but it does not suffice when code
| is correct - it must also be maintainable.

It seems to have been maintained far better than cryptoloop, and is superior as
far as I can tell by using it.

|
| Something rather similar is true for the kernel, I suspect.
| A series of short clean patches would have solved all problems.

Every tried Jari's loop-AES module? For something maintained outside of
mainline, the modules compile and run perfectly across a range of kernels.

|
| As it is, time may be running out - some years ago your stuff
| was far superior to everything else. But alternative
| approaches are being developed, and maybe loop-aes will soon
| be some historic oddity.

Perhaps if you implement something like FreeBSD gbde.

http://www.freebsd.org/cgi/man.cgi?query=gbde&sektion=4

Until then I (and I am sure many others) will choose loop-AES because of its
clean set of instructions, strong multi-key crypto, on the fly multi key swap
or volume (/tmp for instance), easy instructions for GPG backed encrypted root
with key on USB dongle. Did I forget to mention tireless support by the author
of loop-AES?

I don't care to start a flame war, or to even participate in this one or the
politics of kernel code (I've gathered from the archives and elsewhere that the
author of loop-AES has tried repeatedly in the past to get his code in the
kernel), or to offend any kernel gods, but single key crypto for large volumes
is out of the question. Sorry.

Best regards,

- ---Venkat.

- -------------------------------------------------------------------------
Venkat Manakkal           Tel:+1-607-546-7300       Fax: 1-607-546-7387
venkat@rayservers.com     http://www.rayservers.com/
rayservers@hushmail.com   Computers. Installed Secure. Wholesale Prices.

PGP/GPG Key: https://www.rayservers.com/keys/0x12430522.asc
Get Windows Privacy Tools for free: http://winpt.sf.net/
- -------------------------------------------------------------------------
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.6 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://enigmail.mozdev.org

iD8DBQFB7Ve6WdkW/RJDBSIRAtTXAJ9QHuLqs3o+RHXTezu9X8+ArYcKowCg1ANW
shO6GFnAQq7kQprQU12+BKE=
=x8bp
-----END PGP SIGNATURE-----
