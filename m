Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288677AbSATPTZ>; Sun, 20 Jan 2002 10:19:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288736AbSATPTQ>; Sun, 20 Jan 2002 10:19:16 -0500
Received: from hermes.fachschaften.tu-muenchen.de ([129.187.176.19]:55773 "HELO
	hermes.fachschaften.tu-muenchen.de") by vger.kernel.org with SMTP
	id <S288677AbSATPS7>; Sun, 20 Jan 2002 10:18:59 -0500
Date: Sun, 20 Jan 2002 16:17:47 +0100 (CET)
From: Adrian Bunk <bunk@fs.tum.de>
X-X-Sender: bunk@mimas.fachschaften.tu-muenchen.de
To: Momchil Velikov <velco@fadata.bg>
cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] __linux__ and cross-compile
In-Reply-To: <87sn919i15.fsf@fadata.bg>
Message-ID: <Pine.NEB.4.44.0201201611030.20948-100000@mimas.fachschaften.tu-muenchen.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 20 Jan 2002, Momchil Velikov wrote:

> >> The following patch fixes compilation/miscompilation problems, which
> >> may happend iwtg variuos cross compile configuration, wherte the
> >> compiler used to compile the kernel does not necessarily define
> >> __linux__. The patch replaces __linux__ with __KERNEL__, using
>
> Adrian> Isn't this a compiler bug?
>
> Why would it be ? I may want to cross-compile from, e.g., NetBSD with
> the host compiler, or I may want compile from GNU/Linux, but with a
>...

If your compiler is configured as a cross-compiler everything should work
as expected. If you are trying to compile a Linux kernel with a gcc that
is configured to build binaries for NetBSD this sounds evil.

> >> __KERNEL_ as an indication that the source is compiled as a part of
> >> ...
>
> Adrian> This is definitely wrong in files that are not Linux-specific and that are
> Adrian> used on FreeBSD (and BSDI) as well (you would know that if you'd looked at
> Adrian> the files your patch changes)...
>
> *BSD define _KERNEL, don't they ?

I don't know (I never tried to compile a *BSD kernel).
But if yes please consider what the following parts of your patch change:

-#ifndef __linux__
+#ifndef __KERNEL__

> Regards,
> -velco

cu
Adrian



