Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132609AbRDIDRh>; Sun, 8 Apr 2001 23:17:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132678AbRDIDR2>; Sun, 8 Apr 2001 23:17:28 -0400
Received: from mnh-1-08.mv.com ([207.22.10.40]:60681 "EHLO ccure.karaya.com")
	by vger.kernel.org with ESMTP id <S132609AbRDIDRW>;
	Sun, 8 Apr 2001 23:17:22 -0400
Message-Id: <200104090429.XAA02621@ccure.karaya.com>
X-Mailer: exmh version 2.0.2
To: user-mode-linux-user@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: user-mode port 0.40-2.4.3
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Sun, 08 Apr 2001 23:29:07 -0500
From: Jeff Dike <jdike@karaya.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The user-mode port of 2.4.3 is available.

Added --help and --version, which do the obvious things

UML now creates a /tmp/uml/<name> pid file.  The name can be set with the 
'-umid=<name>' switch.  This is intended to make it easier for a UI to control 
a number of virtual machines.  There is a more general interface coming which 
will replace the pid file with a socket to a low-level console inside UML.

Fixed several major crashes and numerous smaller bugs.  The major fixes 
required some surgery from which UML still hasn't totally recovered, so it's 
still a bit wobbly.  In particular, if it swaps, processes will start 
segfaulting, and the swap code will start spitting out various 
frightening-sounding messages.

A number of hostfs bugfixes and cleanup.  One major new feature here - hostfs 
can now be the root filesystem.  This is done by assigning a directory to a 
ubd device, i.e. 'ubd0=/path/to/uml/root'.  A little bit of magic will cause 
this to be mounted as a hostfs filesystem.  Requirements: hostfs compiled into 
the kernel, /etc/fstab in that filesystem must have the / fs type as hostfs, 
you (the user running UML) must own all the files (they will be magically 
owned by root inside the virtual machine).

modify_ldt is now implemented.

/proc/cmdline is now right.

gdb automatically gets breakpoints set on panic and BUG.

The project's home page is http://user-mode-linux.sourceforge.net

Downloads are available at http://sourceforge.net/project/filelist.php?group_id
=429 and ftp://ftp.nl.linux.org/pub/uml/

				Jeff


