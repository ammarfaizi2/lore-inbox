Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130791AbQLPGCm>; Sat, 16 Dec 2000 01:02:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129183AbQLPGCX>; Sat, 16 Dec 2000 01:02:23 -0500
Received: from argo.starforce.com ([216.158.56.82]:38315 "EHLO
	argo.starforce.com") by vger.kernel.org with ESMTP
	id <S130472AbQLPGCO>; Sat, 16 Dec 2000 01:02:14 -0500
Date: Sat, 16 Dec 2000 00:31:46 -0500 (EST)
From: Derek Wildstar <dwild+linux_kernel@starforce.com>
X-X-Sender: <dwild@argo.starforce.com>
To: "'Kernel Mailing List '" <linux-kernel@vger.kernel.org>
Subject: Re: Problems compiling test13-pre2
In-Reply-To: <4504FB4A84EFD31196070050DA7E89D003BD15@admin-serv.ufbi.ufl.edu>
Message-ID: <Pine.LNX.4.31.0012160029590.30595-100000@argo.starforce.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I got this also, but the compile worked with nfs/nfsd compiled in.  Same
thing with netfilters.  Problem now is ACPI hung after
initialization...not a hard hang (ctrl/alt/del still worked) but it was
waiting for something it never got.

-dwild

On Sat, 16 Dec 2000, Jon Akers wrote:

> Date: Sat, 16 Dec 2000 00:24:01 -0500
> From: Jon Akers <jka@ufbi.ufl.edu>
> To: 'Kernel Mailing List ' <linux-kernel@vger.kernel.org>
> Subject: Problems compiling test13-pre2
>
> This appears to be a problem with the Makefile changes and NFS/NFSD/lockd
> and module compilation.
>
>
> Using egcs-2.91.66, modutils version 2.3.18, GNU Make version 3.77, GNU ld
> version 2.10.91 (with BFD 2.10.0.33)
>
> make[1]: Leaving directory `/usr/src/linux/arch/i386/lib'
> cd /lib/modules/2.4.0-test13-pre2; \
> mkdir -p pcmcia; \
> find kernel -path '*/pcmcia/*' -name '*.o' | xargs -i -r ln -sf ../{} pcmcia
> if [ -r System.map ]; then /sbin/depmod -ae -F System.map
> 2.4.0-test13-pre2; fidepmod: *** Unresolved symbols in
> /lib/modules/2.4.0-test13-pre2/kernel/fs/nfs/nfs.o
> depmod: 	nlmclnt_proc
> depmod: 	lockd_down
> depmod: 	lockd_up
> depmod: *** Unresolved symbols in
> /lib/modules/2.4.0-test13-pre2/kernel/fs/nfsd/nfsd.o
> depmod: 	nlmsvc_ops
> depmod: 	lockd_down
> depmod: 	nlmsvc_invalidate_client
> depmod: 	lockd_up
>
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> Please read the FAQ at http://www.tux.org/lkml/
>

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
