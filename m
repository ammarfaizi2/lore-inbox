Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317587AbSGEVnx>; Fri, 5 Jul 2002 17:43:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317589AbSGEVnw>; Fri, 5 Jul 2002 17:43:52 -0400
Received: from mnh-1-16.mv.com ([207.22.10.48]:56837 "EHLO ccure.karaya.com")
	by vger.kernel.org with ESMTP id <S317587AbSGEVnw>;
	Fri, 5 Jul 2002 17:43:52 -0400
Message-Id: <200207052250.RAA03199@ccure.karaya.com>
X-Mailer: exmh version 2.0.2
To: linux-kernel@vger.kernel.org, user-mode-linux-user@lists.sourceforge.net
Subject: user-mode port 0.58-2.4.18-36
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Fri, 05 Jul 2002 17:50:17 -0500
From: Jeff Dike <jdike@karaya.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is the fourth release of the 2.4.18 UML.

The major changes in this release include:

	It is now possible the to attach the UML gdb to sleeping threads.
	This is done by detaching gdb from the in-context thread and attaching
	it to the host pid of the sleeping UML process.  UML may be continued
	by reattaching to the in-context thread.  This feature was sponsored
	by Cluster File Systems, Inc.

	There is a /proc/exitcode, which allows a UML process to set the
	eventual UML exit code.

	Fixed some segfaults caused by calling openpty, which has an unusually
	large stack frame, overflowing the UML kernel stack.

	The tty logging patch is integrated.  This allows UML honeypots to
	log all tty traffic to a host file.  This logging can't be detected
	or interfered with by root inside the UML.

	UML now has a "hardware" watchdog.

	The UML binary now lives in its own physical memory.  This makes it
	easier for the swsusp patch to be ported to UML.

	Fixed a bug with lots of zombies causing a UML panic.

	It is now possible to move backing files and update the COW files with	
	ubdx=cow-file,new-backing-file.  Note that you must preserve the
	modification time when moving a backing file with something like 
	'cp -p' or 'tar p'. 

	Added support for kernel watchpoints.  They can be mixed with 
	watchpoints in gdb inside UML.  

	Fixed the bug which was closing file descriptors which should have
	been left open.  This was most often seen as a panic during UML
	shutdown, although it also appeared in other places.

	The mconsole driver now sends panic notifications to mconsole clients.

	A number of smaller bugs were fixed and features added.

The project's home page is http://user-mode-linux.sourceforge.net

Downloads are available at 
	http://user-mode-linux.sourceforge.net/dl-sf.html

				Jeff

