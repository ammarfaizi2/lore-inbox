Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262784AbVA1VJN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262784AbVA1VJN (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 28 Jan 2005 16:09:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262709AbVA1U4m
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 28 Jan 2005 15:56:42 -0500
Received: from sccrmhc12.comcast.net ([204.127.202.56]:46318 "EHLO
	sccrmhc12.comcast.net") by vger.kernel.org with ESMTP
	id S262766AbVA1Us0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 28 Jan 2005 15:48:26 -0500
Message-ID: <41FAA51E.10000@comcast.net>
Date: Fri, 28 Jan 2005 15:48:30 -0500
From: John Richard Moser <nigelenki@comcast.net>
User-Agent: Mozilla Thunderbird 1.0 (X11/20041211)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Josh Boyer <jdub@us.ibm.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: Why does the kernel need a gig of VM?
References: <41FA9B37.1020100@comcast.net> <1106944969.7542.13.camel@windu.rchland.ibm.com>
In-Reply-To: <1106944969.7542.13.camel@windu.rchland.ibm.com>
X-Enigmail-Version: 0.89.5.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Wow.

I'd heard that there was a way to set 3.5/0.5 GiB split, and that there
was a patch that removed the split and isolated the kernel (but that was
slow), so I was just curious about all this stuff with people screaming
about how tight 4G of VM is vs a half gig or a gig that can be freed up.

Josh Boyer wrote:
> On Fri, 2005-01-28 at 15:06 -0500, John Richard Moser wrote:
> 
>>-----BEGIN PGP SIGNED MESSAGE-----
>>Hash: SHA1
>>
>>Can someone give me a layout of what exactly is up there?  I got the
>>basic idea
>>
>>K 4G
>>A 3G
>>A 2G
>>A 1G
>>
>>App has 3G, kernel has 1G at the top of VM on x86 (dunno about x86_64).
>>
>>So what's the layout of that top 1G?  What's it all used for?  Is there
>>some obscene restriction of 1G of shared memory or something that gets
>>mapped up there?
>>
>>How much does it need, and why?  What, if anything, is variable and
>>likely to do more than 10 or 15 megs of variation?
> 
> 
> Because of various reasons.  Normal kernel space virtual addresses
> usually start at 0xc0000000, which is where the 3GiB userspace
> restriction comes from.  
> 
> Then there is the vmalloc virtual address space, which usually starts at
> a higher address than a normal kernel address.  Along the same lines are
> ioremap addresses, etc.
> 
> Poke around in the header files.  I bet you'll find lots of reasons.
> 
> josh
> 
> 

- --
All content of all messages exchanged herein are left in the
Public Domain, unless otherwise explicitly stated.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.0 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://enigmail.mozdev.org

iD8DBQFB+qUdhDd4aOud5P8RAmU8AJ9fRQi4A+yIVaXdv/oWlPIqObROPQCfUgvU
KAsRKxYgSTWVecLsZZCvXgE=
=v+fM
-----END PGP SIGNATURE-----
