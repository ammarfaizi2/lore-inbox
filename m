Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292533AbSCRTco>; Mon, 18 Mar 2002 14:32:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292555AbSCRTcf>; Mon, 18 Mar 2002 14:32:35 -0500
Received: from smtp1.extremenetworks.com ([216.52.8.6]:41348 "HELO
	smtp1.extremenetworks.com") by vger.kernel.org with SMTP
	id <S292554AbSCRTc0>; Mon, 18 Mar 2002 14:32:26 -0500
Message-ID: <3C9640C4.2C4F713C@extremenetworks.com>
Date: Mon, 18 Mar 2002 11:32:20 -0800
From: Jason Li <jli@extremenetworks.com>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.2-2smp i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Tom Rini <trini@kernel.crashing.org>
Cc: Keith Owens <kaos@ocs.com.au>, linux-kernel@vger.kernel.org
Subject: Re: EXPORT_SYMBOL doesn't work
In-Reply-To: <2643.1016433275@kao2.melbourne.sgi.com> <3C963BF2.C9D78479@extremenetworks.com> <20020318191927.GB8155@opus.bloom.county>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Tom Rini wrote:
> 
> On Mon, Mar 18, 2002 at 11:11:46AM -0800, Jason Li wrote:
> > Keith Owens wrote:
> > >
> > > On Sun, 17 Mar 2002 22:25:16 -0800,
> > > Jason Li <jli@extremenetworks.com> wrote:
> > > >int (*fdbIoSwitchHook)(
> > > >                           unsigned long arg0,
> > > >                           unsigned long arg1,
> > > >                           unsigned long arg2)=NULL;
> > > >EXPORT_SYMBOL(fdbIoSwitchHook);
> > > >gcc -D__KERNEL__ -I/home/jli/cvs2/exos/linux/include -Wall
> > > >-Wstrict-prototypes -Wno-trigraphs -O2 -fomit-frame-pointer
> > > >-fno-strict-aliasing -fno-common -pipe -mpreferred-stack-boundary=2
> > > >-march=i686    -c -o br_ioctl.o br_ioctl.c
> > > >br_ioctl.c:26: warning: type defaults to `int' in declaration of
> > > >`EXPORT_SYMBOL'
> > >
> > > #include <linux/module.h>
> > >
> > > Also add br_ioctl.o to export-objs in Makefile.
> >
> > Thanks alot. It works.
> >
> > Now another problem with versioning. It seems even after I have the
> > following in my module c file the symbol generated is not versioned:
> 
> Backup your .config, run 'distclean' or 'mrproper' and try again.
> 
> --
> Tom Rini (TR1265)
> http://gate.crashing.org/~trini/

I followed Keith's instruction. It seems now the problem is that the
inlucde/linux/module/netsym.ver  (i put the EXPORT_SYMBOL in netsym.c
now) doesn't have the vesion for the fdbIoSwatichHook symbol.


I wonder if someone tell me how to gernerate the file with latest info,
I may be able to fix this.

In the meantime I did a distclean, and will see.

Thanks,
Jason
