Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312464AbSCZU3V>; Tue, 26 Mar 2002 15:29:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312465AbSCZU3M>; Tue, 26 Mar 2002 15:29:12 -0500
Received: from astound-64-85-224-253.ca.astound.net ([64.85.224.253]:42500
	"EHLO master.linux-ide.org") by vger.kernel.org with ESMTP
	id <S312464AbSCZU3F>; Tue, 26 Mar 2002 15:29:05 -0500
Date: Tue, 26 Mar 2002 12:28:23 -0800 (PST)
From: Andre Hedrick <andre@linux-ide.org>
To: Jeff Chua <jchua@fedex.com>
cc: Jeff Chua <jeffchua@silk.corp.fedex.com>,
        Marcelo Tosatti <marcelo@conectiva.com.br>,
        Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] 2.4.19-pre4 ide-probe
In-Reply-To: <Pine.LNX.4.42.0203261149510.15967-100000@silk.corp.fedex.com>
Message-ID: <Pine.LNX.4.10.10203261228130.2450-100000@master.linux-ide.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Looking into it today.

On Tue, 26 Mar 2002, Jeff Chua wrote:

> On Fri, 22 Mar 2002, Andre Hedrick wrote:
> 
> > This is the bases of the codes origin.
> 
> So, should it be removed then? If not, how can you get rid of the
> ide_xlate_1024 unknown symbol?
> 
> Jeff.
> 
> 
> 
> >
> > Comments?
> >
> > Andre Hedrick
> > LAD Storage Consulting Group
> >
> > On Thu, 21 Mar 2002, Jeff Chua wrote:
> >
> > >
> > > Marcelo, Andre,
> > >
> > > Someone apparently added the "hook", but it was never used in the kernel,
> > >
> > > What is ide_xlate_1024 referring to?
> > >
> > > Jeff
> > >
> > > ---------- Forwarded message ----------
> > > Date: Thu, 14 Mar 2002 11:22:27 +0800 (SGT)
> > > From: Jeff Chua <jeffchua@silk.corp.fedex.com>
> > > To: Linux Kernel <linux-kernel@vger.kernel.org>,
> > >      Marcelo Tosatti <marcelo@conectiva.com.br>
> > > Cc: Jeff Chua <jchua@fedex.com>
> > > Subject: [PATCH] 2.4.19-pre3 ide_xlate_1024_hook ???
> > >
> > >
> > > It seems that the "ide_xlate_1024_hook" is redundant in
> > > ./drivers/ide/ide-probe.c
> > >
> > > It's not used anywhere by the kernel, and it caused "depmod" to fail
> > > with unknown ide_xlate_1024_hook symbol.
> > >
> > >
> > > Jeff
> > >
> > > Patch ...
> > >
> > > --- ./drivers/ide/ide-probe.c.org       Thu Mar 14 11:01:20 2002
> > > +++ ./drivers/ide/ide-probe.c   Thu Mar 14 11:03:16 2002
> > > @@ -987,7 +987,6 @@
> > >  }
> > >
> > >  #ifdef MODULE
> > > -extern int (*ide_xlate_1024_hook)(kdev_t, int, int, const char *);
> > >
> > >  int init_module (void)
> > >  {
> > > @@ -997,14 +996,12 @@
> > >                 ide_unregister(index);
> > >         ideprobe_init();
> > >         create_proc_ide_interfaces();
> > > -       ide_xlate_1024_hook = ide_xlate_1024;
> > >         return 0;
> > >  }
> > >
> > >  void cleanup_module (void)
> > >  {
> > >         ide_probe = NULL;
> > > -       ide_xlate_1024_hook = 0;
> > >  }
> > >  MODULE_LICENSE("GPL");
> > >  #endif /* MODULE */
> > >
> > >
> > >
> >
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 

Andre Hedrick
LAD Storage Consulting Group

