Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315451AbSFJPNF>; Mon, 10 Jun 2002 11:13:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315454AbSFJPNE>; Mon, 10 Jun 2002 11:13:04 -0400
Received: from probity.mcc.ac.uk ([130.88.200.94]:18950 "EHLO
	probity.mcc.ac.uk") by vger.kernel.org with ESMTP
	id <S315451AbSFJPND>; Mon, 10 Jun 2002 11:13:03 -0400
Date: Mon, 10 Jun 2002 16:12:47 +0100
From: John Levon <movement@marcelothewonderpenguin.com>
To: Kai Germaschewski <kai@tp1.ruhr-uni-bochum.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: External compilation
Message-ID: <20020610151246.GA13626@compsoc.man.ac.uk>
In-Reply-To: <20020609142602.GA77496@compsoc.man.ac.uk> <Pine.LNX.4.44.0206100926110.20438-100000@chaos.physics.uiowa.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.3.25i
X-Url: http://www.movementarian.org/
X-Record: Bendik Singers - Afrotid
X-Toppers: N/A
X-Scanner: exiscan *17HQqg-0003h1-00*zprFEpd5H8A* (Manchester Computing, University of Manchester)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 10, 2002 at 09:31:42AM -0500, Kai Germaschewski wrote:

> Well, you need the source for the kernel you're building the module for,
> it needs to be configured and "make dep" must have been run (for module 
> versions).

Obviously :)

I already have stuff working fine w/o the Rules.make include, I'm just
trying to do the "right thing"

> 	obj-m := my_module.o
> 
> 	include $(TOPDIR)/Rules.make
> 
> cd into the kernel source and run
> 
> 	make SUBDIRS=/path/to/your/module modules

Doesn't work for 2.2. Hopefully I will be able to specify M_OBJS in
addition.

Also, you don't specify O_TARGET ?

Given :

TOPDIR=/usr/src/linux
THISDIR=/tmp/mod
 
O_TARGET=lartmod.o
obj-m := lart.o blah.o
 
include $(TOPDIR)/Rules.make
 
all:
        (cd $(TOPDIR) && $(MAKE) SUBDIRS=/tmp/mod modules)


a) default target for Rules.make doesn't do anything useful
b) lartmod.o is never made (how could I convince it to ?)
c) is this going to work OK for modversions...
d) the above seems to disallow a lart.c forming only part of a final lart.o target
e) there seems something is going horribly wrong :

moz mod 317 make all
make: execvp: /usr/src/linux/scripts/pathdown.sh: Permission denied
ˆ¶@ˆ¶@re/locale/en_US/LC_MESSAGES/make.mo(cd /usr/src/linux && make SUBDIRS=/tmp/mod modules)
make[1]: Entering directory `/usr/src/linux-2.4.0'

The above problems is why I asked for working examples :)

regards
john

-- 
"I continue to be amazed at what Andrei can make templates do. Some of it
 still makes my head hurt."
	- Herb Sutter
