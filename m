Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316755AbSF0BgZ>; Wed, 26 Jun 2002 21:36:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316756AbSF0BgY>; Wed, 26 Jun 2002 21:36:24 -0400
Received: from chello062179036163.chello.pl ([62.179.36.163]:15291 "EHLO
	pioneer") by vger.kernel.org with ESMTP id <S316755AbSF0BgX>;
	Wed, 26 Jun 2002 21:36:23 -0400
Date: Thu, 27 Jun 2002 03:40:38 +0200 (CEST)
From: Tomasz Rola <rtomek@cis.com.pl>
To: David Golden <david.golden@unison.ie>
cc: linux-kernel@vger.kernel.org, zaurus-general@lists.sourceforge.net
Subject: Re: New Zaurus Wishlist - removable media handling
In-Reply-To: <20020627001108.E56D9AA91F@mail3.internet-ireland.ie>
Message-ID: <Pine.LNX.3.96.1020627032159.2332J-100000@pioneer>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

On Thu, 27 Jun 2002, David Golden wrote:

> 
> > And Unix filesystems were NOT designed for removable media.
> >
> 
> (LKML cc'd because this rant *might* be coherent enough to explain it
> to Linux kernel hackers)
> 
> The main problem I have with the Linux filesystems is this:
> 
> Forcing the user to think about which drive he stuck a disk or other
> removable medium into each time he wants to access it is silly - people
> often think of the disk as an entity independent of whichever drive it 
> happens to be in at the time.
> 
> It drives me crazy^Hier when software insists on its cdrom being /mnt/cdrom,
> for example  - there should be some way for the software to ask for
> "Give me a disk called xyzzy1, and I don't care what drive it is!", and 
> preferably by just trying to open e.g. /mnt/xyzzy1/
> 
> Once you've worked with a system that simply doesn't give a damn 
> what drive you put a removable disk into, or even lets you pretend an 
> arbitrary directory in the filesystem is that disk, it's very difficult to be 
> comfortable on ones that do give a damn.  
> 
> Accessing the removable medium by the volume name of the medium, _not_
>   (or not solely) by the drive it is in is something that the AmigaOS (the 
> "classic" AmigaOS, not the Intent platform plastered with Amiga-trademarks) 
> got "right", and Linux and Windows tend to get "wrong". (note the inverted 
> commas - "right" and "wrong" are merely my opinion as a one-time Amiga 
> user and now as a desktop linux user)
> 
> Amigas handled this with Assigns / amiga-style logical volumes (distinct from 
> unix/linux LVMs, which are block-level) - if you stuck a CD named xyzzy1 in 
> drive CD0:, you could access it via "CD0:" - "the volume currently in drive 
> CD0:, whatever it may be called" , or via "xyzzy1:" - " the volume called 
> xyzzy1, whatever drive it may be in"

As a former Amiga user and now yet another Linux user, I probably know
what you mean. Well, I'm not a kernel engineer but maybe it could be done
with a virtual fs like /dev - so that

1. /dev/ is not polluted
2. /mnt and other real disk space is not polluted

Having something under, say, /namespace (or, maybe /proc/namespace) could
be better than having CD0: or VirtualWhatever: and would allow to
integrate the concept into the unix way of thinking while retaining the
functionality you mean.

Of course this would also mean a new API related to the namespaces, and
they could be interfaces not only to cdroms but to IPC, for example. And,
the developers would have to be convinced to use the API :-). But speaking
only for myself, I think this is nice idea.

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

iQA/AwUBPRptHBETUsyL9vbiEQLWywCdENRRHIeCpNO6UnT1BAOBsTkFLkMAoIGu
aPrmfsYUaaq8yRj1FEQdrRUo
=wQik
-----END PGP SIGNATURE-----

