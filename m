Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292368AbSCRTUm>; Mon, 18 Mar 2002 14:20:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292316AbSCRTUh>; Mon, 18 Mar 2002 14:20:37 -0500
Received: from cpe-24-221-152-185.az.sprintbbd.net ([24.221.152.185]:40068
	"EHLO opus.bloom.county") by vger.kernel.org with ESMTP
	id <S292522AbSCRTTy>; Mon, 18 Mar 2002 14:19:54 -0500
Date: Mon, 18 Mar 2002 12:19:27 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: Jason Li <jli@extremenetworks.com>
Cc: Keith Owens <kaos@ocs.com.au>, linux-kernel@vger.kernel.org
Subject: Re: EXPORT_SYMBOL doesn't work
Message-ID: <20020318191927.GB8155@opus.bloom.county>
In-Reply-To: <2643.1016433275@kao2.melbourne.sgi.com> <3C963BF2.C9D78479@extremenetworks.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.27i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 18, 2002 at 11:11:46AM -0800, Jason Li wrote:
> Keith Owens wrote:
> > 
> > On Sun, 17 Mar 2002 22:25:16 -0800,
> > Jason Li <jli@extremenetworks.com> wrote:
> > >int (*fdbIoSwitchHook)(
> > >                           unsigned long arg0,
> > >                           unsigned long arg1,
> > >                           unsigned long arg2)=NULL;
> > >EXPORT_SYMBOL(fdbIoSwitchHook);
> > >gcc -D__KERNEL__ -I/home/jli/cvs2/exos/linux/include -Wall
> > >-Wstrict-prototypes -Wno-trigraphs -O2 -fomit-frame-pointer
> > >-fno-strict-aliasing -fno-common -pipe -mpreferred-stack-boundary=2
> > >-march=i686    -c -o br_ioctl.o br_ioctl.c
> > >br_ioctl.c:26: warning: type defaults to `int' in declaration of
> > >`EXPORT_SYMBOL'
> > 
> > #include <linux/module.h>
> > 
> > Also add br_ioctl.o to export-objs in Makefile.
> 
> Thanks alot. It works.
> 
> Now another problem with versioning. It seems even after I have the
> following in my module c file the symbol generated is not versioned:

Backup your .config, run 'distclean' or 'mrproper' and try again.

-- 
Tom Rini (TR1265)
http://gate.crashing.org/~trini/
