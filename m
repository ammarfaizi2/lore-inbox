Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316969AbSFWD6l>; Sat, 22 Jun 2002 23:58:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316970AbSFWD6k>; Sat, 22 Jun 2002 23:58:40 -0400
Received: from line103-203.adsl.actcom.co.il ([192.117.103.203]:7432 "HELO
	alhambra.merseine.nu") by vger.kernel.org with SMTP
	id <S316969AbSFWD6i>; Sat, 22 Jun 2002 23:58:38 -0400
Date: Sun, 23 Jun 2002 06:54:48 +0300
From: Muli Ben-Yehuda <mulix@actcom.co.il>
To: linux-kernel@vger.kernel.org
Subject: ANN: syscalltrack v0.72 "bald hare" released
Message-ID: <20020623065448.Q9997@alhambra.actcom.co.il>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-md5;
	protocol="application/pgp-signature"; boundary="uCozLMBrA/OCc/kF"
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--uCozLMBrA/OCc/kF
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

syscalltrack-0.72, the 8th _alpha_ release of the Linux kernel system
call tracker, is now available. syscalltrack supports versions 2.4.x
of the Linux kernel on the i386 and UML platforms. The current release
contains support for tracking many new system calls (including
fork(2), exit(1), read(3) and write(4)), and various bug fixes and
code cleanups. See details below.

* What is syscalltrack?

syscalltrack is made of a pair of Linux kernel modules and supporting
user space environment which allow interception, logging and possibly
taking action upon system calls that match user defined
criteria. (syscalltrack can be thought of as a hypher-sophisticated,
system wide strace).

* Where can I get it?

Information on syscalltrack is available on the project's homepage:
http://syscalltrack.sourceforge.net, and in the project's file
release.

You can download the source directly from:
http://west.dl.sourceforge.net/sourceforge/syscalltrack/syscalltrack-0.72.t=
ar.gz
or any of the other sourceforge mirrors.=20

* Call for developers:

The syscalltrack project is looking for developers, both for kernel
space and user space. If you want to join in on the fun, get in touch
with us on the syscalltrack-hackers mailing list
(http://lists.sourceforge.net/lists/listinfo/syscalltrack-hackers).

* License and NO Warrany

syscalltrack is Free Software, licensed under the GNU General Public
License (GPL) version 2. The 'sct_ctrl_lib' library is licensed under
the GNU Lesser General Public License (LGPL).

syscalltrack is in _alpha_ stages and comes with NO warranty.
If it breaks something, you get to keep all of the pieces.
You have been warned (TM).

Happy hacking and tracking!

=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D

Major new features for 0.72 (mostly a bug fix and new syscalls release)
-----------------------------------------------------------------------

* Many new system calls supported, including but not limited to
  exit(1), fork(2), read(3) and write(4).=20

* Fixed bug when evaluating a buffer node and a bug with pattern
  matching on a buffer node.=20

* Fixed bug when matching for a constant [filter_expression {1}] to
  return true, as it should, instead of false, as it did.=20

* Fixed several in-kernel memory leaks and erronous kernel string=20
  handling.=20

=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D

Major new features for 0.71 (mostly a bug fix and cleanup release)
------------------------------------------------------------------

* add a 'get rule count' and 'get rules' API to to the
  sct_ctrl_lib. 'get rule count' will return the number of currently
  registered rules, 'get rules' will return to user space from the
  kernel a linked list of the before and after rules for each system
  call. =20

* Support for constants when specifying matching rules, for example,
  O_RDONLY, O_EXCL and friends for open(2).

* Support for octal/hex numbers in filter expressions.=20

* Support for specifying and printing multiplex syscall ids as
  "syscall:func", for example "102:5" for accept(2).=20

* Assorted internal cleanups, code refactoring, bug fixes and memory
  leaks plugged, too many to list here. Documentation and header file
  updates. See the ChangeLog for the gory details.=20

=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D

Major new features for 0.7
--------------------------

* Support for dynamic-cast of 'struct' syscall parameters when filtering
  based on them, and for logging. See the relevant section in
  doc/sct_config_manual.html for how to use this feature. Mostly useful now
  for checking struct parameters in socket calls, so now its possible
  to check if a client prorgam tries to connect to a given port or IP addre=
ss,
  etc.

* Support for 'fail syscall' actions - allows you to specify that a matching
  syscall invocation will prematurely return a given error code (or '0')
  before the system call is actually performed. Handle with care, as failing
  the wrong syscall invocations might render your system unuseable. Good
  usage example: TODO

* Support for convenience-macros in rule config files. Currently supported
  macros include:

    - ipaddr("127.0.0.1") -> translates an IP address to an unsigned long
                             in network byte-order.
    - htons(7) -> host to network byte-order for 'short' numbers.
    - usernametoid("root") -> translates user name to UID.
    - groupnametoid("wheel") -> translates group name to GID.

* Experimental Device-driver control support - the syscalltrack kernel modu=
le
  can now be controlled via a device-file interface - specify "-c device_fi=
le"
  when running 'sct_config' to use it. The interface is currently
  functionaly-equivalent to the existing 'sysctl' interface - but it will be
  enhanced in the future to support logging via a device-file interface,
  getting rule list via the device-file interface, etc.

* Support for 'log_format' definition per rule, to override the global
  'log_format'.

* Initial correctness-testing script added. Currently only runs 2 tests -
  will become more functional on the next release.

* Support for new system calls - waitpid, close and creat.

major bug fixes for version 0.7:

* Fixes for white-space parsing in 'sct_config'.

* Fix small memory leak when deserializing 'log' actions

* Fix bug in the kernel module that would leave dangling function pointers
  in case a user cleared only the 'before' function pointer. This bug
  wasn't triggered, since sct_config always erased _all_ rules, causing this
  code path to remain yet unused.

--=20
http://vipe.technion.ac.il/~mulix/
http://syscalltrack.sf.net/

--uCozLMBrA/OCc/kF
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.7 (GNU/Linux)

iD8DBQE9FUaIKRs727/VN8sRArGqAKCnhLAjjZXgax+Jo8rjUdNaytIqgwCeLNGG
QXWBlXxHSD5Dq0yVK+r7TDo=
=jID3
-----END PGP SIGNATURE-----

--uCozLMBrA/OCc/kF--
