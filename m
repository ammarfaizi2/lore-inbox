Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266303AbUBLIqG (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 Feb 2004 03:46:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266307AbUBLIqG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 Feb 2004 03:46:06 -0500
Received: from ahriman.bucharest.roedu.net ([141.85.128.71]:9694 "EHLO
	ahriman.bucharest.roedu.net") by vger.kernel.org with ESMTP
	id S266303AbUBLIqC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 Feb 2004 03:46:02 -0500
Date: Thu, 12 Feb 2004 10:47:34 +0200 (EET)
From: Mihai RUSU <dizzy@roedu.net>
X-X-Sender: dizzy@ahriman.bucharest.roedu.net
To: Larry McVoy <lm@bitmover.com>
cc: Bryan Whitehead <driver@jpl.nasa.gov>, M?ns Rullg?rd <mru@kth.se>,
       linux-kernel@vger.kernel.org
Subject: Re: reiserfs for bkbits.net?
In-Reply-To: <20040211191922.GA31404@work.bitmover.com>
Message-ID: <Pine.LNX.4.58L0.0402121043420.17138@ahriman.bucharest.roedu.net>
References: <200402111523.i1BFNnOq020225@work.bitmover.com>
 <20040211161358.GA11564@favonius> <yw1xisidino2.fsf@kth.se>
 <402A747C.8020100@jpl.nasa.gov> <20040211191922.GA31404@work.bitmover.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

On Wed, 11 Feb 2004, Larry McVoy wrote:

> On Wed, Feb 11, 2004 at 10:29:16AM -0800, Bryan Whitehead wrote:
> > http://pcbunn.cacr.caltech.edu/gae/3ware_raid_tests.htm
> > 
> > They needed 200MByte/sec disk transfer speed. this is how they got it.
> 
> Our workload is MUCH less friendly than bonnie.  We typically have lots
> of traffic spread over lots of small files.  With 1-3 outstanding 
> requests (i.e., just at the point where disk sort does you little good).

Hmm, you could try parallel bonnie++ instances then:

- - synchronized
$ bonnie++ -d /path/to/testdir -s0 -n 4096:16000:64000:64 -p 10
then 10 times of 
$ bonnie++ -d /path/to/testdir -s0 -n 4096:16000:64000:64 -y

- - or just run them in background unsynchronized

- -- 
Mihai RUSU                                    Email: dizzy@roedu.net
GPG : http://dizzy.roedu.net/dizzy-gpg.txt    WWW: http://dizzy.roedu.net
                       "Linux is obsolete" -- AST
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.3 (GNU/Linux)

iD8DBQFAKz2vPZzOzrZY/1QRAjs5AJ9E9wjayUmvKLrhsZ16KMnrm0OqXgCgqWy9
jtyLokxSBNvjqz1b8VfaDiM=
=jHZe
-----END PGP SIGNATURE-----
