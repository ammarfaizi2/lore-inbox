Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263706AbTHZMa5 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 26 Aug 2003 08:30:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263689AbTHZMa5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 26 Aug 2003 08:30:57 -0400
Received: from fep03.swip.net ([130.244.199.131]:42948 "EHLO
	fep03-svc.swip.net") by vger.kernel.org with ESMTP id S263765AbTHZM2P convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 26 Aug 2003 08:28:15 -0400
From: "Michal Semler (volny.cz)" <cijoml@volny.cz>
Reply-To: cijoml@volny.cz
To: Adrian Bunk <bunk@fs.tum.de>
Subject: Re: 2.6.0-test4: CONFIG_KCORE_AOUT doesn't compile
Date: Tue, 26 Aug 2003 14:28:07 +0200
User-Agent: KMail/1.5.3
References: <200308252332.46101.cijoml@volny.cz> <20030826105145.GC7038@fs.tum.de>
In-Reply-To: <20030826105145.GC7038@fs.tum.de>
Cc: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Message-Id: <200308261428.07929.cijoml@volny.cz>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks for helping me.
Kernel got compiled now, but not boot.

It gets into maintaince wanting root password and then telling me:

QM_MODULES - function not implemented.

What need I switch on to get modules working?

Michal

Dne út 26. srpna 2003 12:51 jste napsal(a):
> On Mon, Aug 25, 2003 at 11:32:46PM +0200, Michal Semler (volny.cz) wrote:
> > Hi,
> >
> > I tried compile 2.6.0-test4, but I got this error messages:
> > gcc-3.3, Debian Woody with bunk debs
> >
> > arch/i386/mm/built-in.o(.init.text+0x4bf): In function `mem_init':
> > : undefined reference to `kclist_add'
> >
> > arch/i386/mm/built-in.o(.init.text+0x4ec): In function `mem_init':
> > : undefined reference to `kclist_add'
> >
> > make: *** [.tmp_vmlinux1] Error 1
> >
> > .config included
>
> @Michal:
>
> # CONFIG_KCORE_ELF is not set
> CONFIG_KCORE_AOUT=y
>
>
> I assume you want to change
>   Executable file formats
>     Kernel core (/proc/kcore) format
> to
>   ELF
>
>
> @all:
>
> Is there any specific reason to keep CONFIG_KCORE_AOUT or is it time to
> remove this option?
>
> > Michal
>
> cu
> Adrian

