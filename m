Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S276779AbRJPWTt>; Tue, 16 Oct 2001 18:19:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S276782AbRJPWTk>; Tue, 16 Oct 2001 18:19:40 -0400
Received: from lmail.actcom.co.il ([192.114.47.13]:9375 "EHLO
	lmail.actcom.co.il") by vger.kernel.org with ESMTP
	id <S276779AbRJPWT3>; Tue, 16 Oct 2001 18:19:29 -0400
Date: Wed, 17 Oct 2001 00:20:00 +0200 (EET)
From: guy keren <choo@actcom.co.il>
To: <linux-kernel@vger.kernel.org>
Subject: ANN: syscalltrack version 0.63
Message-ID: <Pine.GSU.4.30_heb2.09.0110170018470.17731-100000@actcom.co.il>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Haifux, the Haifa Linux Club (http://linuxclub.il.eu.org) is proud to
present 'syscalltrack-0.63', the second _alpha_ release of the
system-call-tracking linux kernel module and user space
utilities. syscalltrack supports both versions 2.2.x and 2.4.x of
the linux kernel.

* What is syscalltrack?

syscalltrack is a linux kernel module and supporting user space
environment which allow interception, logging and possibly taking
action upon system calls that match user defined criteria
(syscalltrack can be thought of as a sophisticated, system wide
strace).

* Where can i get it?

Information on syscalltrack is available on the project's homepage:
http://syscalltrack.sourceforge.net, and in the project's file
release.

You can download the source directly from:
http://prdownloads.sourceforge.net/syscalltrack/syscalltrack-0.63.tar.gz

* Call for developers:

The syscalltrack project is looking for developers, both for kernel
space and user space. If you want to join in on the fun, get in touch
with us on the 'syscalltrack-hackers' mailing list
(http://lists.sourceforge.net/lists/listinfo/syscalltrack-hackers).

* License and NO Warrany

'syscalltrack' is Free Software, licensed under the GNU General Public
License (GPL) version 2. The 'sct_ctrl_lib' library is licensed under
the GNU Lesser General Public License (LGPL).

'syscalltrack' is in early _alpha_ stages and comes with NO
warranty. If it breaks something, you get to keep all of the
pieces. You have been warned (TM).

Happy hacking and tracking!


Major new features for 0.63
---------------------------

* User defined logging format: it is now possible to define the format
  the log message will take. The default log format is

    syscall: %pid[%comm]: %sid_%sname(%params) (rule %ruleid)

  For example, let us consider an invocation of the 'mkdir' system call:

    syscall: 876[mkdir]: 39_mkdir("foo", 509) (rule 1)

* Validity checks on system call parameters: sct_config now makes it
  easier to catch rule file erros by making sure that the parameter,
  operand and operator are of matching types. Validity checks are
  implemented for 'param_condition' and 'process_condition' directives
  only.

* Experimental filter expression: sct_config now allows writing clear,
  concise filter expressions. Here's a filter expression to match a
  system call invocation where the user is root (uid 0) and the first
  parameter contains "passwd":

  filter_expression: (UID == 0) && (PARAMS[1] ~= "passwd")

  (This feature is experimental and does minimal input validation at
  the moment).

* Support for structure parameters: you can now match system calls
  which get a structure as one of their parameters - for example,
  settimeofday(), which gets a 'struct timeval' and 'struct timezone'
  parameters.

* Support for (more) process parameters: we now support the following
  process parameters: UID, EUID, SUID, GID, EGID, SGID, PID,
  COMM. Special attention should be given to COMM, which allows matching
  on the name of the program the process is executing.

* Improved sct_config error diagnostics: sct_config now gives clear,
  concise message on configuration file errors, with line numbers for
  easier rule file debugging.

* syscalltrack should compile with the latest 2.2 kernel and every 2.4
  kernel, and has been tested with at least 2.2.19, 2.4.5, 2.4.9,
  2.4.10, 2.4.10-ac11 2.4.12, 2.4.12-ac3 and 2.4.12-um3.

* Additional compilation and run time test programs.

major bug fixes for version 0.63:

* memory leaks in the kernel plugged and eradicated.

--
guy

"For world domination - press 1,
 or dial 0, and please hold, for the creator." -- nob o. dy

