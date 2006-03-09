Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751345AbWCITSv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751345AbWCITSv (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Mar 2006 14:18:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751348AbWCITSv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Mar 2006 14:18:51 -0500
Received: from out4.smtp.messagingengine.com ([66.111.4.28]:16287 "EHLO
	out4.smtp.messagingengine.com") by vger.kernel.org with ESMTP
	id S1751345AbWCITSu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Mar 2006 14:18:50 -0500
X-Sasl-enc: CNvplz6CKi1ufWPyYQANWAqCdVw8nDcNGtbfwCsUh5o5 1141931826
Message-ID: <44107F40.4000500@imap.cc>
Date: Thu, 09 Mar 2006 20:17:20 +0100
From: Tilman Schmidt <tilman@imap.cc>
Organization: me - organized??
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.0; de-AT; rv:1.7.12) Gecko/20050915
X-Accept-Language: de,en,fr
MIME-Version: 1.0
To: Jesper Juhl <jesper.juhl@gmail.com>
CC: "Randy.Dunlap" <rdunlap@xenotime.net>, Andrew Morton <akpm@osdl.org>,
       linux-usb-devel@lists.sourceforge.net, hjlipp@web.de,
       linux-kernel@vger.kernel.org, gregkh@suse.de
Subject: Re: [PATCH] reduce syslog clutter (take 2)
References: <440F609F.8090604@imap.cc> <20060309030257.5c1e0f30.akpm@osdl.org>	 <20060309083412.95e145ea.rdunlap@xenotime.net>	 <44107739.9070204@imap.cc> <9a8748490603091058l75aacacsfc5fdba3981fb074@mail.gmail.com>
In-Reply-To: <9a8748490603091058l75aacacsfc5fdba3981fb074@mail.gmail.com>
X-Enigmail-Version: 0.93.0.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enigAB46A137F009E60203B570FA"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigAB46A137F009E60203B570FA
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

On 09.03.2006 19:58, Jesper Juhl wrote:

> On 3/9/06, Tilman Schmidt <tilman@imap.cc> wrote:
>=20
>>On 09.03.2006 17:34, Randy.Dunlap wrote:
>>
>>>On Thu, 9 Mar 2006 03:02:57 -0800 Andrew Morton wrote:
>>>
>>>>Tilman Schmidt <tilman@imap.cc> wrote:
>>>>
>>>>>The current versions of the err() / info() / warn() syslog macros
>>>>>insert __FILE__ at the beginning of the message, which expands to
>>>>>the complete path name of the source file within the kernel tree.
>>>>>
>>>>>With the following patch, when used in a module, they'll insert the
>>>>>module name instead, which is significantly shorter and also tends t=
o
>>>>>be more useful to users trying to make sense of a particular message=
=2E
>>>>
>>>>Personally, I prefer to see filenames.  Or function names.  Sometimes=
 it's
>>>>rather unobvious how to go from module name to filename, due to a) mu=
ltiple
>>>>.o files being linked together, b) subsystems which insist on #includ=
ing .c
>>>>files in .c files (usb...) and c) the module system's cute habit of
>>>>replacing underscores with dashes in module names.
>>>
>>>True, just using module->name or whatever means that we would
>>>(often?) have to do a lookup to see what source file it was in.
>>
>>That would be a valid point for debugging messages. However, we are
>>talking about messages to users here. I maintain that the additional 20=

>>characters in:
>>
>>Feb 21 00:12:13 gx110 kernel: drivers/isdn/gigaset/i4l.c:
>>ISDN_CMD_SETL3: invalid protocol 42
>>
>>as opposed to:
>>
>>Feb 21 00:12:13 gx110 kernel: gigaset: ISDN_CMD_SETL3: invalid protocol=
 42
>>
>>do not provide any useful information for that clientele. They just pus=
h
>=20
> The filename may not be useful to the user, but the instant the user de=
cides to
> submit a bugreport to LKML or elsewhere it becomes useful.

Then why does the majority of kernel messages not include a filename?

--=20
Tilman Schmidt                          E-Mail: tilman@imap.cc
Bonn, Germany
Diese Nachricht besteht zu 100% aus wiederverwerteten Bits.
Unge=F6ffnet mindestens haltbar bis: (siehe R=FCckseite)


--------------enigAB46A137F009E60203B570FA
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.3rc1 (MingW32)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFEEH9AMdB4Whm86/kRAsT4AJ9xD0GqBLIkgXXCiyO9fn/o5ul7mwCfaJcx
uT9ohq0ud5hMPu6CHHSAVd8=
=smPn
-----END PGP SIGNATURE-----

--------------enigAB46A137F009E60203B570FA--
