Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316503AbSHARo4>; Thu, 1 Aug 2002 13:44:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316519AbSHARo4>; Thu, 1 Aug 2002 13:44:56 -0400
Received: from mail.actcom.co.il ([192.114.47.13]:6329 "EHLO
	lmail.actcom.co.il") by vger.kernel.org with ESMTP
	id <S316503AbSHARoy>; Thu, 1 Aug 2002 13:44:54 -0400
Date: Thu, 1 Aug 2002 20:43:38 +0300
From: Muli Ben-Yehuda <mulix@actcom.co.il>
To: Linux-Kernel <linux-kernel@vger.kernel.org>
Subject: ANN: syscalltrack 0.73 "August Penguin" released
Message-ID: <20020801174338.GH7912@alhambra.actcom.co.il>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="ZPDwMsyfds7q4mrK"
Content-Disposition: inline
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--ZPDwMsyfds7q4mrK
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

syscalltrack-0.73, the 9th _alpha_ release of the Linux kernel system
call tracker, is now available. syscalltrack supports version 2.4.x of
the Linux kernel on the i386 and UML architectures. Kernel versions
2.2.x and 2.5.x should work as well, but did not receive the same
extensive testing. The current release contains a new experimental
strace compatible tool, sctrace, a logging device file, several bug
fixes and many new system calls, including all of the IPC
syscalls. More details below.

* What is syscalltrack?

syscalltrack is made of a pair of Linux kernel modules and supporting
user space environment which allow interception, logging and possibly
taking action upon system calls that match user defined
criteria. syscalltrack can operate either in "tweezers mode", where
only very specific operations are tracked, such as "only track and log
to delete /etc/passwd", or in strace(1) compatible mode, where all of
the supported system calls are traced. syscalltrack can do things that
are impossible to do with the ptrace mechanism, because its core
operates in kernel space.=20

* Where can I get it?

Information on syscalltrack is available on the project's homepage:
http://syscalltrack.sourceforge.net, and in the project's file
release.

The source for the latest version can be downloaded directly from:=20
http://osdn.dl.sourceforge.net/sourceforge/syscalltrack/syscalltrack-0.73.t=
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

syscalltrack is in _alpha_ stages and comes with NO warranty. We put
it through extensive testing and routinely run it on our systems, but
if it breaks something, you get to keep all of the pieces.=20

Happy hacking and tracking!

=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D

New in version 0.73, "august penguin"=20
-----------------------------------------------------------------------

* Added sctrace, an experimental strace(1) compatible tool based on
  the syscalltrack framework. 'sctrace command' or 'sctrace -p pid'
  will load rules matching the given executable (or pid) for all
  supported system calls and log their invocation to the log file (or
  log device).=20

* experimental logging device file, /dev/sct_log, and a utility to
  control its behaviour, sct_logctrl. syscalltrack can now log system
  call invocation either to syslog or directly to a device
  file. Note that the format of information logged to the device file
  will change in future versions (from text based to a binary
  protocol).

* Fixed a bug in the automatic code generated for system call stubs
  for system calls which have a pointer parameter. This bug exists in
  older syscalltrack versions and while it's harmless, users are still
  encouraged to upgrade.

* Fixed a bug in the kernel module reference counting code when
  deleting a single rule. This code path wasn't in use until
  recently.=20

* Fix wrong usage of size_t and other portability cleanups. Fix
  strstream/stringstream usage to work with gcc version before 3 and
  after 3.

* Support all of the IPC system calls (contributed by Gilad
  Ben-Yossef).=20

* More new syscalls: execve, statfs, fstatfs, newstat, newlstat,
  newfstat, getrusage, getgroups16, old_readdir and old_mmap.=20

* a proof-of-concept GUI tool, gtksct(1).

* new man pages, courtesy of Baruch Even for the debian package of
  syscalltrack.=20

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

--ZPDwMsyfds7q4mrK
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.7 (GNU/Linux)

iD8DBQE9SXNKKRs727/VN8sRApSyAKCfb0b8+UXlb5mv1L3/yB9UM1SxswCfdfPB
RM4/B/mkzhq3ywEvdT6OOFk=
=NsPY
-----END PGP SIGNATURE-----

--ZPDwMsyfds7q4mrK--
