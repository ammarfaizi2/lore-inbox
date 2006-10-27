Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1946389AbWJ0LLh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1946389AbWJ0LLh (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 27 Oct 2006 07:11:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1946391AbWJ0LLh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 27 Oct 2006 07:11:37 -0400
Received: from mivlgu.ru ([81.18.140.87]:17119 "EHLO mail.mivlgu.ru")
	by vger.kernel.org with ESMTP id S1946389AbWJ0LLg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 27 Oct 2006 07:11:36 -0400
Date: Fri, 27 Oct 2006 15:11:27 +0400
From: Sergey Vlasov <vsu@altlinux.ru>
To: Denis Vlasenko <vda.linux@googlemail.com>
Cc: linux-kernel@vger.kernel.org, Pierre Ossman <drzeus-mmc@drzeus.cx>
Subject: Re: O2 micro OZ711Mx mmc driver
Message-Id: <20061027151127.6e4c4edc.vsu@altlinux.ru>
In-Reply-To: <200610271205.14881.vda.linux@googlemail.com>
References: <1161936280.3937.4.camel@localhost.localdomain>
	<200610271205.14881.vda.linux@googlemail.com>
X-Mailer: Sylpheed version 2.2.9 (GTK+ 2.10.2; i586-alt-linux-gnu)
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
 micalg="PGP-SHA1";
 boundary="Signature=_Fri__27_Oct_2006_15_11_27_+0400_=cQtPsz=51QMP8ua"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--Signature=_Fri__27_Oct_2006_15_11_27_+0400_=cQtPsz=51QMP8ua
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: 7bit

On Fri, 27 Oct 2006 12:05:14 +0200 Denis Vlasenko wrote:

> On Friday 27 October 2006 10:04, Islam Amer wrote:
> > Hi all. Sorry for sending again, but my email didn't reach LKML, for
> > some reason.
> >
> > Here it is through the web interface ..
> >
> > http://lkml.org/lkml/2006/10/26/181
> >
> > In short I have contacted O2 Micro for a driver for my MMC card reader
> > OZ711Mx and they sent me a driver tarball under the GPL. It is made for
> > 2.6.16 and doesn't compile with recent kernels.
> >
> > I fixed it to compile but it still doesn't work. I am trying as hard as
> > I can to fix it but my programming knowledge is limited. Any help is
> > appreciated.
>
> You need to provide more details. Just "doesn't work" is
> nearly the worst bug report possible.
>
> I failed to find the tarball on that page.

http://mmc.drzeus.cx/wiki/Controllers/O2/OZ711Mx?action=AttachFile

(or select "Attach file" from the pulldown).

> If it is really GPLed, there is no reason why it cannot be merged
> into mainline (after necessary cleanups).

presidio_source-2k50714.tar.gz contains GPL headers and
MODULE_LICENSE("GPL") in *.[ch] files and even the GPL text in COPYING;
however, apparently the module is linked with the o2media/test.o_shipped
object file, sources for which are not included.  Sources for the o2sd
part are available - maybe they contain enough information to get at
least the SD/MMC part supported.

mbx-nonATA.zip also contains drivers with MODULE_LICENSE("GPL") linked
with binary-only parts; unfortunately, the object files have been
stripped and therefore are unusable.  There are also strange files like
ntddk.h there, which contain GPL notice sticked in front of the
Microsoft copyright notice.  And OpenSource/mbx-v2.4.x/WdmLib.c contains
lots of copied code from other places, including:

/*
 * Regular lowlevel cardbus driver ("yenta")
 *
 * (C) Copyright 1999, 2000 Linus Torvalds
 */

And they link this with that o2ext.o binary...

--Signature=_Fri__27_Oct_2006_15_11_27_+0400_=cQtPsz=51QMP8ua
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.5 (GNU/Linux)

iD8DBQFFQellW82GfkQfsqIRAjQSAKCMM8WAS14hBqYzBw65OiRmKHzjogCdFklM
BpY4D2X23B+5JzxKm4ygTrY=
=uG8a
-----END PGP SIGNATURE-----

--Signature=_Fri__27_Oct_2006_15_11_27_+0400_=cQtPsz=51QMP8ua--
