Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267536AbTAQO1S>; Fri, 17 Jan 2003 09:27:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267539AbTAQO1S>; Fri, 17 Jan 2003 09:27:18 -0500
Received: from imap.gmx.net ([213.165.64.20]:20794 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id <S267536AbTAQO1R>;
	Fri, 17 Jan 2003 09:27:17 -0500
Message-Id: <5.1.1.6.2.20030117152408.00c91a10@pop.gmx.net>
X-Mailer: QUALCOMM Windows Eudora Version 5.1.1
Date: Fri, 17 Jan 2003 15:32:55 +0100
To: Mikael Pettersson <mikpe@csd.uu.se>, Brian Gerst <bgerst@didntduck.org>
From: Mike Galbraith <efault@gmx.de>
Subject: Re: 2.5.59 vmlinux.lds.S change broke modules
Cc: kai@tp1.ruhr-uni-bochum.de, rusty@rustcorp.com.au,
       linux-kernel@vger.kernel.org
In-Reply-To: <15912.2510.489103.267475@harpo.it.uu.se>
References: <3E2808D4.3030200@quark.didntduck.org>
 <15911.64825.624251.707026@harpo.it.uu.se>
 <3E2808D4.3030200@quark.didntduck.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

At 02:49 PM 1/17/2003 +0100, Mikael Pettersson wrote:
>Brian Gerst writes:
>  > Mikael Pettersson wrote:
>  > >
>  > > This oops occurs for every module, not just af_packet.ko, at
>  > > resolve_symbol()'s first call to __find_symbol().
>  > >
>  > > What happens is that __find_symbol() oopses because the kernel's
>  > > symbol table is in la-la land. (Note the bogus kernel adress
>  > > 2220c021 it tried to dereference above.)
>  > >
>  > > Reverting 2.5.59's patch to arch/i386/vmlinux.lds.S cured the
>  > > problem and modules now load correctly for me.
>  > >
>  > > I don't know if this is a problem also for non-i386 archs.
>  > >
>  > > /Mikael
>  >
>  > What version of ld are you using?
>
>2.13.90.0.2, as included in RH8.0.

It oopses with latest binutils too.

(binutils-2.13.2... _upgraded_ from 2.13.90.0.10;)

