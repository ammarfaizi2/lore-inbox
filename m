Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261404AbVAMTnR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261404AbVAMTnR (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 13 Jan 2005 14:43:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261443AbVAMTki
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 13 Jan 2005 14:40:38 -0500
Received: from sccrmhc12.comcast.net ([204.127.202.56]:52973 "EHLO
	sccrmhc12.comcast.net") by vger.kernel.org with ESMTP
	id S261402AbVAMTf2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 13 Jan 2005 14:35:28 -0500
Message-ID: <41E6CD92.9030508@comcast.net>
Date: Thu, 13 Jan 2005 14:35:46 -0500
From: John Richard Moser <nigelenki@comcast.net>
User-Agent: Mozilla Thunderbird 1.0 (X11/20041211)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Norbert van Nobelen <norbert-kernel@edusupport.nl>
CC: linux-kernel@vger.kernel.org
Subject: Re: thoughts on kernel security issues
References: <Pine.LNX.4.58.0501121002200.2310@ppc970.osdl.org> <Pine.LNX.4.58.0501130926260.2310@ppc970.osdl.org> <41E6C507.5050302@comcast.net> <200501132022.03472.norbert-kernel@edusupport.nl>
In-Reply-To: <200501132022.03472.norbert-kernel@edusupport.nl>
X-Enigmail-Version: 0.89.5.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1



Norbert van Nobelen wrote:
> On Thursday 13 January 2005 19:59, you wrote:
> 

[...]

>>You can't guarantee you can guess a password.  You could for example
>>write a pam module that mandates a 3 second delay on failed
>>authentication for a user (it does it for the console currently; use 3
>>separate consoles and you can do the attack 3 times faster).  Now you
>>have to guess the password with one try every 3 seconds.
> 
> 
> Already done, actually standard practice. This does not mean actually that you 
> can not guess a password, just that it will take longer (on average).
> Luck and some knowledge about the system and people speeds up the process, so 
> the standard procedure if you really want to get into a system with a 
> password is to get information.
> 
> 

I'm pretty sure that you only get a 3 second delay on the specific
console.  I've mistyped my root password on tty1, and switched to tty2
to log in before the delay was up.

as a test, switch to vc/0 and enter 'root', then press enter.  Type a
bogus password.

Switch to vc/1, and enter 'root', then press enter.  Type your real root
password.

Go back to vc/0 and hit enter so you submit your false password, then
immediately switch to vc/1 and hit enter.

You should get a bash shell and have enough time to switch to vc/0 and
see it still waiting for a second or two, before returning "login
incorrect."

Automating an attack on about 10 different ssh connections shouldn't be
a problem.  Just keep creating them.

> 
>>aA1# 96 possible values per character, 8 characters.  7.2139x10^15
>>combinations.  It takes 686253404.7 years to go through all those at one
>>every 3 seconds.  You've got a good chance at half that.
>>
>>This isn't "hard," it's "infeasible."  I think the idea is to make it so
>>an attacker doesn't have to put lavish amounts of work into creating an
>>exploit that reliably re-exploits a hole over and over again; but to
>>make it so he can't make an exploit that actually works, unless it works
>>only by rediculously remote chance.
>>
>>
>>>So all security issues are about balancing cost vs gain. I'm convinced
>>>that the gain from openness is higher than the cost. Others will
>>>disagree.
>>
>>Yes.  Nobody code audits your binaries.  You need source code to do
>>source code auditing.  :)
>>
>>
>>>		Linus
>>>-
>>>To unsubscribe from this list: send the line "unsubscribe linux-kernel"
>>>in the body of a message to majordomo@vger.kernel.org
>>>More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>>Please read the FAQ at  http://www.tux.org/lkml/
> 
> 

- --
All content of all messages exchanged herein are left in the
Public Domain, unless otherwise explicitly stated.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.0 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://enigmail.mozdev.org

iD8DBQFB5s2QhDd4aOud5P8RAlwhAJ9G8SWcxq1HFCM58VIeEWJPevg9qgCeMpxt
MHGB3N3TMy5n8MWnkUctqhM=
=3mYn
-----END PGP SIGNATURE-----
