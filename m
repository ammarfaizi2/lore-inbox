Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751027AbWDWJh5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751027AbWDWJh5 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 23 Apr 2006 05:37:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751048AbWDWJh4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 23 Apr 2006 05:37:56 -0400
Received: from [80.48.65.9] ([80.48.65.9]:17997 "EHLO smtp.poczta.interia.pl")
	by vger.kernel.org with ESMTP id S1751026AbWDWJh4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 23 Apr 2006 05:37:56 -0400
Message-ID: <444B4AE6.4090601@poczta.fm>
Date: Sun, 23 Apr 2006 11:37:42 +0200
From: Lukasz Stelmach <stlman@poczta.fm>
User-Agent: Thunderbird 1.5 (X11/20051201)
MIME-Version: 1.0
To: Jan Engelhardt <jengelh@linux01.gwdg.de>
Cc: LKML <linux-kernel@vger.kernel.org>
Subject: Re: unix socket connection tracking
References: <44480BD9.5080100@poczta.fm> <Pine.LNX.4.61.0604211452490.23180@yvahk01.tjqt.qr> <4448DF94.5030500@poczta.fm> <Pine.LNX.4.61.0604211610500.31515@yvahk01.tjqt.qr> <444A1B86.1060701@poczta.fm> <Pine.LNX.4.61.0604221531190.18093@yvahk01.tjqt.qr>
In-Reply-To: <Pine.LNX.4.61.0604221531190.18093@yvahk01.tjqt.qr>
X-Enigmail-Version: 0.94.0.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enig916E5B899E80F9CD58E43F76"
X-EMID: 5980b138
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig916E5B899E80F9CD58E43F76
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Jan Engelhardt wrote:
>>>>>> I feel dumb as never so please enlight me. Is ther a way to find o=
ut which
>>>>>> process is on the other end of a unix socket pointed by a specifie=
d fd in a process.
>>>>> getpeer*()
>>>> getpeername(2) (that is the only man page I've got)
[...]
> Just look at all processes and logically connect them:
>=20
> 15:32 shanghai:/D/home/jengelh # l /proc/7315/fd
[...]
> 15:33 shanghai:/D/home/jengelh # l /proc/7316/fd/
[...]
> No need for ptrace. No need for getpeername() either, but it's useful t=
o=20
> get the real addresses of sockets.

Please understand my situation. I've got GNOME running, gconfd-2 is a "re=
gistry"
management process that accepts connections through a unix domain socket =
(named
one) from many *unrelated* (child/parent) processes. In fact from most gn=
ome
applications. I *do* strace it to see what it does. It does some write(2)=
s to
some sockets. I would like to know which socket leads where. Try to strac=
e
gconfd-2 and you'will see what I mean.

For now James Cloos gave the best option, to look for a socket with an i-=
node
number adjectant (+-1) to the socket I know.

--=20
By=C5=82o mi bardzo mi=C5=82o.                    Czwarta pospolita kl=C4=
=99ska, [...]
>=C5=81ukasz<                      Ju=C5=BC nie katolicka lecz z=C5=82odz=
iejska.  (c)PP


--------------enig916E5B899E80F9CD58E43F76
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2.2 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFES0rsNdzY8sm9K9wRAiZnAJ9M2JQA1UIcNLUKIyb4MUFR8BVBzgCgmPkM
p32p+PlOr2B0WSb69oVJQE4=
=3oCB
-----END PGP SIGNATURE-----

--------------enig916E5B899E80F9CD58E43F76--
