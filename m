Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262692AbRFBU3v>; Sat, 2 Jun 2001 16:29:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262694AbRFBU3l>; Sat, 2 Jun 2001 16:29:41 -0400
Received: from nilpferd.fachschaften.tu-muenchen.de ([129.187.176.79]:38629
	"HELO nilpferd.fachschaften.tu-muenchen.de") by vger.kernel.org
	with SMTP id <S262692AbRFBU33>; Sat, 2 Jun 2001 16:29:29 -0400
Date: Sat, 2 Jun 2001 22:29:21 +0200 (CEST)
From: Adrian Bunk <bunk@fs.tum.de>
X-X-Sender: <bunk@mimas.fachschaften.tu-muenchen.de>
To: <linux-kernel@vger.kernel.org>
Subject: Re: Inconsistent "#ifdef __KERNEL__" on different architectures
In-Reply-To: <20010530003001.A2864@bacchus.dhis.org>
Message-ID: <Pine.NEB.4.33.0106022224480.6994-100000@mimas.fachschaften.tu-muenchen.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 30 May 2001, Ralf Baechle wrote:

> > This is no good.  The ARM kernel just doesn't provide any atomic primitives
> > that will work in user space.  If you want atomicity you have to use
> > libpthread.
>
> Similar on some MIPS processors where the kernel has to implement atomic
> operations because there is no practical possibility to implement them
> in userspace.

Thanks for the answer, this means:
It is specific to the arm, mips, mips64 and sparc ports that atomic_read,
atomic_inc and atomic_dec won't work in user space and they do work on all
other architectures.

(my main concern wasn't whether the "#ifdef __KERNEL__" is correct or not
but I was wondering whether there's a reason why it's different on
different architectures)

>   Ralf

cu
Adrian

-- 
A "No" uttered from deepest conviction is better and greater than a
"Yes" merely uttered to please, or what is worse, to avoid trouble.
                -- Mahatma Ghandi


