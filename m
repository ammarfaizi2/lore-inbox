Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315539AbSGJLQV>; Wed, 10 Jul 2002 07:16:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315593AbSGJLQU>; Wed, 10 Jul 2002 07:16:20 -0400
Received: from chaos.analogic.com ([204.178.40.224]:49541 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP
	id <S315539AbSGJLQT>; Wed, 10 Jul 2002 07:16:19 -0400
Date: Wed, 10 Jul 2002 07:20:28 -0400 (EDT)
From: "Richard B. Johnson" <root@chaos.analogic.com>
Reply-To: root@chaos.analogic.com
To: Alex Riesen <Alexander.Riesen@synopsys.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] 2.4.19-rc1/2.5.25 provide dummy fsync() routine for directories on NFS mounts
In-Reply-To: <20020710063346.GD32293@riesen-pc.gr05.synopsys.com>
Message-ID: <Pine.LNX.3.95.1020710071047.17737A-100000@chaos.analogic.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 10 Jul 2002, Alex Riesen wrote:

> On Tue, Jul 09, 2002 at 10:06:45AM -0400, Richard B. Johnson wrote:
> > I think code that opens a directory as a file is broken. We have
> > opendir() for that and it returns a DIR pointer, not a file descriptor.
> > If the directory was properly opened, one would never attempt to
> > fsync() it.
> 
> It's the libc which defines it. Theere no syscall "opendir". How you think
> you can return what sus defines as "DIR*" from the kernel?
> 
> offtopic: on aix you can do this: "cat ."
> 

Any attempt to open a directory as a file and read it on Linux up to
version 2.4.18 (at least), or on Sun (up to) SunOS 5.5.1, returns
-1 with errno set to ISDIR (21). As mentioned several times, there
are ways to 'cheat', but I was (and have been) talking about POSIX
conformance.

Script started on Wed Jul 10 07:15:46 2002
# od .
od: .: Is a directory
0000000
# cat .
cat: .: Is a directory
# exit
exit
Script done on Wed Jul 10 07:15:58 2002


Cheers,
Dick Johnson

Penguin : Linux version 2.4.18 on an i686 machine (797.90 BogoMips).

                 Windows-2000/Professional isn't.

