Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265036AbRFUWwu>; Thu, 21 Jun 2001 18:52:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264628AbRFUWwk>; Thu, 21 Jun 2001 18:52:40 -0400
Received: from mailhost.idcomm.com ([207.40.196.14]:49841 "EHLO
	mailhost.idcomm.com") by vger.kernel.org with ESMTP
	id <S262596AbRFUWw0>; Thu, 21 Jun 2001 18:52:26 -0400
Message-ID: <3B327B03.8C12741C@idcomm.com>
Date: Thu, 21 Jun 2001 16:53:55 -0600
From: "D. Stimits" <stimits@idcomm.com>
Reply-To: stimits@idcomm.com
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.6-pre1-xfs-4 i686)
X-Accept-Language: en
MIME-Version: 1.0
CC: linux-kernel@vger.kernel.org
Subject: Re: Unable to handle kernel NULL pointer dereference at virtual address 
 - 2.4.5
In-Reply-To: <3B3274F2.56FAB826@telerobotics.jpl.nasa.gov>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: unlisted-recipients:; (no To-header on input)@localhost.localdomain
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Chris Leger wrote:
> 
> Hi,
> 
> I have the same problem, only mine occurs early in the boot process
> (right after a message saying something like "trying to mount old
> root..."; or maybe s/mount/unmount)so I don't have a log.  I have a
> similar system: dual PIIIs w/ Adaptec AIC-7xxx controller, an HP Kayak.
> I saw some earlier messages about AIC-7xxx problems w/ 2.4.5, so I tried
> using aic7xxx_old and also tried a patch someone mentioned.  I have yet
> to be able to bring up my machine with 2.4.5 under any combination of
> aic7xxx drivers, so maybe it's not the driver after all.
> 
> Any ideas?  I built the kernel w/ gcc 2.91.66 (kgcc).

I have no problems running RH 7.l with the 2.4.5 ac series, provided I
have the patch to fs/block_dev.c (which apparently is in at around ac3;
also in 2.4.6-pre2 I think). When using an XFS filesystem patch, I also
have to use their "rebuild firmware" option, which I don't think is part
of ac or regular kernels. I use kgcc to compile all, and am running dual
pIII (I run without APIC because of the defective i840 chipset). All of
this is using the stock aic7xxx module or compiled in directly.

D. Stimits, stimits@idcomm.com

> 
> Thanks,
> 
> Chris Leger
> 
> Rafael Martinez writes:
> > Hello
> >
> >     I have got a error in my syslog about a Null pointer in the kernel:
> >
> >     Kernel 2.4.5
> >     glibc 2.2.12
> >     gcc version 2.96 20000731 (Red Hat Linux 7.0)
> >
> >     Modell: ISP2150
> >     Motherboard: L440GX+ DP
> >     CPU: 2 x Intel Pentium III (Coppermine) 850 MHz L2 cache: 256K / Bus: 100 MHz
> >     RAM: 256 MB
> >     SCSI controller: Adaptec AIC-7896/7 Ultra2
> >
> >Unable to handle kernel NULL pointer dereference at virtual address
> >     00000015
> >      printing eip:
> >     c014db72
> >     *pde = 00000000
> >     Oops: 0002
> >     CPU:    1
> >     EIP:    0010:[<c014db72>]
> >     EFLAGS: 000
> 
> --
> [ Chris Leger  ::  cleger@robotics.jpl.nasa.gov   (818)393-4462 ]
> 
> You can come up with a hundred reasons why a thing can't be done,
> and you have to eat them all when someone else does it.
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
