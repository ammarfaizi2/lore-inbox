Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261820AbSJQGDi>; Thu, 17 Oct 2002 02:03:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261821AbSJQGDi>; Thu, 17 Oct 2002 02:03:38 -0400
Received: from packet.digeo.com ([12.110.80.53]:43928 "EHLO packet.digeo.com")
	by vger.kernel.org with ESMTP id <S261820AbSJQGDh>;
	Thu, 17 Oct 2002 02:03:37 -0400
Message-ID: <3DAE5415.938EA547@digeo.com>
Date: Wed, 16 Oct 2002 23:09:25 -0700
From: Andrew Morton <akpm@digeo.com>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.5.42 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Doug Ledford <dledford@redhat.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: balance_dirty_pages broken
References: <20021017043623.GR8159@redhat.com> <3DAE4615.F98B6DE@digeo.com> <20021017052246.GB10276@redhat.com> <20021017054110.GC10276@redhat.com> <3DAE5087.76395305@digeo.com> <20021017060123.GD10276@redhat.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 17 Oct 2002 06:09:25.0823 (UTC) FILETIME=[BEA26CF0:01C275A3]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Doug Ledford wrote:
> 
> On Wed, Oct 16, 2002 at 10:54:15PM -0700, Andrew Morton wrote:
> > Doug Ledford wrote:
> > >
> > > On Thu, Oct 17, 2002 at 01:22:46AM -0400, Doug Ledford wrote:
> > > > Sure, coming under separate cover.
> > >
> > > Actually, this isn't needed now I assume ;-)
> >
> > Well I was rather interested in seeing it to find out why your
> > compile is busted.  You seem to be very protective of the compiler
> > error messages ;)
> 
> OK.  .config attached, error message inline:
> 
>   gcc -Wp,-MD,arch/i386/kernel/.mpparse.o.d -D__KERNEL__ -Iinclude -Wall
> -Wstrict-prototypes -Wno-trigraphs -O2 -fomit-frame-pointer
> -fno-strict-aliasing -fno-common -pipe -mpreferred-stack-boundary=2
> -march=i686 -Iarch/i386/mach-generic -nostdinc -iwithprefix include
> -DKBUILD_BASENAME=mpparse   -c -o arch/i386/kernel/mpparse.o
> arch/i386/kernel/mpparse.c
> arch/i386/kernel/mpparse.c: In function `MP_processor_info':
> arch/i386/kernel/mpparse.c:130: warning: implicit declaration of function
> `Dprintk'

but, but, but.  The patch I sent should have fixed that.  It makes
Dprintk visible in apic.h regardless of the setting of CONFIG_X86_LOCAL_APIC

> ...
> 
> Should I run another test of just this patch to be sure?

She'll be right, mate.
