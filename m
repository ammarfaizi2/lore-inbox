Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262223AbULQWzJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262223AbULQWzJ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Dec 2004 17:55:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262221AbULQWwS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Dec 2004 17:52:18 -0500
Received: from natjimbo.rzone.de ([81.169.145.162]:2955 "EHLO
	natjimbo.rzone.de") by vger.kernel.org with ESMTP id S262219AbULQWu3
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Dec 2004 17:50:29 -0500
Date: Fri, 17 Dec 2004 23:50:00 +0100
From: Dominik Brodowski <linux@dominikbrodowski.de>
To: cpufreq@www.linux.org.uk, linux-kernel@vger.kernel.org
Subject: [ANNOUNCE] cpufrequtils-0.1 released
Message-ID: <20041217225000.GA8245@dominikbrodowski.de>
Mail-Followup-To: cpufreq@www.linux.org.uk,
	linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="MGYHOYXEY6WxJCY8"
Content-Disposition: inline
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--MGYHOYXEY6WxJCY8
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

cpufrequtils-0.1 is out and available at

http://www.kernel.org/pub/linux/utils/kernel/cpufreq/cpufrequtils-0.1.tar.b=
z2

and will arrive the same place at kernel.org mirrors soon.

It conists of the following elements:


libcpufreq
----------

"libcpufreq" is a library which offers a unified access method for userspac=
e=20
tools and programs to the cpufreq core and drivers in the Linux kernel. This
allows for code reduction in userspace tools, a clean implementation of
the interaction to the cpufreq core, and support for both the sysfs and proc
interfaces [depending on configuration, see below].


utils
-----

"cpufreq-info" determines current cpufreq settings, and provides useful
debug information to users and bug-hunters.
"cpufreq-set" allows to set a specific frequency and/or new cpufreq policies
without having to type "/sys/devices/system/cpu/cpu0/cpufreq" all the time.


debug
-----

A few debug tools helpful for cpufreq have been merged into this package,
but as they are highly architecture specific they are not built by default.


compilation and installation
----------------------------

=2E/configure && make
su
make install

should suffice on most systems. It builds default libcpufreq,
cpufreq-set and cpufreq-info files and installs them in /usr/local/lib and
/usr/local/bin, respectively. Due to the autotoolization by Mattia Dongili
the standard options to make and make install, like "--prefix=3D/usr", can =
be
passed and (should) work correctly.


options and dependencies
------------------------

=2E/configure by default enables the sysfs interface, but disables the
deprecated /proc interface to the cpufreq core in the Linux kernel. For
the sysfs interface to build and work correctly, you need "libsysfs", which
is part of the "sysfsutils" package. Current requirement is
	sysfsutils-1.0.0
or later.

To disable the sysfs interface, pass the option "--disable-sysfs" to
=2E/configure.


To enable the (deprecated) /proc interface support, pass the option
"--enable-proc" to ./configure.


THANKS
------
Many thanks to Mattia Dongili who wrote the autotoolization and
libtoolization, the manpages and the italian language file for cpufrequtils=
;=20
to Dave Jones for his feedback and his dump_psb tool; to Bruno Ducrot for h=
is=20
powernow-k8-decode and intel_gsic tools as well as the french language file;
and to various others commenting on the pre-releases of cpufrequtils-0.1.


	Dominik

--MGYHOYXEY6WxJCY8
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.6 (GNU/Linux)

iD8DBQFBw2KYZ8MDCHJbN8YRAtFMAJ9BtIev5b2EzvH1RWVt63iAJpoa2ACdELkl
cjxxsG0pCGk31V7hWjGwmxY=
=FV+u
-----END PGP SIGNATURE-----

--MGYHOYXEY6WxJCY8--
