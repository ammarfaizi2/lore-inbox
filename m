Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262718AbUCOTW6 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 15 Mar 2004 14:22:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262726AbUCOTW6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 Mar 2004 14:22:58 -0500
Received: from inti.inf.utfsm.cl ([200.1.21.155]:35011 "EHLO inti.inf.utfsm.cl")
	by vger.kernel.org with ESMTP id S262718AbUCOTW4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 Mar 2004 14:22:56 -0500
Message-Id: <200403151922.i2FJMfIh004411@eeyore.valparaiso.cl>
To: =?iso-8859-1?Q?J=F6rn?= Engel <joern@wohnheim.fh-wedel.de>
cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: unionfs 
In-Reply-To: Message from =?iso-8859-1?Q?J=F6rn?= Engel <joern@wohnheim.fh-wedel.de> 
   of "Mon, 15 Mar 2004 17:13:23 +0100." <20040315161323.GD16615@wohnheim.fh-wedel.de> 
X-Mailer: MH-E 7.4.2; nmh 1.0.4; XEmacs 21.4 (patch 14)
Date: Mon, 15 Mar 2004 15:22:41 -0400
From: Horst von Brand <vonbrand@inf.utfsm.cl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

=?iso-8859-1?Q?J=F6rn?= Engel <joern@wohnheim.fh-wedel.de> said:
> On Mon, 15 March 2004 22:35:20 +0800, Ian Kent wrote:

> > I don't understand the requirement properly. Sorry.

> Depends on who you ask, but imo it boils down to this:
> - Use one filesystem as backing store, usually ro.
> - Have another filesystem on top for extra functionality, usually rw
>   access.
> 
> Famous example is a rw-CDROM, where writes go to hard drive and
> unchanged data is read from CDROM.  But it makes sense for other
> things as well.

And what if the underlying filesystem is RW too? What should happen if you
unite several (>= 3) filesystems? What if some are RO, others RW? What do
you do if a file shows up several times, each different?

Assuming one RW on top of a RO only now: What should happen when a
file/directory is missing from the top? If the bottom one "shows through",
you can't delete anything; if it doesn't, you win nothing (because you will
have to keep a complete copy RW on top).

IIRC, this has been discussed a couple of times before, and the consensus
each time was that it isn't /that hard/ to do, it is /hard or impossible/
to find a sensible, simple semantics for this. The idea was then dropped...
-- 
Dr. Horst H. von Brand                   User #22616 counter.li.org
Departamento de Informatica                     Fono: +56 32 654431
Universidad Tecnica Federico Santa Maria              +56 32 654239
Casilla 110-V, Valparaiso, Chile                Fax:  +56 32 797513

