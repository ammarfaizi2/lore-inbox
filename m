Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316848AbSF0Nim>; Thu, 27 Jun 2002 09:38:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316849AbSF0Nim>; Thu, 27 Jun 2002 09:38:42 -0400
Received: from chello062179036163.chello.pl ([62.179.36.163]:37261 "EHLO
	pioneer") by vger.kernel.org with ESMTP id <S316848AbSF0Nil>;
	Thu, 27 Jun 2002 09:38:41 -0400
Date: Thu, 27 Jun 2002 15:42:47 +0200 (CEST)
From: Tomasz Rola <rtomek@cis.com.pl>
To: "David D. Hagood" <wowbagger@sktc.net>
cc: linux-kernel@vger.kernel.org
Subject: Re: New Zaurus Wishlist - removable media handling
In-Reply-To: <3D1A75FD.6010801@sktc.net>
Message-ID: <Pine.LNX.3.96.1020627145741.2000I-100000@pioneer>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

On Wed, 26 Jun 2002, David D. Hagood wrote:

> Tomasz Rola wrote:
> 
> > As a former Amiga user and now yet another Linux user, I probably know
> > what you mean. Well, I'm not a kernel engineer but maybe it could be done
> > with a virtual fs like /dev - so that
> 
> This sounds like autofs - you'd just need a program to scan all 
> available removable block devices, and look for a "label" to ID the 
> media - either a (V)FAT label, or an EXT(23) label, or XFS label, or....

Well, from what I know about autofs, it is only for filesystem things.

After reading the original post from David Golden
<david.golden@unison.ie>, I came to the "idea extension", so that apps on
the same computer could share different resources by name - be it not only 
mounted media but device files from /dev, IPC sockets or memories etc,
maybe even pids like /namespace/pids/apache_main. I don't know if this is
valuable idea or not and to really assess it there should be some
implementation with example applications using it.

I mention apps "on the same computer", because distributing such thing
over the network (LAN, I mean) is rather different subject and not
necessarily related to the kernel (I would say, it's not related and it's
not good to distribute internal kernel information by the means offered
in the kernel itself).

Myself, from time to time I do analyse some problems (involving
cooperating processes and other such beasts) and I come to the conclusion,
that the "problems" could be seen in different light when one assumes
existence of such, say, Kernel Name Service. Whether the "problems" can be
solved with less work thanks to such service I don't know yet. My analyses
are very generic at the moment :-).

> Then you mount the named volume as needed, with a 10 second umount 
> timeout, so that you can remove it easily.

One thing I really disliked in the GOAs (Good Old Amigas) was the clicking
floppy drive. This came from Amiga constantly checking if the user has
just inserted the floppy into the drive (and it could be turned off but
this wasn't always good to do so, the other trick was to have a floppy
constanlty inserted...).

And don't like the idea of automounting so I don't use it and hence I
don't know it this one clicks too or not.

> No need to add stuff to the kernel, it's already there.

Of course, everything can be done with the use of simpler means, like
semaphores can be done in the filesystem by creating and removing files
:-)...

And on the other hand, when a new API is introduced there is a lot of
issues related to access control I think, so I can understand people's
reluctance to add new functionality.

bye
T.

- --
** A C programmer asked whether computer had Buddha's nature.      **
** As the answer, master did "rm -rif" on the programmer's home    **
** directory. And then the C programmer became enlightened...      **
**                                                                 **
** Tomasz Rola          mailto:tomasz_rola@bigfoot.com             **

-----BEGIN PGP SIGNATURE-----
Version: PGPfreeware 5.0i for non-commercial use
Charset: noconv

iQA/AwUBPRsWXRETUsyL9vbiEQJx6QCg1AODJRZKJn/CVVjfFnIAXnRa7PkAmQHM
8jM03lc06tdqDwVGMNYWkbMH
=VGRX
-----END PGP SIGNATURE-----

