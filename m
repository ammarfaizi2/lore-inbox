Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932147AbWBXJaA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932147AbWBXJaA (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 24 Feb 2006 04:30:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932153AbWBXJaA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 24 Feb 2006 04:30:00 -0500
Received: from mail.phnxsoft.com ([195.227.45.4]:45574 "EHLO
	posthamster.phnxsoft.com") by vger.kernel.org with ESMTP
	id S932147AbWBXJaA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 24 Feb 2006 04:30:00 -0500
Message-ID: <43FED1FF.8050103@imap.cc>
Date: Fri, 24 Feb 2006 10:29:35 +0100
From: Tilman Schmidt <tilman@imap.cc>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.0; de-AT; rv:1.7.8) Gecko/20050511
X-Accept-Language: de, en, fr
MIME-Version: 1.0
To: Greg KH <greg@kroah.com>
CC: linux-kernel@vger.kernel.org, hjlipp@web.de
Subject: Re: [PATCH] reduce syslog clutter
References: <43FE40CD.3060803@imap.cc> <20060224060505.GA19111@kroah.com>
In-Reply-To: <20060224060505.GA19111@kroah.com>
X-Enigmail-Version: 0.90.0.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enig19971CBDBCC780FB0332C2EE"
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig19971CBDBCC780FB0332C2EE
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8bit

Hello Greg,

thanks for your comments.
Greg KH wrote:
> On Fri, Feb 24, 2006 at 12:10:05AM +0100, Tilman Schmidt wrote:
>> The current versions of the err() / info() / warn() syslog macros
>> insert __FILE__ at the beginning of the message, which expands to
>> the complete path name of the source file within the kernel tree.
>
> Note, this is the usb usage, you might want to post this on the
> linux-usb-devel mailing list :)

Ok.

>> With the following patch, when used in a module, they'll insert the
>> module name instead, which is significantly shorter and also tends to
>> be more useful to users trying to make sense of a particular message.
>>
>> The patch also adds macros for the KERN_NOTICE severity level which
>> was so far uncatered for.
>
> Does anyone want to use it?

Yes, me. :-)

In fact, they are being used in the Gigaset drivers which are currently
in the process of being submitted for inclusion in the kernel tree, but
their definitions are in the driver specific header file
drivers/isdn/gigaset/gigaset.h, although they really belong with
their brothers and sisters in usb.h / device.h.

> I suggest splitting this up into two different patches.

Ok.

Regards
Tilman

--
Tilman Schmidt                    E-Mail: tilman@imap.cc
Bonn, Germany
Diese Nachricht besteht zu 100% aus wiederverwerteten Bits.
Ungeöffnet mindestens haltbar bis: (siehe Rückseite)

--------------enig19971CBDBCC780FB0332C2EE
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (MingW32)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFD/tIHMdB4Whm86/kRAh8AAJ90FT1HZIzvYTqSwiibacWszodWdwCeJMV9
8cA++CRSHMIjE8uoHp0Mw3w=
=XtMp
-----END PGP SIGNATURE-----

--------------enig19971CBDBCC780FB0332C2EE--
