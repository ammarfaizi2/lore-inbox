Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S274815AbRIZDd0>; Tue, 25 Sep 2001 23:33:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S274816AbRIZDdQ>; Tue, 25 Sep 2001 23:33:16 -0400
Received: from mnh-1-10.mv.com ([207.22.10.42]:48136 "EHLO ccure.karaya.com")
	by vger.kernel.org with ESMTP id <S274815AbRIZDdG>;
	Tue, 25 Sep 2001 23:33:06 -0400
Message-Id: <200109260451.XAA04821@ccure.karaya.com>
X-Mailer: exmh version 2.0.2
To: user-mode-linux-user@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: user-mode port 0.47-2.4.10
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Tue, 25 Sep 2001 23:51:09 -0500
From: Jeff Dike <jdike@karaya.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The user-mode port of 2.4.10 is available.

The highlights:

UML can now communicate with the host networking via TUN/TAP.

libc's allocation routines (malloc, calloc, free) are intercepted and 
converted into kmalloc whenever possible.  This fixes problems with gprof
and gcov, and closes a potential security hole.

UML loads itself into the top of the address space (0xa0000000-0xc0000000 on
1G/3G hosts), giving its processes everything below that.  This fixes a bug
which caused nasty-looking complaints when UML was given 256M of physical 
memory or more.  I've run it with up to 464M.  This also fixes the hang
caused by mlockall.

The mconsole client has been enhanced, so it now had command history and
command recall, it can control multiple UMLs, and can attached to a UML by
its name rather than the full filename of its control socket.

uml_net does complete setup of TUN/TAP interfaces.  It also insmods netlink_dev
for the benefit of ethertap.

The ubd COW header now has room for MAXPATHLEN-sized filenames, it contains
absolute paths only, and is in network byte order.  The ubd driver handles
IO errors better now, and should be 64-bit clean.

The process segfaults seen on a swapping system are gone.

The project's home page is http://user-mode-linux.sourceforge.net

Downloads are available at 
	http://user-mode-linux.sourceforge.net/dl-sf.html

				Jeff

