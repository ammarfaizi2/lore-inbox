Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262226AbUDAEqk (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 31 Mar 2004 23:46:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262219AbUDAEqk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 31 Mar 2004 23:46:40 -0500
Received: from supermail.mweb.co.za ([196.2.53.171]:7691 "EHLO
	supermail.mweb.co.za") by vger.kernel.org with ESMTP
	id S262235AbUDAEqi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 31 Mar 2004 23:46:38 -0500
Date: Thu, 1 Apr 2004 06:47:50 +0200
From: Bongani Hlope <bonganilinux@mweb.co.za>
To: Andrea Arcangeli <andrea@suse.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.5-rc3-aa1
Message-Id: <20040401064750.50d18c8d@bongani>
In-Reply-To: <20040331212242.GP2143@dualathlon.random>
References: <20040331030921.GA2143@dualathlon.random>
	<20040331211620.19a8f725@bongani>
	<20040331212242.GP2143@dualathlon.random>
X-Mailer: Sylpheed version 0.9.9claws (GTK+ 1.2.10; i586-mandrake-linux-gnu)
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
 micalg="pgp-sha1";
 boundary="Signature=_Thu__1_Apr_2004_06_47_50_+0200_hl1YvOS2V=3BwUHP"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--Signature=_Thu__1_Apr_2004_06_47_50_+0200_hl1YvOS2V=3BwUHP
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: 7bit

On Wed, 31 Mar 2004 23:22:42 +0200
Andrea Arcangeli <andrea@suse.de> wrote:

> On Wed, Mar 31, 2004 at 09:16:20PM +0200, Bongani Hlope wrote:
> > On Wed, 31 Mar 2004 05:09:21 +0200
> > Andrea Arcangeli <andrea@suse.de> wrote:
> > 
> > > The xfs warning during truncate will be fixed with a later update
> > > (Nathan is currently working on it).
> > > 
> > > next thing to do is to fixup the merging in mprotect.
> > > 
> > 
> > I'm running 2.6.5-rc2-aa4, when I woke-up in the morning almost all of
> > my memory was gone, but my swap was never touched. I managed to get
> > only the output of SysRq-M before it hard-locked. For some reason it
> > doesn't swap. I'll try to reproduce.
> 
> weird, it really loks like it doesn't swap anything. At least it's not a
> race condition. Which fs are you using?
> 
> can you try to actively push it into swap with a script like this?
> 
> #!/usr/bin/env python
> 
> while 1:
> 	try:
> 		a = 'a'
> 		while 1:
> 			a += a
> 	except MemoryError:
> 		pass
> 

I'm using ext3. and your script did push things to swap. I'm busy compiling 2.6.5-rc3-aa1 now.

Thanx Andrea

--Signature=_Thu__1_Apr_2004_06_47_50_+0200_hl1YvOS2V=3BwUHP
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQFAa573+pvEqv8+FEMRAufLAJ47uVbqxHwqn9bTzBAX1nuh35X77gCghjyS
axWau3wC8x60sNHqJjKJulo=
=L8PU
-----END PGP SIGNATURE-----

--Signature=_Thu__1_Apr_2004_06_47_50_+0200_hl1YvOS2V=3BwUHP--
