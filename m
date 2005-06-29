Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262275AbVF2BZl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262275AbVF2BZl (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Jun 2005 21:25:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261530AbVF2Ajr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Jun 2005 20:39:47 -0400
Received: from locomotive.csh.rit.edu ([129.21.60.149]:2666 "EHLO
	locomotive.unixthugs.org") by vger.kernel.org with ESMTP
	id S262306AbVF2Aab (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Jun 2005 20:30:31 -0400
Date: Tue, 28 Jun 2005 20:30:30 -0400
From: Jeff Mahoney <jeffm@suse.com>
To: Andrew Morton <akpm@osdl.org>, Linus Torvalds <torvalds@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: [PATCH 0/3] openfirmware/macio: hotplug support
Message-ID: <20050629003030.GB24094@locomotive.unixthugs.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="Q68bSM7Ycu6FN28Q"
Content-Disposition: inline
X-Operating-System: Linux 2.6.5-7.151-smp (i686)
X-GPG-Fingerprint: A16F A946 6C24 81CC 99BB  85AF 2CF5 B197 2B93 0FB2
X-GPG-Key: http://www.csh.rit.edu/~jeffm/jeffm.gpg
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--Q68bSM7Ycu6FN28Q
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello all -

I dug these up so I wouldn't have to look at them on my disk anymore. :)

I last posted these patches in March, and some discussion came about, mostly
regarding how to handle whitespace in the compat field and how a comma was
an unacceptable field delimeter.

The following 3 patches, combined with the userspace patches referenced bel=
ow,
implement hotplug events for open firmware/macio devices such as apple airp=
ort
wireless ethernet cards.

* 01-openfirmware-device-table.diff
  - Converts struct of_match to a MODULE_DEVICE_TABLE-compatible
    struct of_device_id
  - Uses the information to generate a device table parsable by
    depmod(8)

* 02-openfirmware-sysfs.diff
  - Exports openfirmware variables via sysfs so that coldplug can read and
    take appropriate action

* 03-openfirmware-hotplug.diff
  - Adds the hotplug routine for generating hotplug events. Uses the
    information published to provide the hotplug environment variables to
    userspace.

In addition to the kernel patches, userspace patches for hotplug and
module-init-tools are also required. These patches, including the kernel
patches, are available here:

ftp://ftp.suse.com/pub/people/jeffm/linux/macio-hotplug/

macio.rc: implements coldplug support for macio devices
of.agent: implements module loading for of-table devices
module-init-tools-3.0-pre10-openfirmware.diff: adds modules.ofmap to depmod

I'd appreciate any comments.

-Jeff

--=20
Jeff Mahoney
SuSE Labs

--Q68bSM7Ycu6FN28Q
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQFCweulLPWxlyuTD7IRAhrEAJ4shCg130cFy0qlMZ7fVA1WbaHW9wCfWpnR
3Aj5lUkfWgOV6cS+e3sq4qQ=
=Xoqn
-----END PGP SIGNATURE-----

--Q68bSM7Ycu6FN28Q--
