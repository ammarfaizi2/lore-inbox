Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262925AbUC2Mh7 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 29 Mar 2004 07:37:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262896AbUC2MgL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 29 Mar 2004 07:36:11 -0500
Received: from chello081018200050.chello.pl ([81.18.200.50]:14981 "EHLO
	pioneer.space.nemesis.pl") by vger.kernel.org with ESMTP
	id S262909AbUC2Mfm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 29 Mar 2004 07:35:42 -0500
Date: Mon, 29 Mar 2004 15:32:49 +0200 (CEST)
From: Tomasz Rola <rtomek@cis.com.pl>
To: Larry McVoy <lm@bitmover.com>
cc: linux-kernel@vger.kernel.org, Tomasz Rola <rtomek@cis.com.pl>
Subject: Re: who is merlin.fit.vutbr.cz?
In-Reply-To: <200403290108.i2T18T8d024595@work.bitmover.com>
Message-ID: <Pine.LNX.3.96.1040329151755.5234B-100000@pioneer.space.nemesis.pl>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

On Sun, 28 Mar 2004, Larry McVoy wrote:

> Folks, I need your help.
> 
> I can't tell if this is a DOS attack or someone with a REALLY slow net
> connection.  Whoever this is has been cloning the linux 2.6 (aka 2.5)
> tree on bkbits so slowly that the tree is locked for days and can't
> be updated.  About once a day I go kill the clone because stracing it
> shows it doing nothing.
> 
> Linus and Andrew M are annoyed enough that the tree isn't getting updates
> that they complained to me.  Makes me feel bad when they do that so that's
> why I'm looking for help.
[...]
> Anyway, we've suffered more than enough bad press so before I
> assume that this host is a rogue and filter them, does anyone know who
> merlin.fit.vutbr.cz is?  If they really have that slow of a connection
> we'll burn a CD and Fedex it to them, nobody should suffer that much.
> But if this is just a DOS, we'll nuke 'em.

I don't know details of bk, so please forgive me if I am writing about
something already existing, but isn't it possible to implement a timeout
and some kind of intelligent retry in a similar manner to nowadays
http/ftp ? A server could then check if someone has made something with
his connection during last, say, minute and then drop the connection if
nothing was pulled during that time. Next, if someone has really slow
connection, give him the ability to start transfer from specified offset
so that he could retry from the place he had been dropped.

To prevent instant locking, maybe some kind of queuing? FIFO and if you
don't pull what you locked, you get kicked out. If you return, wait for
your turn until Linus ;) (or someone else) does his updates.

BTW, if I understand correctly, to read something from the tree one
doesn't really need to lock it. Only writes should be locked.

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

iQA/AwUBQGglixETUsyL9vbiEQJ3mwCg0XFzTQG9rhugOerAnQBzu8ObszMAni9i
9ggm8ENBVL/TDJ+N2UtvBWo7
=lLpf
-----END PGP SIGNATURE-----


