Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262243AbVCJWlQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262243AbVCJWlQ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Mar 2005 17:41:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262370AbVCJWkV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Mar 2005 17:40:21 -0500
Received: from sccrmhc13.comcast.net ([204.127.202.64]:18651 "EHLO
	sccrmhc13.comcast.net") by vger.kernel.org with ESMTP
	id S263309AbVCJWc1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Mar 2005 17:32:27 -0500
Message-ID: <4230CB07.3020904@comcast.net>
Date: Thu, 10 Mar 2005 17:32:39 -0500
From: John Richard Moser <nigelenki@comcast.net>
User-Agent: Mozilla Thunderbird 1.0 (X11/20050111)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Peter Chubb <peter@chubb.wattle.id.au>
CC: linux-kernel@vger.kernel.org
Subject: Re: binary drivers and development
References: <423075B7.5080004@comcast.net>	<423082BF.6060007@comcast.net> <16944.49977.715895.8761@wombat.chubb.wattle.id.au>
In-Reply-To: <16944.49977.715895.8761@wombat.chubb.wattle.id.au>
X-Enigmail-Version: 0.90.0.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1



Peter Chubb wrote:
>>>>>>"John" == John Richard Moser <nigelenki@comcast.net> writes:
> 
> 
> 
> John> I've done more thought, here's a small list of advantages on
> John> using binary drivers, specifically considering UDI.  You can
> John> consider a different implementation for binary drivers as well,
> John> with most of the same advantages.
> 
> Almost all these advantages are also present for user-mode drivers...
> and getting drivers out of the kernel, where possible, is a much
> better approach IMHO than trying to maintain a leaky in-kernel
> interface.  The problem with in-kernel interfaces, even if set in
> concrete, is that any binary driver can go outside the interface ---
> there's no encapsulation --- and so break when the kernel changes.
> 

CPL=3 scares me; context switches are expensive.  can they have direct
hardware access?  I'm sure a security model to isolate user mode drivers
could be in place. . .

. . . huh.  Xen seems to run Linux at CPL=3 and give direct hardware
access, so I guess user mode drivers are possible *shrug*.  Linux isn't
a microkernel though.

> Peter C
> 
> 
> 

- --
All content of all messages exchanged herein are left in the
Public Domain, unless otherwise explicitly stated.

    Creative brains are a valuable, limited resource. They shouldn't be
    wasted on re-inventing the wheel when there are so many fascinating
    new problems waiting out there.
                                                 -- Eric Steven Raymond
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.5 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://enigmail.mozdev.org

iD4DBQFCMMsGhDd4aOud5P8RAjoOAJ9Owgnd5QOp9MfrQ8PzOLAt/A7k+wCYmxLc
wvXLkQX84Z2PF2J4oEIbVA==
=wi8f
-----END PGP SIGNATURE-----
