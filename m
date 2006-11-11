Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1424569AbWKKMSV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1424569AbWKKMSV (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 11 Nov 2006 07:18:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1424571AbWKKMSV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 11 Nov 2006 07:18:21 -0500
Received: from mx3.mail.ru ([194.67.23.149]:18450 "EHLO mx3.mail.ru")
	by vger.kernel.org with ESMTP id S1424569AbWKKMSU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 11 Nov 2006 07:18:20 -0500
From: Andrey Borzenkov <arvidjaar@mail.ru>
To: Adrian Bunk <bunk@stusta.de>
Subject: Re: 2.6.19-rc5: where can I select INPUT?
Date: Sat, 11 Nov 2006 15:18:41 +0300
User-Agent: KMail/1.9.5
Cc: linux-kernel@vger.kernel.org
References: <200611111325.02749.arvidjaar@mail.ru> <20061111112528.GY4729@stusta.de>
In-Reply-To: <20061111112528.GY4729@stusta.de>
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200611111518.42238.arvidjaar@mail.ru>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

On Saturday 11 November 2006 14:25, Adrian Bunk wrote:
> On Sat, Nov 11, 2006 at 01:24:58PM +0300, Andrey Borzenkov wrote:
> > -----BEGIN PGP SIGNED MESSAGE-----
> > Hash: SHA1
> >
> > Neither in menuconfig nor in xconfig do I see any place to actually
> > select INPUT. Help text suggests that it is a) selectable b) it can be
> > made modules. I do not have either option. Here what I see in menuconfig
> > if I go into Input device support:
> >
> >     --- Generic input layer (needed for keyboard, mouse, ...)
> >     < >   Support for memoryless force-feedback devices
> >     ---   Userland interfaces
> >
> > as you see there is no check box for INPUT itself.
> >
> > I already had similar issue something else (I believe it was something
> > related to serio). In menuconfig item was no selectable, but I could
> > directly edit .config to change y to m.
> >...
>
> INPUT can only be unset if you set CONFIG_EMBEDDED=y.
>

{pts/1}% grep EMB /boot/config
CONFIG_EMBEDDED=y

> The rationale is that it usually doesn't make sense for users to disable
> INPUT, and allowing it tends to cause some confusion.
>

I do not want to disable it. I want to make it module (OK it has the same 
rationale - if you need it anyway why you do want to make it module etc). 
This should be possible according to help text. It does not work. Direct 
editing of .config silently reverts it back to y instead of m.

TIA

- -andrey
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.5 (GNU/Linux)

iD8DBQFFVb+iR6LMutpd94wRAtq+AJ0aMam9gJKSCN4PEbVKTEX7aijibgCfbB4/
7yVO9PFy9mQgpU4v2yieaUc=
=WNXy
-----END PGP SIGNATURE-----
