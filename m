Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261931AbVAaGLr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261931AbVAaGLr (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 31 Jan 2005 01:11:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261932AbVAaGLq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 31 Jan 2005 01:11:46 -0500
Received: from faye.voxel.net ([69.9.164.210]:50582 "EHLO faye.voxel.net")
	by vger.kernel.org with ESMTP id S261931AbVAaGHf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 31 Jan 2005 01:07:35 -0500
Subject: [PATCH] cpufreq resume fix?
From: Andres Salomon <dilinger@voxel.net>
To: Dominik Brodowski <linux@brodo.de>
Cc: Dave Jones <davej@redhat.com>, linux-kernel@vger.kernel.org
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-weZ626cNGV+Ifz23LAY5"
Date: Mon, 31 Jan 2005 01:07:30 -0500
Message-Id: <1107151650.12847.6.camel@localhost>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.3 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-weZ626cNGV+Ifz23LAY5
Content-Type: multipart/mixed; boundary="=-GXozz0WnO+Ta9g6brwjO"


--=-GXozz0WnO+Ta9g6brwjO
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

Hi,

I noticed in the following changeset, the cpufreq_driver->resume call
semantics looked a little odd:
http://linux.bkbits.net:8080/linux-2.6/gnupatch@41d25ff3DyITFVz4Jm34PpluFPl=
t-g

Since acpi_cpufreq_resume and speedstep_resume appear to return 0 upon
success, it seems like the attached patch is what the desired behavior
would be.  Otherwise, cpufreq_resume() always prints an error and exits
early if using a cpufreq_driver that supports resume.


--=20
Andres Salomon <dilinger@voxel.net>

--=-GXozz0WnO+Ta9g6brwjO
Content-Disposition: attachment; filename=cpufreq.patch
Content-Type: text/x-patch; name=cpufreq.patch; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: base64

LS0tIG9yaWcvZHJpdmVycy9jcHVmcmVxL2NwdWZyZXEuYwkyMDA1LTAxLTMxIDAxOjA0OjE3LjUw
MzQ1MjA3MiAtMDUwMA0KKysrIG1vZC9kcml2ZXJzL2NwdWZyZXEvY3B1ZnJlcS5jCTIwMDUtMDEt
MzEgMDE6MDU6MTUuOTkyNTYwMzc2IC0wNTAwDQpAQCAtOTAwLDkgKzkwMCwxMSBAQA0KIA0KIAlp
ZiAoY3B1ZnJlcV9kcml2ZXItPnJlc3VtZSkgew0KIAkJcmV0ID0gY3B1ZnJlcV9kcml2ZXItPnJl
c3VtZShjcHVfcG9saWN5KTsNCi0JCXByaW50ayhLRVJOX0VSUiAiY3B1ZnJlcTogcmVzdW1lIGZh
aWxlZCBpbiAtPnJlc3VtZSBzdGVwIG9uIENQVSAldVxuIiwgY3B1X3BvbGljeS0+Y3B1KTsNCi0J
CWNwdWZyZXFfY3B1X3B1dChjcHVfcG9saWN5KTsNCi0JCXJldHVybiAocmV0KTsNCisJCWlmIChy
ZXQpIHsNCisJCQlwcmludGsoS0VSTl9FUlIgImNwdWZyZXE6IHJlc3VtZSBmYWlsZWQgaW4gLT5y
ZXN1bWUgc3RlcCBvbiBDUFUgJXVcbiIsIGNwdV9wb2xpY3ktPmNwdSk7DQorCQkJY3B1ZnJlcV9j
cHVfcHV0KGNwdV9wb2xpY3kpOw0KKwkJCXJldHVybiAocmV0KTsNCisJCX0NCiAJfQ0KIA0KIAlp
ZiAoIShjcHVmcmVxX2RyaXZlci0+ZmxhZ3MgJiBDUFVGUkVRX0NPTlNUX0xPT1BTKSkgew0K


--=-GXozz0WnO+Ta9g6brwjO--

--=-weZ626cNGV+Ifz23LAY5
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.5 (GNU/Linux)

iD8DBQBB/csh78o9R9NraMQRAuyLAJ46VxRP0i4SZzUWrkvgA0+0LKJwrACdHSlL
Dng+RWWC8hzj3tusApnEtMQ=
=PlA+
-----END PGP SIGNATURE-----

--=-weZ626cNGV+Ifz23LAY5--

