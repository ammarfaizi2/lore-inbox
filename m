Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262999AbUC2QSz (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 29 Mar 2004 11:18:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262818AbUC2QSz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 29 Mar 2004 11:18:55 -0500
Received: from chello081018200050.chello.pl ([81.18.200.50]:32139 "EHLO
	pioneer.space.nemesis.pl") by vger.kernel.org with ESMTP
	id S263034AbUC2QOr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 29 Mar 2004 11:14:47 -0500
Date: Mon, 29 Mar 2004 18:10:53 +0200 (CEST)
From: Tomasz Rola <rtomek@cis.com.pl>
To: Jeff Woods <Kazrak+kernel@cesmail.net>
cc: linux-kernel@vger.kernel.org, Tomasz Rola <rtomek@cis.com.pl>
Subject: Re: who is merlin.fit.vutbr.cz?
In-Reply-To: <6.0.1.1.0.20040329085820.0293aec0@no.incoming.mail>
Message-ID: <Pine.LNX.3.96.1040329180022.5234F-100000@pioneer.space.nemesis.pl>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

On Mon, 29 Mar 2004, Jeff Woods wrote:

> At 3/29/2004 03:32 PM +0200, Tomasz Rola wrote:
> >BTW, if I understand correctly, to read something from the tree one 
> >doesn't really need to lock it. Only writes should be locked.
> 
> Locking on reads prevents getting a copy of the tree with half of someone 
> else's changes that were written during your read.  That gets more likely 
> as the time it takes to read the entire tree increases.
> 
> --
> Jeff Woods <kazrak+kernel@cesmail.net> 

Ok, I got it. However, maybe this can be better solved by introducing a
feature, that enables to create snapshots in the form of pairs: 
 (name, version). After one has such snapshot info retrieved, one can
unlock the tree and read the rest without locks, only by specifying the
version of the resource (i.e., file in this case) in addition to its name.

Or, without such snapshot feature, after reading the entire tree unlocked,
check the versions of retrieved files and search for new/newer files, and
repeat pulling only for them. And so on.

But I think snapshot-info is more elegant and less error prone solution.
The second way is more resource demanding, imho.

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

iQA/AwUBQGhKlBETUsyL9vbiEQKP2wCg5nW/AFswFYIW2CgadL90Jvp3uxkAoNkO
GZRUQlPN9PnOW7ji2hrOimYO
=pBFo
-----END PGP SIGNATURE-----


