Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265953AbUBKQxN (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 Feb 2004 11:53:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265954AbUBKQxN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 Feb 2004 11:53:13 -0500
Received: from ahriman.bucharest.roedu.net ([141.85.128.71]:29907 "EHLO
	ahriman.bucharest.roedu.net") by vger.kernel.org with ESMTP
	id S265953AbUBKQwK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 Feb 2004 11:52:10 -0500
Date: Wed, 11 Feb 2004 18:53:48 +0200 (EET)
From: Mihai RUSU <dizzy@roedu.net>
X-X-Sender: dizzy@ahriman.bucharest.roedu.net
To: Larry McVoy <lm@bitmover.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: reiserfs for bkbits.net?
In-Reply-To: <200402111523.i1BFNnOq020225@work.bitmover.com>
Message-ID: <Pine.LNX.4.58L0.0402111849240.22898@ahriman.bucharest.roedu.net>
References: <200402111523.i1BFNnOq020225@work.bitmover.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Hi Larry

On Wed, 11 Feb 2004, Larry McVoy wrote:

> We're moving openlogging back to our offices and I'm experimenting with 
> filesystems to see what gives the best performance for BK usage.  Reiserfs
> looks pretty good and I'm wondering if anyone knows any reasons that we
> shouldn't use it for bkbits.net.  Also, would it help if the journal was
> on a different disk?  Most of the bkbits traffic is read so I doubt it.

I dont have much reiserfs experience on production systems so I cannot say
anything about its stability. However, about the external journal
question, my bonnie++ tests (which I would recommend you do them yourself)
showed not much increase in speed than with internal journal, than say,
xfs with internal or external (but the reiserfs values where much better
in general, at least in the many small files test).

As you said because its mostly read() that shouldnt matter. Dont forget 
noatime mount option :).

- -- 
Mihai RUSU                                    Email: dizzy@roedu.net
GPG : http://dizzy.roedu.net/dizzy-gpg.txt    WWW: http://dizzy.roedu.net
                       "Linux is obsolete" -- AST
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.3 (GNU/Linux)

iD8DBQFAKl4dPZzOzrZY/1QRAiAEAJ9xvPJ6o0F/m+Lxba581dyqGkZh7ACgj65e
G/ND//hn9QLij39pGdgvkR0=
=49A6
-----END PGP SIGNATURE-----
