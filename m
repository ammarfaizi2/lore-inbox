Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265074AbTBEW02>; Wed, 5 Feb 2003 17:26:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265077AbTBEW02>; Wed, 5 Feb 2003 17:26:28 -0500
Received: from smtp.actcom.co.il ([192.114.47.13]:53647 "EHLO
	lmail.actcom.co.il") by vger.kernel.org with ESMTP
	id <S265074AbTBEW00>; Wed, 5 Feb 2003 17:26:26 -0500
Date: Thu, 6 Feb 2003 00:36:00 +0200
From: Muli Ben-Yehuda <mulix@mulix.org>
To: Linux-Kernel <linux-kernel@vger.kernel.org>
Subject: ANN: syscalltrack 0.82 "Minty Chinchilla" released
Message-ID: <20030205223600.GD1174@actcom.co.il>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.3i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

syscalltrack-0.82, the 14th alpha release of the Linux kernel system 
call tracker, is now available. syscalltrack supports version 2.4.x of
the Linux kernel on the i386 platform. 

This release containes several new features, bug fixes and cleanups. 

=======================================================================

New in version 0.82, "Minty Chinchilla" 
-----------------------------------------------------------------------

* This release adds support for matching and logging the current
  working directory. "I feel that the '%cwd' macro in logging format
  is really useful since it allows to know if 'open("passwd", ...)'
  relates to '/etc/passwd' rather than '/home/joe/tmp/passwd'." Patch
  from Simon Patarin. 

* This release allocates the memory for kernel logging buffer using
  vmalloc, which allows you to allocate much more memory for them than
  the previous version. Patch from Simon Patarin. 

* This release contains rewritten serialization/deserialization code
  for the rules library. The new code fits better with the overall
  design and is cleaner and more robust. 

* This release contains a bug fix when detecting whether the kernel
  modules are loaded in the user space libraries. Modules should now
  be correctly recognized as loaded/unloaded in all cases. Bug spotted
  by Mike Shea. 

* This release contains a bug fix for sctrace where sctracing a
  program with command line arguments could fail to find the program
  to trace. 

* This release contains several testing improvements, including a new
  regression test script, from Orna Agmon. 

* This release installs the syscalltrack binaries to
  ${prefix}/bin/name-version, to allow several syscalltrack versions
  to coexist. Kernel modules are installed to
  '/lib/modules/kernel-version/syscalltrack-version'. 

=======================================================================

* What is syscalltrack?

syscalltrack is made of a pair of Linux kernel modules and supporting
user space environment which allow interception, logging and possibly
taking action upon system calls that match user defined
criteria. syscalltrack can operate either in "tweezers mode", where
only very specific operations are tracked, such as "only track and log
attempts to delete /etc/passwd", or in strace(1) compatible mode,
where all of the supported system calls are traced. syscalltrack can
do things that are impossible to do with the ptrace mechanism, because
its core operates in kernel space. 

* Where can I get it?

Information on syscalltrack is available on the project's homepage:
http://syscalltrack.sourceforge.net, and in the project's file
release.

The source for the latest version can be downloaded directly from: 
http://osdn.dl.sourceforge.net/sourceforge/syscalltrack/syscalltrack-0.82.tar.gz
or any of the other sourceforge mirrors. 

* Call for developers:

The syscalltrack project is looking for developers, both for kernel
space and user space. If you want to join in on the fun, get in touch
with us on the syscalltrack-hackers mailing list
(http://lists.sourceforge.net/lists/listinfo/syscalltrack-hackers).

* License and NO Warranty

syscalltrack is Free Software, licensed under the GNU General Public
License (GPL) version 2. The 'sct_ctrl_lib' library is licensed under
the GNU Lesser General Public License (LGPL).

syscalltrack is in _alpha_ stages and comes with NO warranty. We put
it through extensive testing and routinely run it on our systems, but
if it breaks something, you get to keep all of the pieces. 

* PGP Signature 

All syscalltrack releases from now on will be signed. This release is
signed with my pgp public key, which you can get from
http://www.mulix.org/pubkey.asc or via 
'gpg --keyserver wwwkeys.pgp.net --recv-keys 0xBFD537CB'

Happy syscalltracking!

-- 
Muli Ben-Yehuda
http://www.mulix.org
http://syscalltrack.sf.net

