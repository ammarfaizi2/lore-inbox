Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288662AbSATPJO>; Sun, 20 Jan 2002 10:09:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288664AbSATPJF>; Sun, 20 Jan 2002 10:09:05 -0500
Received: from [217.9.226.246] ([217.9.226.246]:8068 "HELO
	merlin.xternal.fadata.bg") by vger.kernel.org with SMTP
	id <S288662AbSATPIz>; Sun, 20 Jan 2002 10:08:55 -0500
To: Adrian Bunk <bunk@fs.tum.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] __linux__ and cross-compile
In-Reply-To: <Pine.NEB.4.44.0201201519460.20948-100000@mimas.fachschaften.tu-muenchen.de>
From: Momchil Velikov <velco@fadata.bg>
In-Reply-To: <Pine.NEB.4.44.0201201519460.20948-100000@mimas.fachschaften.tu-muenchen.de>
Date: 20 Jan 2002 17:08:38 +0200
Message-ID: <87sn919i15.fsf@fadata.bg>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.1
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> "Adrian" == Adrian Bunk <bunk@fs.tum.de> writes:

Adrian> On 20 Jan 2002, Momchil Velikov wrote:
>> Hi there,
>> 
>> The following patch fixes compilation/miscompilation problems, which
>> may happend iwtg variuos cross compile configuration, wherte the
>> compiler used to compile the kernel does not necessarily define
>> __linux__. The patch replaces __linux__ with __KERNEL__, using

Adrian> Isn't this a compiler bug?

Why would it be ? I may want to cross-compile from, e.g., NetBSD with
the host compiler, or I may want compile from GNU/Linux, but with a
compiler like arm-elf-gcc, that is, generic arm cross compiler, used
for other kernels too.

>> __KERNEL_ as an indication that the source is compiled as a part of
>> ...

Adrian> This is definitely wrong in files that are not Linux-specific and that are
Adrian> used on FreeBSD (and BSDI) as well (you would know that if you'd looked at
Adrian> the files your patch changes)...

*BSD define _KERNEL, don't they ?

Regards,
-velco
