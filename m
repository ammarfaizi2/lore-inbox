Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264392AbUAIUhn (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 Jan 2004 15:37:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264396AbUAIUhn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 Jan 2004 15:37:43 -0500
Received: from nwkea-mail-2.sun.com ([192.18.42.14]:52184 "EHLO
	nwkea-mail-2.sun.com") by vger.kernel.org with ESMTP
	id S264392AbUAIUhj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 Jan 2004 15:37:39 -0500
Date: Fri, 09 Jan 2004 15:37:21 -0500
From: Mike Waychison <Michael.Waychison@Sun.COM>
Subject: Re: [autofs] [RFC] Towards a Modern Autofs
In-reply-to: <3FFDC7F4.4070800@zytor.com>
To: "H. Peter Anvin" <hpa@zytor.com>
Cc: trond.myklebust@fys.uio.no, viro@parcelfarce.linux.theplanet.co.uk,
       linux-kernel@vger.kernel.org, raven@themaw.net, thockin@Sun.COM
Message-id: <3FFF1101.3090804@sun.com>
MIME-version: 1.0
Content-type: multipart/signed;
 boundary=------------enigC949D1140980B2CCB1B57D23;
 protocol="application/pgp-signature"; micalg=pgp-sha1
X-Accept-Language: en
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.5) Gecko/20031107
 Debian/1.5-3
X-Enigmail-Version: 0.82.2.0
X-Enigmail-Supports: pgp-inline, pgp-mime
References: <33128.141.211.133.197.1073590355.squirrel@webmail.uio.no>
 <3FFDB272.8030808@zytor.com>
 <33178.141.211.133.197.1073592524.squirrel@webmail.uio.no>
 <3FFDC7F4.4070800@zytor.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigC949D1140980B2CCB1B57D23
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

H. Peter Anvin wrote:

>My point is that it's what you get for having an automounter.
>
>We can't solve Sun's designed-in braindamage, unfortunately.  This is
>partially why I'd like people to consider the scope of what automounting
>does; there are tons of policy issues not all of which are going to be
>appropriate in all contexts.  To some degree, if you have to have an
>automounter you have already lost.
>  
>
However, we can solve Linux's designed-in braindamage.

>Also, your global machine credential is to some degree "all the security
>you get."  Any security which isn't enforced by the filesystem driver
>doesn't exist in a Unix environment;
>

What does this mean?   I don't understand.

> in particular there is no security
>against root.  Stupid tricks like remapping uid 0 are just that; stupid
>tricks without any real security value.  You know this, of course.
>However, if you think the automounter doesn't have the privilege to
>access the remote server but the user does, then that's false security.
>
>  
>
No, the security lies in the fact that the remote server knows the user 
is privileged to access it.  It's a side issue that the mount itself is 
made using an automounter.

>Linux at this point has no ability to support actual user-mounted
>filesystems.  There are things that could be done to remedy this, but it
>would require massive changes to every filesystem driver as well as to
>the VFS.  
>
??  As part of our research into namespaces, we at Sun have gone through 
and tried to identify the number of semantic changes required to achieve 
user-privileged mounting, however we never saw the need to do anything 
special at all in 'each filesystem driver'.  The issue is one of a 
permission model and should be out of scope for individual filesystems.

>Would it be desirable?  Absolutely.  However, it's partially
>the quagmire that got the HURD stuck for a very long time, even though
>they had the huge advantage of being able to run their filesystem
>drivers in a nonprivileged context.
>
>  
>
Other systems such as plan 9 have done it though..    If anything is 
keeping us from doing it, it's the traditional unix mount semantics and 
the security models that have been built on top of them.

-- 
Mike Waychison
Sun Microsystems, Inc.
1 (650) 352-5299 voice
1 (416) 202-8336 voice
mailto: Michael.Waychison@Sun.COM
http://www.sun.com

~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
NOTICE:  The opinions expressed in this email are held by me, 
and may not represent the views of Sun Microsystems, Inc.
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ 


--------------enigC949D1140980B2CCB1B57D23
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.2 (GNU/Linux)
Comment: Using GnuPG with Debian - http://enigmail.mozdev.org

iD8DBQE//xEDdQs4kOxk3/MRAmEMAJ9sfQmhLte+rKU1DktCjcZ05K8uBACbBJrX
FWDl/KCzl+Ls3a0JrJdOSTM=
=p7QN
-----END PGP SIGNATURE-----

--------------enigC949D1140980B2CCB1B57D23--

