Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292316AbSCIBPy>; Fri, 8 Mar 2002 20:15:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292284AbSCIBPf>; Fri, 8 Mar 2002 20:15:35 -0500
Received: from burdell.cc.gatech.edu ([130.207.3.207]:2568 "EHLO
	burdell.cc.gatech.edu") by vger.kernel.org with ESMTP
	id <S292289AbSCIBPb>; Fri, 8 Mar 2002 20:15:31 -0500
Date: Fri, 8 Mar 2002 20:15:18 -0500
From: Josh Fryman <fryman@cc.gatech.edu>
To: Christer Weinigel <wingel@acolyte.hack.org>
Cc: davej@suse.de, gone@us.ibm.com, linux-kernel@vger.kernel.org,
        lse-tech@lists.sourceforge.net
Subject: Re: [RFC] modularization of i386 setup_arch and mem_init in 2.4.18
Message-Id: <20020308201518.533dc16a.fryman@cc.gatech.edu>
In-Reply-To: <20020308234811.3F003F5B@acolyte.hack.org>
In-Reply-To: <200203082108.g28L8I504672@w-gaughen.des.beaverton.ibm.com>
	<20020308223330.A15106@suse.de>
	<20020308234811.3F003F5B@acolyte.hack.org>
X-Mailer: Sylpheed version 0.6.5 (GTK+ 1.2.10; sparc-sun-solaris2.7)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


excuse me for intruding a bit, but in the restructuring of kernel 2.5.x, is
there any notion of separating the build directories from the source 
directories?  if you're all hacking up the tree org anyway, this would be a
nice feature... (somewhat like gcc, i guess)

i ask because there are some pci cards i'm tinkering with that run linux
themselves.  it would be nice to go off to /usr/src/linux-x.y.z, and do 
something like this:

   mkdir host
   cd host
   ../make config
   make dep && make bzImage && ...
   cd ..
   mkdir ixp
   cd ixp
   ../make config
   make dep && make bzImage ....

this way i can keep both sets from one source tree.  right now i either
get to make mrproper between builds, or keep dual trees.  if i'm missing
something major in why this isn't practical, feel free to flame :)

just curious.

-josh
