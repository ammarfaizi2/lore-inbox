Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130565AbRCPPoL>; Fri, 16 Mar 2001 10:44:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130570AbRCPPoC>; Fri, 16 Mar 2001 10:44:02 -0500
Received: from mx3out.umbc.edu ([130.85.253.53]:19849 "EHLO mx3out.umbc.edu")
	by vger.kernel.org with ESMTP id <S130565AbRCPPnz>;
	Fri, 16 Mar 2001 10:43:55 -0500
Date: Fri, 16 Mar 2001 10:43:13 -0500
From: John Jasen <jjasen1@umbc.edu>
X-X-Sender: <jjasen1@irix2.gl.umbc.edu>
To: Ian Soboroff <ian@cs.umbc.edu>
cc: <linux-kernel@vger.kernel.org>
Subject: Re: devfs vs. devpts
In-Reply-To: <87vgp9zv28.fsf@danube.cs.umbc.edu>
Message-ID: <Pine.SGI.4.31L.02.0103161039010.205553-100000@irix2.gl.umbc.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 16 Mar 2001, Ian Soboroff wrote:

> i don't have devpts mounted under 2.4.2 (debian checks whether you
> have devfs before mounting devpts), so i tried building my kernel with
> Unix 98 pty support but without the devpts filesystem.  i get the
> following error at the very end of 'make bzImage':

snipped from .config:

#
# Character devices
#
CONFIG_VT=y
CONFIG_VT_CONSOLE=y
CONFIG_SERIAL=y
# CONFIG_SERIAL_CONSOLE is not set
# CONFIG_SERIAL_EXTENDED is not set
# CONFIG_SERIAL_NONSTANDARD is not set
CONFIG_UNIX98_PTYS=y
CONFIG_UNIX98_PTY_COUNT=256

#
# File systems
#
CONFIG_DEVFS_FS=y
CONFIG_DEVFS_MOUNT=y
CONFIG_DEVFS_DEBUG=y
...
# CONFIG_DEVPTS_FS is not set

from my /etc/devfsd.conf, I have:
REGISTER        pts/.*          MKOLDCOMPAT
UNREGISTER      pts/.*          RMOLDCOMPAT

and for permissions:
REGISTER        pts/.*          IGNORE

uname -a:
Linux grim 2.4.2-ac18 #3 SMP Mon Mar 12 12:05:18 EST 2001 i686 unknown

--
-- John E. Jasen (jjasen1@umbc.edu)
-- In theory, theory and practise are the same. In practise, they aren't.

