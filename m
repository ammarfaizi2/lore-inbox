Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265019AbSK1AmW>; Wed, 27 Nov 2002 19:42:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265033AbSK1AmW>; Wed, 27 Nov 2002 19:42:22 -0500
Received: from 12-231-249-244.client.attbi.com ([12.231.249.244]:14085 "HELO
	kroah.com") by vger.kernel.org with SMTP id <S265019AbSK1AmS>;
	Wed, 27 Nov 2002 19:42:18 -0500
Date: Wed, 27 Nov 2002 16:41:32 -0800
From: Greg KH <greg@kroah.com>
To: Kevin Brosius <cobra@compuserve.com>
Cc: Arnd Bergmann <arnd@bergmann-dalldorf.de>,
       Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: hugetlbpage.c build failure?
Message-ID: <20021128004132.GA8001@kroah.com>
References: <3DE54702.44D98750@compuserve.com> <200211272301.AAA29750@post.webmailer.de> <3DE557AC.A8DE08E5@compuserve.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3DE557AC.A8DE08E5@compuserve.com>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 27, 2002 at 06:39:24PM -0500, Kevin Brosius wrote:
> Arnd Bergmann wrote:
> > 
> > 
> > Kevin Brosius wrote:
> > > arch/i386/mm/hugetlbpage.c:610: parse error before '*' token
> > 
> > The patch below fixed this for me
> > 
> > ===== arch/i386/mm/hugetlbpage.c 1.17 vs edited =====
> > --- 1.17/arch/i386/mm/hugetlbpage.c     Thu Nov 14 23:03:02 2002
> > +++ edited/arch/i386/mm/hugetlbpage.c   Wed Nov 27 19:18:23 2002
> > @@ -14,6 +14,7 @@
> >  #include <linux/slab.h>
> >  #include <linux/module.h>
> >  #include <linux/err.h>
> > +#include <linux/sysctl.h>
> >  #include <asm/mman.h>
> >  #include <asm/pgalloc.h>
> 
> Thanks guys, that does it here.  Greg, was yours a run time fix? I don't
> see any difference during build.

Should be needed during building, but I don't know the .config options
that are necessary for it to be needed, sorry.

greg k-h
