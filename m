Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130439AbRC0DbY>; Mon, 26 Mar 2001 22:31:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130461AbRC0DbN>; Mon, 26 Mar 2001 22:31:13 -0500
Received: from fe2.rdc-kc.rr.com ([24.94.163.49]:52496 "EHLO mail2.mmcable.com")
	by vger.kernel.org with ESMTP id <S130439AbRC0Daz>;
	Mon, 26 Mar 2001 22:30:55 -0500
Date: Mon, 26 Mar 2001 21:31:55 -0600 (CST)
From: Jason Madden <jmadden@spock.shacknet.nu>
To: linux-kernel@vger.kernel.org
Subject: Re: "mount -o loop" lockup issue
In-Reply-To: <019501c0b661$1de195a0$5c044589@legato.com>
Message-ID: <Pine.LNX.4.21.0103262125400.8769-100000@spock.shacknet.nu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 26 Mar 2001, David E. Weekly wrote:

> On Linux 2.4.2, running a "mount -o loop" on a file properly created with
> "dd if=/dev/zero of=/path/to/my/file.img count=1024" seems to decide to
> freeze up my shell (not my system). An strace showed the lockup happening at
> the actual system "mount()" call, which never returns.
> 
> Since mount() is in glibc, it might be relevant to note that I'm running
> Mandrake's glibc 2.1.3-16mdk. I compiled the kernel with a gcc of 2.95.3
> [1991030] (although oddly enough this binary seems to have come with the
> gcc-2.95.2 RPM and installed itself as /usr/bin/gcc-2.95.2) and binutils
> 2.10.0.24-4mdk.
I also experience this problem (using a floppy disk image created by
dd if=/dev/fd0 of=floppy.img bs=1024, and then mount -o loop
floppy.img /mnt/floppy ) with a different version
of glibc (RedHat's 2.1.92-5 rpm) and binutils (binutils-2.10.0.18-1). Loop
is compiled into the kernel.

Once the mount command was executed, my load average shot up to a steady
1.0 on an idle system, and remained there until I rebooted. top
et. al. showed no cpu utilization by the frozen mount.


