Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130470AbRC0Dvb>; Mon, 26 Mar 2001 22:51:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130466AbRC0DvV>; Mon, 26 Mar 2001 22:51:21 -0500
Received: from adsl-64-163-64-75.dsl.snfc21.pacbell.net ([64.163.64.75]:8977
	"EHLO konerding.com") by vger.kernel.org with ESMTP
	id <S130461AbRC0DvJ>; Mon, 26 Mar 2001 22:51:09 -0500
Message-ID: <3AC00E05.47C264D9@konerding.com>
Date: Mon, 26 Mar 2001 19:50:29 -0800
From: David Konerding <dek_ml@konerding.com>
X-Mailer: Mozilla 4.73 [en] (Win98; U)
X-Accept-Language: en
MIME-Version: 1.0
To: Jason Madden <jmadden@spock.shacknet.nu>
CC: linux-kernel@vger.kernel.org
Subject: Re: "mount -o loop" lockup issue
In-Reply-To: <Pine.LNX.4.21.0103262125400.8769-100000@spock.shacknet.nu>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

It's a bug in Linux 2.4.2, fixed in later versions.  Regression/quality control
testing would
have caught this, but the developers usually just break things and wait for people
to complain
as their "Regression" testers.

Jason Madden wrote:

> On Mon, 26 Mar 2001, David E. Weekly wrote:
>
> > On Linux 2.4.2, running a "mount -o loop" on a file properly created with
> > "dd if=/dev/zero of=/path/to/my/file.img count=1024" seems to decide to
> > freeze up my shell (not my system). An strace showed the lockup happening at
> > the actual system "mount()" call, which never returns.
> >
> > Since mount() is in glibc, it might be relevant to note that I'm running
> > Mandrake's glibc 2.1.3-16mdk. I compiled the kernel with a gcc of 2.95.3
> > [1991030] (although oddly enough this binary seems to have come with the
> > gcc-2.95.2 RPM and installed itself as /usr/bin/gcc-2.95.2) and binutils
> > 2.10.0.24-4mdk.
> I also experience this problem (using a floppy disk image created by
> dd if=/dev/fd0 of=floppy.img bs=1024, and then mount -o loop
> floppy.img /mnt/floppy ) with a different version
> of glibc (RedHat's 2.1.92-5 rpm) and binutils (binutils-2.10.0.18-1). Loop
> is compiled into the kernel.
>
> Once the mount command was executed, my load average shot up to a steady
> 1.0 on an idle system, and remained there until I rebooted. top
> et. al. showed no cpu utilization by the frozen mount.
>
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/

