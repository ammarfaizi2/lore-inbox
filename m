Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268490AbTBYVuY>; Tue, 25 Feb 2003 16:50:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268505AbTBYVuY>; Tue, 25 Feb 2003 16:50:24 -0500
Received: from impact.colo.mv.net ([199.125.75.20]:39105 "EHLO
	impact.colo.mv.net") by vger.kernel.org with ESMTP
	id <S268490AbTBYVuX>; Tue, 25 Feb 2003 16:50:23 -0500
Message-ID: <3E5BE761.8030202@bogonomicon.net>
Date: Tue, 25 Feb 2003 16:00:01 -0600
From: Bryan Andersen <bryan@bogonomicon.net>
Organization: Bogonomicon
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.0) Gecko/20020623 Debian/1.0.0-0.woody.1
X-Accept-Language: en
MIME-Version: 1.0
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: zImage now holds vmlinux, System.map and config in sections.
 (fwd)
References: <3C6BEE8B5E1BAC42905A93F13004E8AB017DE84C@mailse01.axis.se> <20030225092520.A9257@flint.arm.linux.org.uk> <20030225110704.GD159052@niksula.cs.hut.fi> <20030225113557.C9257@flint.arm.linux.org.uk> <20030225120357.GC158866@niksula.cs.hut.fi>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


>>I, for one, do not see any point in trying to put more and more crap
>>into one file, when its perfectly easy to just use the "cp" command

> Not everybody are always that careful. I know I'm not. I've copied tens of
> kernels to floppy ("cp bzImage /dev/fd0" because it's so easy to do), and
> lost track which one is which. I've copied kernels to other computers, and
> lost track which is which. I've made mistakes copying kernels to /boot, and
> lost track which is which.

These problems are why I now always use shell scripts to do the steps 
that always need to be done.  If I did the steps by hand I'd make a 
mistake atleast once in five times.  I use the standard "make 
modules_install install" to do the kernel install.  I use shell scripts 
to make the kernel and modules before the install and to build and 
install all the nVidia modules after.  This allows me to test a new 
kernel much faster and with much less effort while not forgetting steps 
along the way.  The shell scripts don't need to be all that fancy.  Most 
often the same commands I would type in at the command line.  The one 
that builds and installs the nVidia stuff is just a bunch of cds to 
directories then the make or make install with a "|| exit 2" for exiting 
on failres.  The lines are of the form:

   cd {directory} && make {optional arg} || exit {#}

Areas in {} are replaced with the appropriate values.  The "|| exit" 
code is important because bash will normally continue on when a command 
fails.

- Bryan



