Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267152AbSLaErr>; Mon, 30 Dec 2002 23:47:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267153AbSLaErr>; Mon, 30 Dec 2002 23:47:47 -0500
Received: from mnh-1-04.mv.com ([207.22.10.36]:18439 "EHLO ccure.karaya.com")
	by vger.kernel.org with ESMTP id <S267152AbSLaErq>;
	Mon, 30 Dec 2002 23:47:46 -0500
Message-Id: <200212310450.XAA05328@ccure.karaya.com>
X-Mailer: exmh version 2.0.2
To: linux-kernel@vger.kernel.org, user-mode-linux-devel@lists.sourceforge.net
Subject: uml-patch-2.5.53-2
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Mon, 30 Dec 2002 23:50:28 -0500
From: Jeff Dike <jdike@karaya.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch brings the UML 2.5 pool up to date with my 2.4 pool.  This includes
many bug fixes and improvements including:

	Kernel stack sizes are configurable.

	UML will build as a shared binary if tt mode is configured out.  These
two changes, plus some valgrind fixes, make it possible to valgrind the kernel.

	skas mode will now force a shutdown if the kernel thread receives a
SIGINT, SIGTERM, or SIGHUP.

	The watchdog driver compiles with skas enabled

	Fixed a problem with excessive stack usage which was causing
crashes for some people

	SA_SIGINFO signal delivery is fixed, making JVMs (and Tomcat) run

	skas mode now has protection against tmpfs filling up

	The initial UML thread is protected against running kernel code

	A couple of data corruption bugs are fixed, including one which
would cause strange behavior changes when 'debug' is added to the command
line.

	All initializers are converted to C99 syntax


NOTE - this patch will not apply to stock 2.5.53.  It was generated against
Linus' BK from yesterday (Dec 29).  It will probably apply cleanly to any 
2.5.53 after my last set of updates were merged.  It certainly will not apply
to any kernel earlier than that.

The 2.5.53-2 UML patch is available at
        http://uml-pub.ists.dartmouth.edu/uml/uml-patch-2.5.53-2.bz2
 
For the other UML mirrors and other downloads, see 
        http://user-mode-linux.sourceforge.net/dl-sf.html
 
Other links of interest:
 
        The UML project home page : http://user-mode-linux.sourceforge.net
        The UML Community site : http://usermodelinux.org
				Jeff

