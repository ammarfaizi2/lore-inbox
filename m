Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932506AbWIZXqo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932506AbWIZXqo (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 26 Sep 2006 19:46:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932509AbWIZXqn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 26 Sep 2006 19:46:43 -0400
Received: from out1.smtp.messagingengine.com ([66.111.4.25]:49616 "EHLO
	out1.smtp.messagingengine.com") by vger.kernel.org with ESMTP
	id S932506AbWIZXqn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 26 Sep 2006 19:46:43 -0400
X-Sasl-enc: +jSg65+QcbS1041jcvvACMKj7b44A7htfohdinqnMwqE 1159314404
Message-ID: <4519BC3C.1040700@imap.cc>
Date: Wed, 27 Sep 2006 01:48:12 +0200
From: Tilman Schmidt <tilman@imap.cc>
Organization: me - organized??
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.0; de-AT; rv:1.8.0.6) Gecko/20060729 SeaMonkey/1.0.4 Mnenhy/0.7.4.666
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: linux-kernel@vger.kernel.org, Chris Mason <mason@suse.com>,
       ext2-devel@lists.sourceforge.net, reiserfs-dev@namesys.com
Subject: Re: [2.6.18-rc7-mm1] slow boot
References: <4516B966.3010909@imap.cc> <20060924145337.ae152efd.akpm@osdl.org>
In-Reply-To: <20060924145337.ae152efd.akpm@osdl.org>
X-Enigmail-Version: 0.94.1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enig15F83DD640135974CB811F32"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig15F83DD640135974CB811F32
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

On 24.09.2006 23:53, Andrew Morton wrote:
> make-ext3-mount-default-to-barrier=3D1.patch takes my laptop's bootup t=
ime
> from 53 seconds to 68, which is rather painful.  In fact I'm inclined t=
o
> drop the patch because of this, and I'd also be quite concerned about t=
he
> similar reiserfs patch, make-reiserfs-default-to-barrier=3Dflush.patch.=

[...]
> Do you have the time to go through the
> http://www.zip.com.au/~akpm/linux/patches/stuff/bisecting-mm-trees.txt
> process?

Ok, so far I've narrowed it down to the section between
#X64_64-START
and
#X64_64-END
which I guess lets make-{ext3-mount,reiserfs}-default-to-barrier=3D1.patc=
h
off the hook for now.

Trying to bisect further into that section now, but perhaps that'll
already trigger some thoughts?

Thanks
Tilman

--=20
Tilman Schmidt                          E-Mail: tilman@imap.cc
Bonn, Germany
Diese Nachricht besteht zu 100% aus wiederverwerteten Bits.
Ungeoeffnet mindestens haltbar bis: (siehe Rueckseite)


--------------enig15F83DD640135974CB811F32
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.3rc1 (MingW32)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFFGbxEMdB4Whm86/kRAkNGAJ96QDW4SxXvjTp/qifxPnFBz7f1xQCggexM
xDxbxepPXsBccLZjiBn6Ww4=
=AvkZ
-----END PGP SIGNATURE-----

--------------enig15F83DD640135974CB811F32--
