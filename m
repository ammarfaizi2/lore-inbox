Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129063AbQJaTjr>; Tue, 31 Oct 2000 14:39:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129069AbQJaTjh>; Tue, 31 Oct 2000 14:39:37 -0500
Received: from pincoya.inf.utfsm.cl ([200.1.19.3]:61959 "EHLO
	pincoya.inf.utfsm.cl") by vger.kernel.org with ESMTP
	id <S129063AbQJaTjT>; Tue, 31 Oct 2000 14:39:19 -0500
Message-Id: <200010311938.e9VJc0315960@pincoya.inf.utfsm.cl>
To: Riley Williams <rhw@MemAlpha.CX>,
        Dominik Kubla <dominik.kubla@uni-mainz.de>,
        Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: 2.2.X patch query (with initial PATCH against 2.2.17) 
In-Reply-To: Message from Dominik Kubla <dominik.kubla@uni-mainz.de> 
   of "Tue, 31 Oct 2000 15:20:16 BST." <20001031152016.B767@uni-mainz.de> 
Date: Tue, 31 Oct 2000 16:38:00 -0300
From: Horst von Brand <vonbrand@inf.utfsm.cl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dominik Kubla <dominik.kubla@uni-mainz.de> said:
> On Tue, Oct 31, 2000 at 01:38:56PM +0000, Riley Williams wrote:
> ...
> > Also, part of my plan was to check that the disk is already in this
> > non-standard format, and refuse to dump if not. This would ensure that
> > doing so didn't overwrite somebody's master boot disk by accident, as
> > such disks will not normally be in this non-standard format.

> Just write a magic number somewhere to the disk and mark these blocks
> bad in the fat. Then just check if the blocks are marked as bad and
> contain the magic number. No need for a special disk format per se...

Why any filesystem at all? Just dump the whole on the diskette in the
drive. If root doesn't know what they are doing fiddling with SysRq, they
deserve it in any case. No FAT, MS-DOS, VFAT or whatever. Just a plain
formated diskette. Remember, this has to be absolutely as simple and robust
as possible, and have minimal impact on the rest of the kernel (no "must
now pull in RW-floppy-format + fat + msdos modules to do SysRq-D", no
"<foo> must be built into the kernel for SysRq-D to work" (at most "floppy
in kernel", more can be hard to swallow in limited environments where this
will be most needed as the only/principal way of looking at logs)).
-- 
Dr. Horst H. von Brand                       mailto:vonbrand@inf.utfsm.cl
Departamento de Informatica                     Fono: +56 32 654431
Universidad Tecnica Federico Santa Maria              +56 32 654239
Casilla 110-V, Valparaiso, Chile                Fax:  +56 32 797513
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
