Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S284953AbRLKOFo>; Tue, 11 Dec 2001 09:05:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S284951AbRLKOFf>; Tue, 11 Dec 2001 09:05:35 -0500
Received: from [208.46.240.239] ([208.46.240.239]:15515 "EHLO mail.empexis.com")
	by vger.kernel.org with ESMTP id <S284953AbRLKOFX>;
	Tue, 11 Dec 2001 09:05:23 -0500
Message-ID: <3C1605C0.7453D3CD@empexis.com>
Date: Tue, 11 Dec 2001 08:10:24 -0500
From: Joy Almacen <joy@empexis.com>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.2-2 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: vda <vda@port.imtp.ilyichevsk.odessa.ua>
CC: Bob Poortinga <bobp@savemail.com>, linux-kernel@vger.kernel.org
Subject: Re: Upgrade to 2.4.16 produces "Kernel panic: No init found"
In-Reply-To: <3C150FD8.290BCBEC@savemail.com> <01121111410200.01012@manta>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Bob,

I have a similar problem.  My distro is RH7.1 and running on aCompaq Proliant
6000.
The original install boots fine, but is only running on UP not SMP. I grabbed
the
latest kernel from RH site and the upgraded utilities, SysVinit and all.
I even compiled into the kernel the scsi_mod and sd_mod as well as my
SCSI card driver sym53c8xx but to no avail.  It seems that for this
pivot_root
call wont work if you do not have dev and loop compiled into the kernel.
I will recompile the kernel with both selected to find out if this is true.

So far however, I have tried both:

1. Creating an initrd for my kernel version that has SCSI drivers as modules,

2. Compiling the drivers into the kernel with basically the same results, the
kernel panicking either
it can not mount the root file system( which is still ext2) or no init being
found.

See the docs on initrd fro your kernel  as you amy have to change your
lilo.conf
to pass parameters to the kernel thru "append" depending on whether you have
devfs support enabled or not.

I have been trying to fix this for 3 days now and have , like you had said "
google'd myself silly".

I  will let you know if I get any luck booting.

I would also appreciate it if you can let me know if you have a known fix or
at least the issue that's causing
this.

Thanks,

Joy






vda wrote:

> On Monday 10 December 2001 17:41, Bob Poortinga wrote:
> > Hello kernel gurus,
> >
> > I have searched the list archives and google'd myself silly, but I
> > can't seem to find a solution to my problem.
> >
> > I am trying to update my 2.4.3 kernel (Mandrake 8.0 distro) to 2.4.16.
> > I did a 'make oldconfig' with my old .config file and added ext3 kernel
> > support in addition to ext2.  My root fs is ext2 (as are all my fs).
> > The new kernel boots but panics when it tries to mount the root fs.
> > Here is the error:
> > --------------------------------------------------------------------
> > Mounting /proc filesystem
> > Creating root device
> > Mounting root filesystem
> > pivotroot: pivot_root(/sysroot,/sysroot/initrd) failed: 2
> > Freeing unused kernel memory: 216k freed
> > Kernel panic: No init found.  Try passing init= option to kernel.
>
> Using initrd I guess?
> Please describe your boot process.
>
> Initrd support broke between 2.4.10 and 2.4.12, it does not like romfs and
> minix initrds anymore. I have a testcase.
> --
> vda
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/




