Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S275671AbRJJNAn>; Wed, 10 Oct 2001 09:00:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S275675AbRJJNAd>; Wed, 10 Oct 2001 09:00:33 -0400
Received: from chaos.analogic.com ([204.178.40.224]:3201 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP
	id <S275671AbRJJNAV>; Wed, 10 Oct 2001 09:00:21 -0400
Date: Wed, 10 Oct 2001 09:00:32 -0400 (EDT)
From: "Richard B. Johnson" <root@chaos.analogic.com>
Reply-To: root@chaos.analogic.com
To: Keith Owens <kaos@ocs.com.au>
cc: Horst von Brand <vonbrand@inf.utfsm.cl>, linux-kernel@vger.kernel.org
Subject: Re: kernel size 
In-Reply-To: <7568.1002677371@kao2.melbourne.sgi.com>
Message-ID: <Pine.LNX.3.95.1011010084118.8134B-100000@chaos.analogic.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 10 Oct 2001, Keith Owens wrote:

> On Tue, 9 Oct 2001 11:53:48 -0400 (EDT), 
> "Richard B. Johnson" <root@chaos.analogic.com> wrote:
> >Yes. It shows in /proc/kcore. Just wasted. It does mean something
> >on an embedded system.
> 
> kcore shows all the kernel buffers, including user space stuff being
> processed by the loader.  My tests show that all the strings that you
> are complaining about have been stripped from the kernel before it is
> loaded.
> 

Yes... but.  The final test was using bzImage which became about 1k
shorter after making the changes to vmlinux.lds.

total 748
drwxr-xr-x   4 root     101          4096 Oct  9 13:49 .
drwxr-xr-x   7 root     101          4096 Jan 11  2001 ..
-rw-r--r--   1 root     101          2799 Dec 20  1999 Makefile
-rwxr-xr-x   1 root     root          512 Oct  9 13:32 bbootsect
-rw-r--r--   1 root     root         2352 Oct  9 13:32 bbootsect.o
-rw-r--r--   1 root     root         7981 Oct  9 13:32 bbootsect.s
-rw-r--r--   1 root     101          9644 Jan 29  2001 bootsect.S
-rwxr-xr-x   1 root     root         4501 Oct  9 13:49 bsetup
-rw-r--r--   1 root     root        11704 Oct  9 13:49 bsetup.o
-rw-r--r--   1 root     root        44212 Oct  9 13:49 bsetup.s
-rw-r--r--   1 root     root       575432 Oct  9 13:49 bzImage
-rw-r--r--   1 root     root       581384 Oct  1 13:27 bzImage.OLD
drwxr-xr-x   2 root     101          4096 Oct  9 13:49 compressed
-rw-r--r--   1 root     101           904 Jan  3  1995 install.sh
-rw-r--r--   1 root     101         23458 Jan 27  2001 setup.S
drwxr-xr-x   2 root     101          4096 Oct  9 13:32 tools
-rw-r--r--   1 root     101         39023 Nov 21  1999 video.S


The size change of the raw image is even more evident:

-rwxr-xr-x   1 root     root      1548916 Oct  9 13:49 vmlinux
-rwxr-xr-x   1 root     root      1590692 Oct  1 13:26 vmlinux.OLD


I did not look at any other scripts that are involved in making
the image.

Also I was not complaining about anything. One respondent noted
that compiling the kernel with a new 'C' compiler resulted in
a large increase in kernel size. Some of us then attempted to
find out simple ways to get the kernel size back down. I showed
that some 'C' compiler versions have enormous ID strings that
are wasting space. I also mentioned that some versions align
everything on 16-byte boundaries and there doesn't seem to
be any way to turn off this 'feature'.

Cheers,
Dick Johnson

Penguin : Linux version 2.4.1 on an i686 machine (799.53 BogoMips).

    I was going to compile a list of innovations that could be
    attributed to Microsoft. Once I realized that Ctrl-Alt-Del
    was handled in the BIOS, I found that there aren't any.


