Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262698AbVAQF3S@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262698AbVAQF3S (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 17 Jan 2005 00:29:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262700AbVAQF3S
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 17 Jan 2005 00:29:18 -0500
Received: from sccrmhc13.comcast.net ([204.127.202.64]:29331 "EHLO
	sccrmhc13.comcast.net") by vger.kernel.org with ESMTP
	id S262698AbVAQF3D (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 17 Jan 2005 00:29:03 -0500
Message-ID: <41EB4D20.2010207@comcast.net>
Date: Mon, 17 Jan 2005 00:29:04 -0500
From: John Richard Moser <nigelenki@comcast.net>
User-Agent: Mozilla Thunderbird 1.0 (X11/20041211)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Jeremy Fitzhardinge <jeremy@goop.org>
CC: Prasanna Meda <pmeda@akamai.com>,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: /proc/<pid>/maps API addition - seek to address
References: <1105933726.31917.50.camel@localhost>
In-Reply-To: <1105933726.31917.50.camel@localhost>
X-Enigmail-Version: 0.89.5.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1



Jeremy Fitzhardinge wrote:
> It would be terribly useful to have some way of
> lseeking /proc/<pid>/maps to the entry of a particular address.  So, if
> you want to find the information about a mapping containing address
> 0x12345678, it would set the file position to (say) the entry of
> 0x12000000-0x20000000.
> 
> I haven't looked at how /proc/<pid>/maps is implemented these days; is
> this outright hard, or relatively straightforward?  This wouldn't be
> very useful if it had to actually generate all the output up to the
> desired point, but it would be a boon if it could short-circuit that.  I
> guess the interactions with normal lseek might be tricky (but perhaps
> that could be put off until you actually use lseek, if ever).
> 

I'm fairly certain you can just return that the seek is done, and set
flags for the file descriptor, then on read() have it return the data
you want it to.


> Alternatively, any other API for finding the properties of page X would
> be useful, but this seemed like a nice incremental extension of the
> existing interface.
> 
> 	J
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 

- --
All content of all messages exchanged herein are left in the
Public Domain, unless otherwise explicitly stated.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.0 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://enigmail.mozdev.org

iD8DBQFB600dhDd4aOud5P8RAlvoAJsFi6ZUMTVhqQBWqZFkv8ubeJEyegCfYhhl
6Gy3TLn/ngSQDugT0CxOpnY=
=rR0f
-----END PGP SIGNATURE-----
