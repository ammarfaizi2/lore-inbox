Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264992AbSL0Qn3>; Fri, 27 Dec 2002 11:43:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265002AbSL0Qn3>; Fri, 27 Dec 2002 11:43:29 -0500
Received: from 60.54.252.64.snet.net ([64.252.54.60]:36691 "EHLO
	mail.blue-labs.org") by vger.kernel.org with ESMTP
	id <S264992AbSL0Qn1>; Fri, 27 Dec 2002 11:43:27 -0500
Message-ID: <3E0C84FC.1020100@blue-labs.org>
Date: Fri, 27 Dec 2002 11:51:08 -0500
From: David Ford <david+cert@blue-labs.org>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.3b) Gecko/20021226
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Florin Iucha <florin@iucha.net>, linux-kernel@vger.kernel.org
CC: Trond Myklebust <trond.myklebust@fys.uio.no>
Subject: Re: NFS problems with 2.5.53 on server
References: <20021227162426.GA8070@iucha.net>
In-Reply-To: <20021227162426.GA8070@iucha.net>
X-Enigmail-Version: 0.71.3.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Bmilter: Processing completed, Bmilter version 0.1.1 build 905; timestamp 2002-12-27 11:51:34, message serial number 664681
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

"Ditto"

Actually I have a bit more information.  Using both 2.5.5x (on NFS 
server) and 2.4.19/20, I get in dmesg, "kernel: RPC: garbage, exit EIO" 
and df reports zeroes across the board for NFS volumes.

Nothing fixes it, the NFS server has to be rebooted.  During one of 
these moments, I also noticed the NFS server had a non-fatal OOPS w/ 
rpc.kmountd.  Unfortunately I didn't save the OOPS.

David

Florin Iucha wrote:

>Hello,
>
>I have:
>   bear:/var/cache/apt/archives# mount | grep archives
>   beaver:/var/cache/apt/archives on /var/autofs/iucha/archives type nfs (rw,rsize=8192,wsize=8192,addr=10.10.0.10)
>Then:
>   bear:/var/cache/apt/archives# ls vim*
>   ls: vim*: No such file or directory
>   bear:/var/cache/apt/archives# find . -name vim\*
>   bear:/var/cache/apt/archives# md5sum vim-gtk_1%3a6.1-266+1_i386.deb
>   11a6d8dbfb51688d7ac275562540c327  vim-gtk_1%3a6.1-266+1_i386.deb
>   bear:/var/cache/apt/archives# 
>
>Note that /var/cache/apt/archives is a symbolic link to /var/autofs/iucha/archives.
>
>So "ls", "find" cannot find the name for the file, but if I know the
>file I can open it just fine.
>
>On the client:
>   bear:/var/cache/apt/archives# ls | wc -l
>   91
>On the server:
>   florin@beaver:/var/cache/apt/archives$ ls | wc -l
>   441
>
>Server has 2.5.53 with no other patches. For clients I have used both 2.5.53
>and 2.4.19 (Debian package).
>
>Cheers,
>florin
>  
>

- -- 
I may have the information you need and I may choose only HTML.  It's up to you. Disclaimer: I am not responsible for any email that you send me nor am I bound to any obligation to deal with any received email in any given fashion.  If you send me spam or a virus, I may in whole or part send you 50,000 return copies of it. I may also publically announce any and all emails and post them to message boards, news sites, and even parody sites.  I may also mark them up, cut and paste, print, and staple them to telephone poles for the enjoyment of people without internet access.  This is not a confidential medium and your assumption that your email can or will be handled confidentially is akin to baring your backside, burying your head in the ground, and thinking nobody can see you butt nekkid and in plain view for miles away.  Don't be a cluebert, buy one from K-mart today.

When it absolutely, positively, has to be destroyed overnight.
                           AIR FORCE

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQE+DIT/74cGT/9uvgsRAt7dAKCIzUEq28hVnizmKq4T0cf4h/vm0gCgpL08
2c9VcGcn8ao0A3HMRV/2Qck=
=j4F+
-----END PGP SIGNATURE-----

