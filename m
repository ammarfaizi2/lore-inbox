Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129107AbQJ3KxX>; Mon, 30 Oct 2000 05:53:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129087AbQJ3KxN>; Mon, 30 Oct 2000 05:53:13 -0500
Received: from fe3.rdc-kc.rr.com ([24.94.163.50]:46861 "EHLO mail3.kc.rr.com")
	by vger.kernel.org with ESMTP id <S129045AbQJ3KxD>;
	Mon, 30 Oct 2000 05:53:03 -0500
Message-Id: <m13qCYf-001qifC@microdog>
Date: Mon, 30 Oct 2000 04:52:53 -0600 (CST)
From: mkc@users.sourceforge.net
To: subterfugue-announce@lists.sourceforge.net
Cc: linux-kernel@vger.kernel.org
Subject: [ANNOUNCE] SUBTERFUGUE 0.1.99
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

SUBTERFUGUE 0.1.99 is available.  It's been updated to work with the latest
kernel (linux-2.4.0-test9), and there are new tricks, documentation, and a
Debian package.  (see below)

As always, feedback is welcome.

Have fun!
- --Mike


==============================================================================
NEWS:

Version 0.1.99 ("superstar")

* Added a fix to make SUBTERFUGUE work again with the latest 2.4 kernels.
  Made usage of the "wait channel hack" the default, for vanilla 2.4 users.

* Added two new tricks, NetThrottle and TimeWarp, which you can see in action
  now at the bottom of the screenshots page
  (http://subterfugue.org/screenshot.html).  NetThrottle, in particular, seems
  like it would be handy for everyday use.  (TimeWarp is more of an amusement,
  though it might help you cheat at certain arcade games.  :-)

* Added a polished version of the SUBTERFUGUE motivation document to the web
  site (http://subterfugue.org/motivation.html).  Comments welcome.  It's
  pretty over-the-top.  Does it sound like it was composed in a remote Montana
  cabin?  :-0

* Added a man page for sf(1), based on Pavel Machek's original draft.

* Added an 'install' target and Debianization.  A Debian package will be
  available with this release.  It hasn't been tested much yet, but it's
  probably pretty safe.

* Reorganized the C extension modules.

* Generally dusted off all of the cobwebs.  SUBTERFUGUE lives!


==============================================================================
README:

This is SUBTERFUGUE.  See 'NEWS' for info on the latest release.

SUBTERFUGUE is a framework for observing and playing with the reality of
software; it's a foundation for building tools to do tracing, sandboxing, and
many other things.  You could think of it as "strace meets expect."

Here's a short (real) "screenshot" which hints at one of its possible uses:

    # sf --trick=SimplePathSandbox:"read=['/'];write=['/dev/tty'];net=1" bash
    # id
    uid=0(root) gid=0(root) groups=0(root)
    # rm -f /etc/passwd
    write deny (unlink): '/etc/passwd'
    rm: cannot unlink `/etc/passwd': Permission denied


BEWARE: This is an alpha release.  Don't run this as root, except on a scratch
system.  Don't use it to run programs where a loss of state might be
disastrous (e.g., fetchmail).  Consider yourself warned.

See 'http://subterfugue.org' and the sf(1) man page for more info.


-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.4 (GNU/Linux)
Comment: Processed by Mailcrypt 3.5.5 and Gnu Privacy Guard <http://www.gnupg.org/>

iD8DBQE5/VKyHxpYi0vMj/QRAjL/AKClNUGMEevtvFil9TTAd5ykPblVQQCgtFuG
btTp1IdqYi6lfWDzUwgh8cQ=
=5N9W
-----END PGP SIGNATURE-----
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
