Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S284874AbRLPWa0>; Sun, 16 Dec 2001 17:30:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S284879AbRLPWaR>; Sun, 16 Dec 2001 17:30:17 -0500
Received: from ns01.netrox.net ([64.118.231.130]:8139 "EHLO smtp01.netrox.net")
	by vger.kernel.org with ESMTP id <S284874AbRLPWaI> convert rfc822-to-8bit;
	Sun, 16 Dec 2001 17:30:08 -0500
Subject: Re: Is /dev/shm needed?
From: Robert Love <rml@tech9.net>
To: =?ISO-8859-1?Q?Ra=FAlN=FA=F1ez?= de Arenas Coronado 
	<raul@viadomus.com>
Cc: Linux-kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <E16FjME-0000WW-00@DervishD.viadomus.com>
In-Reply-To: <E16FjME-0000WW-00@DervishD.viadomus.com>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
X-Mailer: Evolution/1.0.0.99+cvs.2001.12.10.08.57 (Preview Release)
Date: 16 Dec 2001 17:30:47 -0500
Message-Id: <1008541849.11242.2.camel@phantasy>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2001-12-16 at 17:02, RaúlNúñez de Arenas Coronado wrote:

>     I don't know if /dev/shm (mounted with shmfs or the newer tmpfs)
> is needed for proper SYSV IPC operation with newer (2.4.16 and newer)
> kernel. Anyone can help?

It is not needed.  /dev/shm mounted with tmpfs is only needed for POSIX
shared memory, which is still fairly rare.  SysV IPC will work fine.

>     Moreover: I want to move my /tmp from disk to tmpfs for speed (I
> make a lot of compiling, so I think it would help). Is this a good
> idea? If so, what size can be appropriate for a small system that is
> not permanently running?

Some say it helps, others don't.  Solaris has a similar feature, and it
seems to work for them.  However, Linux is light and our page-cache
works well.  Not so sure it is ideal.

In other words, if you have memory to spare and the data ought to be
cached, Linux probably will cache it anyhow.  On the other hand, if you
have lots of memory to spare, give it a try.  Mount /tmp or all of /var
in tmpfs.

It is dynamic, so you don't need to specify a size.  If you want to give
a maximum size (probably a good idea), give one.  Depends on what your
tmp usages are and how much free memory you have.

	Robert Love

