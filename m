Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130618AbRCPRcT>; Fri, 16 Mar 2001 12:32:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130673AbRCPRcK>; Fri, 16 Mar 2001 12:32:10 -0500
Received: from think.faceprint.com ([166.90.149.11]:13064 "EHLO
	think.faceprint.com") by vger.kernel.org with ESMTP
	id <S130618AbRCPRbz>; Fri, 16 Mar 2001 12:31:55 -0500
Message-ID: <3AB24DC6.BE0C4D2F@faceprint.com>
Date: Fri, 16 Mar 2001 12:30:46 -0500
From: Nathan Walp <faceprint@faceprint.com>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.2-ac7 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: John Jasen <jjasen1@umbc.edu>
CC: Ian Soboroff <ian@cs.umbc.edu>, linux-kernel@vger.kernel.org
Subject: Re: devfs vs. devpts
In-Reply-To: <Pine.SGI.4.31L.02.0103161039010.205553-100000@irix2.gl.umbc.edu>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

John Jasen wrote:
> 
> On 16 Mar 2001, Ian Soboroff wrote:
> 
> > i don't have devpts mounted under 2.4.2 (debian checks whether you
> > have devfs before mounting devpts), so i tried building my kernel with
> > Unix 98 pty support but without the devpts filesystem.  i get the
> > following error at the very end of 'make bzImage':
> 
> snipped from .config:
> 
> #
> # Character devices
> #
> CONFIG_VT=y
> CONFIG_VT_CONSOLE=y
> CONFIG_SERIAL=y
> # CONFIG_SERIAL_CONSOLE is not set
> # CONFIG_SERIAL_EXTENDED is not set
> # CONFIG_SERIAL_NONSTANDARD is not set
> CONFIG_UNIX98_PTYS=y
> CONFIG_UNIX98_PTY_COUNT=256
> 
> #
> # File systems
> #
> CONFIG_DEVFS_FS=y
> CONFIG_DEVFS_MOUNT=y
> CONFIG_DEVFS_DEBUG=y
> ...
> # CONFIG_DEVPTS_FS is not set
> 
> from my /etc/devfsd.conf, I have:
> REGISTER        pts/.*          MKOLDCOMPAT
> UNREGISTER      pts/.*          RMOLDCOMPAT
> 
> and for permissions:
> REGISTER        pts/.*          IGNORE
> 

I had the same problem, so i added those devfsd lines to my config
files, and everything's peachy now.  I'm thinking it's a debian problem,
cause everything was fine till I ran a dist-upgrade.  I didn't notice it
right away, and I did random kernel stuff before I did notice it.  Ian,
which debian are you running, I'm using sid.

Nathan
