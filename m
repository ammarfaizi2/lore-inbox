Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751001AbWBBMko@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751001AbWBBMko (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Feb 2006 07:40:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751003AbWBBMkn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Feb 2006 07:40:43 -0500
Received: from cust8446.nsw01.dataco.com.au ([203.171.93.254]:40123 "EHLO
	cust8446.nsw01.dataco.com.au") by vger.kernel.org with ESMTP
	id S1750999AbWBBMkn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Feb 2006 07:40:43 -0500
From: Nigel Cunningham <nigel@suspend2.net>
Organization: Suspend2.net
To: Pekka Enberg <penberg@cs.helsinki.fi>
Subject: Re: [ 00/10] [Suspend2] Modules support.
Date: Thu, 2 Feb 2006 22:28:15 +1000
User-Agent: KMail/1.9.1
Cc: Pavel Machek <pavel@ucw.cz>, linux-kernel@vger.kernel.org
References: <20060201113710.6320.68289.stgit@localhost.localdomain> <200602022131.59928.nigel@suspend2.net> <84144f020602020344p228e20b2x34226f341c296578@mail.gmail.com>
In-Reply-To: <84144f020602020344p228e20b2x34226f341c296578@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart4622688.cbRWE4cv4S";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Message-Id: <200602022228.20032.nigel@suspend2.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--nextPart4622688.cbRWE4cv4S
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi.

On Thursday 02 February 2006 21:44, Pekka Enberg wrote:
> Hi,
>
> On 2/2/06, Nigel Cunningham <nigel@suspend2.net> wrote:
> > It's not an option because I'm not trying not to step all over your
> > codebase, because I'm not moving suspend2 to userspace and because it
> > doesn't make sense to add another layer of abstraction by sticking
> > /dev/snapshot in the middle of kernel space code. There may be more
> > reasons, but I haven't looked at the /dev/snapshot code at all.
>
> Any technical reasons why suspend modules shouldn't be in userspace? I
> can understand that you're not keen on redoing them but that's not an
> argument for inclusion in the mainline.

They're using cryptoapi to do the compression and encryption, and bio to do=
=20
the I/O. Moving this to userspace will add extra complexity and of course=20
slow down the process. It will also mean that to suspend and resume, the us=
er=20
will be unconditionally required to have an initrd or initramfs. This is=20
already the case for the more complicated configurations (LVM, encryption=20
with keys that need to be entered at a prompt etc), but most people simply=
=20
use an unencrypted, compressed image on a swap partition and in that case d=
o=20
not and should not need the added complication of configuring an initrd.

Shouldn't the question be "Why are we making this more complicated by movin=
g=20
it to userspace?"

Regards,

Nigel
=2D-=20
See our web page for Howtos, FAQs, the Wiki and mailing list info.
http://www.suspend2.net                IRC: #suspend2 on Freenode

--nextPart4622688.cbRWE4cv4S
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQBD4frjN0y+n1M3mo0RAvTZAKDbktP3Ij07exhD3iPiP+jIsm11QwCeMcy/
EeUO7TAbRppCjVd3bQUWfWc=
=7e2e
-----END PGP SIGNATURE-----

--nextPart4622688.cbRWE4cv4S--
