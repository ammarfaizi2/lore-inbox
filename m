Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265259AbUAESai (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 5 Jan 2004 13:30:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265263AbUAESah
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 Jan 2004 13:30:37 -0500
Received: from smtp.dei.uc.pt ([193.137.203.228]:735 "EHLO smtp.dei.uc.pt")
	by vger.kernel.org with ESMTP id S265259AbUAESa0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 Jan 2004 13:30:26 -0500
Date: Mon, 5 Jan 2004 18:29:20 +0000 (WET)
From: "Marcos D. Marado Torres" <marado@student.dei.uc.pt>
To: Dmitry Torokhov <dtor_core@ameritech.net>
cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] psmouse info in 2.6.1-rc1
In-Reply-To: <200401051317.23795.dtor_core@ameritech.net>
Message-ID: <Pine.LNX.4.58.0401051827120.23750@student.dei.uc.pt>
References: <Pine.LNX.4.58.0401051711170.23750@student.dei.uc.pt>
 <200401051317.23795.dtor_core@ameritech.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-UC-DEI-MailScanner-Information: Please contact helpdesk@dei.uc.pt for more information
X-UC-DEI-MailScanner: Found to be clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

On Mon, 5 Jan 2004, Dmitry Torokhov wrote:

> On Monday 05 January 2004 12:16 pm, Marcos D. Marado Torres wrote:
> > Hi there...
> > I don't really know if this is only in -rc1-mm1 but I suppose -rc1 is
> > affected also.
> >
> > The new changes in drivers/input/mouse/psmouse-base.c make that we
> > don't have anymore to give to kernel  psmouse_proto=imps, but only
> > proto=imps , so the info about it is wrong... Please apply the patch:
> >
> > --- linux-2.6.1-rc1-mm2/drivers/input/mouse/Kconfig     2004-01-05
> > 10:51:16.000000000 +0100 +++
> > linux-2.6.1-rc1-mm2-mbn1/drivers/input/mouse/Kconfig        2004-01-05
> > 13:34:26.000000000 +0100 @@ -30,7 +30,7 @@
> >                 http://www.geocities.com/dt_or/gpm/gpm.html
> >           to take advantage of the advanced features of the touchpad.
> >           If you do not want install specialized drivers but want
> > tapping -         working please use option psmouse.proto=imps.
> > +         working please use option proto=imps.
> >
> >           If unsure, say Y.
>
>
> It is psmouse.proto=imps if psmouse is built in the kernel and proto=imps
> if psmouse is compiled as a module. I mentioned only the first form because
> I assumed that most people have it built-in.

Weird: I have it built in the kernel and need to do proto=imps and not
psmouse.proto=imps ...

Anyway, wasn't the patch (one of) made so that users would have to pass to the
kernel the same for both cases?

> Generally with the module_param macros kernel parameters have a prefix
> in form of "module_name." if module is built into the kernel.
>
> Dmitry
>


- --
==================================================
Marcos Daniel Marado Torres AKA Mind Booster Noori
/"\               http://student.dei.uc.pt/~marado
\ /                       marado@student.dei.uc.pt
 X   ASCII Ribbon Campaign
/ \  against HTML e-mail and Micro$oft attachments
==================================================

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)
Comment: Made with pgp4pine 1.76

iD8DBQE/+a0DmNlq8m+oD34RAnluAKCpTsaQi1brvPlY9SVMXb3vUatYHQCfTM6y
5OD2CnwUYcHbjbLKqyc9YWg=
=qyEx
-----END PGP SIGNATURE-----

