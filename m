Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131476AbRDCApl>; Mon, 2 Apr 2001 20:45:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131676AbRDCApc>; Mon, 2 Apr 2001 20:45:32 -0400
Received: from tomts6.bellnexxia.net ([209.226.175.26]:24276 "EHLO
	tomts6-srv.bellnexxia.net") by vger.kernel.org with ESMTP
	id <S131476AbRDCApS>; Mon, 2 Apr 2001 20:45:18 -0400
Message-ID: <3AC91B5B.1612945D@coplanar.net>
Date: Mon, 02 Apr 2001 20:37:47 -0400
From: Jeremy Jackson <jerj@coplanar.net>
X-Mailer: Mozilla 4.72 [en] (X11; U; Linux 2.2.14-5.0 i586)
X-Accept-Language: en
MIME-Version: 1.0
To: Jeff Garzik <jgarzik@mandrakesoft.com>
CC: Ian Soboroff <ian@cs.umbc.edu>, linux-kernel@vger.kernel.org
Subject: Re: /proc/config idea
In-Reply-To: <877l13whzw.fsf@danube.cs.umbc.edu> <3AC89389.46317572@coplanar.net> <3AC91800.22D66B24@mandrakesoft.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jeff Garzik wrote:

> Jeremy Jackson wrote:
> > Yes, I like this.  I do this manually, it allows reproducability, and
> > incremental
> > modifications, tracing how that kernel on that problem system was made...
> >
> > I think the ultimate would be to put all of .config (gzipped?) in a new ELF
> > section without the Loadable attribute...  I wish System.map was the same.
> > The you're guaranteed you know how a kernel on disk was configured.
> >
> > To correlate a running kernel to one on disk (vmlinuz) you have LILO...
> > it appends an environment variable to the kernel command line with
> > the name of the file it booted.  This is not infallable, since LILO maps
> > disk sectors, only using the filesystem at map install time.
> >
> > Permaps an md5sum of the .text ELF section would conclusively
> > link the in-core kernel with an on-disk vmlinuz?  Shouldn't be hard
> > to do with objcopy and /proc/kmem?
> [...]
> > Comments anyone?
>
> Instead of doing all this stuff in the kernel, you could simply update
> symlinks to properly installed files at boot time.
>
> Putting _files_ in the kernel is plain silly.  This is unreclaimable

not in the kernel in an ELF section, marked not loadable.  it never leaves the
disk.
as someone else posted, it's ~900 bytes gzipped (if you want to have it in core)

unfortunately (in the LILO case) x86 doesn't boot an ELF image... (oops)

>
> memory, folks.  There is no need to special case an operation as simple

If you have a lot of kernels around, which Config-2.4.3 applies to kernel 2.4.3
given 5 to choose from...the idea (same for System.map) is that it being in the
same
file they can't be confused.  Kinda like forks under Mac (but let's not go there
now)

>
> as reading a file.  [I think this about firmware images too, but that's
> another thread]

