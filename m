Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S279155AbRJ2Kpz>; Mon, 29 Oct 2001 05:45:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S279157AbRJ2Kpq>; Mon, 29 Oct 2001 05:45:46 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:32787 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S279155AbRJ2Kpg>; Mon, 29 Oct 2001 05:45:36 -0500
Subject: Re: Patch to make 2.4.13 compile on s390
To: zaitcev@redhat.com (Pete Zaitcev)
Date: Mon, 29 Oct 2001 10:52:46 +0000 (GMT)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20011029015210.A10144@devserv.devel.redhat.com> from "Pete Zaitcev" at Oct 29, 2001 01:52:10 AM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E15yA2A-0002GW-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Do we actually have a maintainer for that thing?
> Or do we blindly apply whatever IBM bestows?

Sometimes generic fixes break stuff

> diff -ur -X dontdiff linux-2.4.13-0.2/Makefile linux-2.4.13-0.2-t1/Makefile
> --- linux-2.4.13-0.2/Makefile	Mon Oct 29 04:28:50 2001
> +++ linux-2.4.13-0.2-t1/Makefile	Mon Oct 29 05:00:08 2001
> diff -ur -X dontdiff linux-2.4.13-0.2/arch/s390/config.in linux-2.4.13-0.2-t1/arch/s390/config.in
> --- linux-2.4.13-0.2/arch/s390/config.in	Mon Oct 29 04:28:40 2001
> +++ linux-2.4.13-0.2-t1/arch/s390/config.in	Mon Oct 29 06:22:48 2001
> @@ -10,6 +10,7 @@
>  define_bool CONFIG_RWSEM_GENERIC_SPINLOCK y
>  define_bool CONFIG_RWSEM_XCHGADD_ALGORITHM n
>  define_bool CONFIG_GENERIC_BUST_SPINLOCK n
> +define_bool CONFIG_GENERIC_ISA_DMA y

Please tell me where you find an S/390 mainframe with ISA bus. I think you
may have fixed the effect not the cause.

