Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315411AbSFJObo>; Mon, 10 Jun 2002 10:31:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315414AbSFJObn>; Mon, 10 Jun 2002 10:31:43 -0400
Received: from chaos.physics.uiowa.edu ([128.255.34.189]:30382 "EHLO
	chaos.physics.uiowa.edu") by vger.kernel.org with ESMTP
	id <S315411AbSFJObn>; Mon, 10 Jun 2002 10:31:43 -0400
Date: Mon, 10 Jun 2002 09:31:42 -0500 (CDT)
From: Kai Germaschewski <kai@tp1.ruhr-uni-bochum.de>
X-X-Sender: kai@chaos.physics.uiowa.edu
To: John Levon <movement@marcelothewonderpenguin.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: External compilation
In-Reply-To: <20020609142602.GA77496@compsoc.man.ac.uk>
Message-ID: <Pine.LNX.4.44.0206100926110.20438-100000@chaos.physics.uiowa.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 9 Jun 2002, John Levon wrote:

> Is there any good example code for compiling a kernel module
> externally, that works for modversions etc. on 2.2, 2.4, and 2.5,
> and does the right thing (including Rules.make) ?

Well, you need the source for the kernel you're building the module for,
it needs to be configured and "make dep" must have been run (for module 
versions).

(You normally can find it by looking into /lib/modules/`uname -r`/kernel 
for the currently running kernel)

Put your module source in some directory, and add a Makefile like

	obj-m := my_module.o

	include $(TOPDIR)/Rules.make

cd into the kernel source and run

	make SUBDIRS=/path/to/your/module modules

--Kai



