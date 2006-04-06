Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932146AbWDFEJ4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932146AbWDFEJ4 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 6 Apr 2006 00:09:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932145AbWDFEJ4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 6 Apr 2006 00:09:56 -0400
Received: from b3162.static.pacific.net.au ([203.143.238.98]:48008 "EHLO
	cust8446.nsw01.dataco.com.au") by vger.kernel.org with ESMTP
	id S932141AbWDFEJz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 6 Apr 2006 00:09:55 -0400
From: Nigel Cunningham <ncunningham@cyclades.com>
Organization: Cyclades Corporation
To: Greg KH <gregkh@suse.de>
Subject: Re: ACPI Compile error in current git (pci.h)
Date: Thu, 6 Apr 2006 14:09:12 +1000
User-Agent: KMail/1.9.1
Cc: linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org
References: <200603241404.08109.ncunningham@cyclades.com> <200603241437.26633.ncunningham@cyclades.com> <20060406035012.GB26601@suse.de>
In-Reply-To: <20060406035012.GB26601@suse.de>
MIME-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart2647126.qoGodFjIgt";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Message-Id: <200604061409.16581.ncunningham@cyclades.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--nextPart2647126.qoGodFjIgt
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi Greg.

On Thursday 06 April 2006 13:50, Greg KH wrote:
> On Fri, Mar 24, 2006 at 02:37:18PM +1000, Nigel Cunningham wrote:
> > Hi again.
> >
> > On Friday 24 March 2006 14:04, Nigel Cunningham wrote:
> > > Hi.
> > >
> > > Current git produces the following compile error (x86_64 uniprocessor
> > > compile):
> > >
> > > arch/x86_64/pci/mmconfig.c:152: error: conflicting types for
> > > ???pci_mmcfg_init??? arch/i386/pci/pci.h:85: error: previous
> > > declaration of ???pci_mmcfg_init??? was here make[1]: ***
> > > [arch/x86_64/pci/mmconfig.o] Error 1 make: *** [arch/x86_64/pci] Error
> > > 2
> > >
> > > I haven't found out yet how the i386 file is getting included, but I
> > > can say that git compiled fine last night.
> >
> > Got the answer to this bit - it is included via the Makefile in the
> > directory setting a -I flag, and the file including "pci.h".
>
> Does this still happen for 2.6.17-rc1?
>
> thanks,
>
> greg k-h

No, it's fixed. I figured out the cause a little later the same day, and so=
=20
did someone else (don't recall the name now). A patch has been merged.

Regards,

Nigel

--nextPart2647126.qoGodFjIgt
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQBENJRsN0y+n1M3mo0RAnDgAKDpzMp0j7rfUi5sUgGjE/UQt2m4xwCfWlb7
E2a3FS4iTZ3AE5r69KUvEaI=
=Szod
-----END PGP SIGNATURE-----

--nextPart2647126.qoGodFjIgt--
