Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317980AbSHaVDB>; Sat, 31 Aug 2002 17:03:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317986AbSHaVDB>; Sat, 31 Aug 2002 17:03:01 -0400
Received: from lmail.actcom.co.il ([192.114.47.13]:51425 "EHLO
	lmail.actcom.co.il") by vger.kernel.org with ESMTP
	id <S317980AbSHaVC6>; Sat, 31 Aug 2002 17:02:58 -0400
Date: Sun, 1 Sep 2002 00:02:24 +0300
From: Muli Ben-Yehuda <mulix@actcom.co.il>
To: Linux-Kernel <linux-kernel@vger.kernel.org>
Subject: ANN: syscalltrack 0.74, "Hyperactive Iguana" released
Message-ID: <20020831210224.GH6399@actcom.co.il>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="o8DTQsiwS+K7TY1f"
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--o8DTQsiwS+K7TY1f
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

syscalltrack-0.74, the 10th _alpha_ release of the Linux kernel system
call tracker, is now available. syscalltrack supports version 2.4.x of
the Linux kernel on the i386 and UML architectures. 2.5.x kernel
versions should work as well, but did not receive the same extensive
testing. Kernel 2.2.x is NOT supported in this release, due to
technical difficulties. This release contains support for almost all
system calls - more than 100 have been added since the last release.

* What is syscalltrack?

syscalltrack is made of a pair of Linux kernel modules and supporting
user space environment which allow interception, logging and possibly
taking action upon system calls that match user defined
criteria. syscalltrack can operate either in "tweezers mode", where
only very specific operations are tracked, such as "only track and log
attempts to delete /etc/passwd", or in strace(1) compatible mode,
where all of the supported system calls are traced. syscalltrack can
do things that are impossible to do with the ptrace mechanism, because
its core operates in kernel space.=20

* Where can I get it?

Information on syscalltrack is available on the project's homepage:
http://syscalltrack.sourceforge.net, and in the project's file
release.

The source for the latest version can be downloaded directly from:=20
http://osdn.dl.sourceforge.net/sourceforge/syscalltrack/syscalltrack-0.74.t=
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

* PGP Signature=20

All syscalltrack releases from now on will be signed. This release is
signed with my pgp public key, which you can get from
http://vipe.technion.ac.il/~mulix/pubkey.asc or via=20
'gpg --keyserver wwwkeys.pgp.net --recv-keys 0xBFD537CB'

Happy hacking and tracking!

=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D

New in version 0.74, "Hyperactive Iguana"
-----------------------------------------------------------------------

* Added a whole lot of new system calls. syscalltrack now supports
  almost all of the system calls available on 2.4.x:=20
  vhangup, wait4, swapoff, sysinfo, fsync, readv, writev, fdatasync,
  msync, getpgid, fchdir, personality, bdflush, flock, setdomainname,
  newuname, modify_ldt, mprotect, sigprocmask, create_module,
  init_module, delete_module, get_kernel_syms, setfsuid16, setfsgid16,
  llseek, quotactl, sysfs, getdents, select, sysctl, mlock, mlockall,
  munlockall, munlockall, sched_setparam, sched_getapram,
  sched_setscheduler, sched_getscheduler, sched_yield,
  sched_get_priority_max, sched_get_priority_min,
  sched_rr_get_interval, nanosleep, mremap, setresuid16, getresuid16,
  query_module, poll, nfsservctl, setresgid16, getresgid16, prctl,
  rt_sigpending, rt_sigtimedwait, rt_sigqueueinfo, chown16, getcwd,
  sendfile,getrlimit, mmap2, stat64, lstat64, fstat64, lchown, getuid,
  getgid, geteuid, getegid, setreuid, setregid, getgroups, setgroups,
  fchown, setresuid, getresuid, setresgid, getresgid, chown, setgid,
  setfsuid, setfsgid, pivot_root, mincore, madvise, getdents64, fnctl64,
  gettid, tkill, sched_setaffinity, sched_getaffinity, sys_olduname
  sys_ustat, old_select, getitimer, setitimer, uname. pread, pwrite,
  truncate64, ftruncate64, readahead.

* Fix a bug where we wouldn't correctly print NULL system call
  parameters. Now we print <NULL>.=20

* Add support for system calls with loff_t and long long parameters.=20

* Fix several bugs in sctrace.=20

* Fix several important bugs in the system call data file parser (used
  in sctrace(1) and sct_config(1)) which prevented valid configuration
  files from being accepted. Added much better error reporting.=20

* Numerous other bug fixes and internal cleanups.=20

=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D

New in version 0.73, "August Penguin"=20
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


--o8DTQsiwS+K7TY1f
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.7 (GNU/Linux)

iD8DBQE9cS7gKRs727/VN8sRAgNTAJoCTzhZAzH+Lq5CiYe+m3MzBGcMfgCeLYc4
zBBkNJ08Y8rB4YxmOMjVgto=
=tUhQ
-----END PGP SIGNATURE-----

--o8DTQsiwS+K7TY1f--
