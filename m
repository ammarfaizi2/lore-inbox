Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287871AbSAHBn3>; Mon, 7 Jan 2002 20:43:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287875AbSAHBnT>; Mon, 7 Jan 2002 20:43:19 -0500
Received: from 12-224-37-81.client.attbi.com ([12.224.37.81]:61451 "HELO
	kroah.com") by vger.kernel.org with SMTP id <S287874AbSAHBm7>;
	Mon, 7 Jan 2002 20:42:59 -0500
Date: Mon, 7 Jan 2002 17:41:00 -0800
From: Greg KH <greg@kroah.com>
To: linux-kernel@vger.kernel.org
Cc: dietlibc@fefe.de
Subject: [ANNOUNCE] klibc 0.1 release
Message-ID: <20020108014100.GD10145@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.25i
X-Operating-System: Linux 2.2.20 (i586)
Reply-By: Mon, 10 Dec 2001 21:51:27 -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

As many people have recently realized, it looks like we need to have
some kind of klibc library for the initramfs programs due to problems
with the existing libc implementations (if people disagree with this,
please feel free to speak up.)

With this in mind, I took the work that I did to merge dietLibc into the
dietHotplug build process, and created a first snapshot of a klibc
project.  I have successfully used it to build a version of dietHotplug,
but that's probably about all that will build against the library at
this time :)

It can be found at:
	http://www.kernel.org/pub/linux/kernel/people/gregkh/klibc/klibc-0.1.tar.gz

I'll be working on getting the project hosted on some public CVS site
soon.

Yes, I know this first cut is _very_ ugly, but it's someplace to start
with, and it works for me :)

Here's the README:
-----------------------
This is the start of the klibc project.

Initially it is based on dietLibc <http://www.fefe.de/dietlibc/> but will
probably grow to look quite different from that package.

Goals:
  To provide a small libc that can be used to build userspace binaries that
  will run in the initramfs portion of the kernel boot process.


Only library calls that are _needed_ will be added to klibc.  Right now only the 
calls needed to build and run dietHotplug are present.  Any functions that 
are must have a real need (i.e. some program needs them.)  We aren't going for
POSIX compliance here.

Right now a static library, klibc.a will be built.  If a dynamic library is
found to be needed that functionality will be added.


For this first release, I quickly hacked up what I had done for the dietHotplug
project.  It probably does not build on other architectures, and is probably
missing some functions that you want/need.  Please let me know any problems
that you find, and patches are gladly accepted.
----------------------

thanks,

greg k-h
