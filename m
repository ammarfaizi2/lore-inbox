Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262619AbRFMSYn>; Wed, 13 Jun 2001 14:24:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262923AbRFMSYc>; Wed, 13 Jun 2001 14:24:32 -0400
Received: from [198.99.130.100] ([198.99.130.100]:35332 "EHLO karaya.com")
	by vger.kernel.org with ESMTP id <S262619AbRFMSYU>;
	Wed, 13 Jun 2001 14:24:20 -0400
Message-Id: <200106131712.NAA01119@karaya.com>
X-Mailer: exmh version 2.1.1 10/15/1999
To: Russ Lewis <russl@lycosmail.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: Has it been done: User Script File System? 
In-Reply-To: Your message of "Wed, 13 Jun 2001 10:39:19 PDT."
             <3B27A546.A64F8B00@lycosmail.com> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Wed, 13 Jun 2001 13:12:34 -0400
From: Jeff Dike <jdike@karaya.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

russl@lycosmail.com said:
> Is there any filesystem in Linux that uses user scripts/executables to
> implement the various function calls?

http://uservfs.sourceforge.net

Also, have a look at the hostfs filesystem in UML.  It implements a virtual 
filesystem which provides access to the host filesystems from inside the 
virtual machine.  The userspace side of it is basically trivial to implement 
and can be used to provide filesystem access to anything on the host that can 
be made to look like a filesystem.

See http://cvs.sourceforge.net/cgi-bin/viewcvs.cgi/user-mode-linux/linux/arch/u
m/fs/hostfs/hostfs_user.c?rev=1.11&content-type=text/vnd.viewcvs-markup for 
the interface that you'd have to implement.

				Jeff


