Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129878AbRAWLPM>; Tue, 23 Jan 2001 06:15:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130085AbRAWLOy>; Tue, 23 Jan 2001 06:14:54 -0500
Received: from ppp0.ocs.com.au ([203.34.97.3]:48145 "HELO mail.ocs.com.au")
	by vger.kernel.org with SMTP id <S129878AbRAWLOc>;
	Tue, 23 Jan 2001 06:14:32 -0500
X-Mailer: exmh version 2.1.1 10/15/1999
From: Keith Owens <kaos@ocs.com.au>
To: linux-kernel@vger.kernel.org
Subject: Announce: modutils 2.4.2 is available 
Date: Tue, 23 Jan 2001 22:14:24 +1100
Message-ID: <23519.980248464@ocs3.ocs-net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Content-Type: text/plain; charset=us-ascii

ftp://ftp.<country>.kernel.org/pub/linux/utils/kernel/modutils/v2.4

modutils-2.4.2.tar.gz           Source tarball, includes RPM spec file
modutils-2.4.2-1.src.rpm        As above, in SRPM format
modutils-2.4.2-1.i386.rpm       Compiled with egcs-2.91.66, glibc 2.1.2
patch-modutils-2.4.2.gz         Patch from modutils 2.4.0 to 2.4.2.
Sparc and IA64 binaries to follow.

Related kernel patches.

patch-2.4.0-persistent.gz       Adds persistent data and generic string
                                support to kernel 2.4.0.  Optional.

Changelog extract

        * genksym changes: Remove 'attribute' as a C keyword, add 'restrict',
          '__restrict', '__restrict__', '_Bool'.  Thanks to Richard Henderson.
        * Log modprobe commands in /var/log/ksymoops.  This one's for Wichert.
        * Revert to a single USB table format.  USB maintainers will not support
          anybody on 2.4.0-prerelease or earlier.

This version of modutils is being released under protest.  It
completely drops support for USB device ids on kernel 2.4.0-prerelease
and earlier.  If you are running a kernel before 2.4.0 and you still
want depmod support for USB tables on that earlier kernel, DO NOT
install modutils 2.4.2.  If you are switching between 2.4.0 and earlier
kernels and you want USB support on old and new kernels then you have
to switch versions of modutils when you switch your kernel.

Breaking backwards compatibility goes completely against the grain for
modutils.  It goes to a lot of bother to support users on older kernels
and to ensure that any mix of new modutils and old kernels will work,
even down to kernel 2.0.  The USB maintainers are refusing to support
USB on anything older than 2.4.0, without that support Linus will not
take my kernel patch that maintains backwards compatibility.  So I have
no choice but to break backwards compatibility.

If you applied my kernel patch patch-2.4.0-hotplug, remove it and
reboot after installing modutils 2.4.2.

Note to distributors.  The genksyms change corrects a bug which caused
semi-random symbol checksums, changing the order of include statements
could change the checksum.  As a side effect of the fix, modules
compiled with symbol versions using genksyms < 2.4.2 may not match a
kernel compiled with genksyms >= 2.4.2 and vice versa.  This correction
should only affect binary only modules.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.3 (GNU/Linux)
Comment: Exmh version 2.1.1 10/15/1999

iD8DBQE6bWePi4UHNye0ZOoRAnMsAKDhHRNwFo7sdo0GKcFewM9cXd+gWACfTib5
r3yo+Gv3yDedJCMdkbA4CH0=
=Krng
-----END PGP SIGNATURE-----

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
