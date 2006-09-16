Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932258AbWIPAdg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932258AbWIPAdg (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 15 Sep 2006 20:33:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932263AbWIPAdg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 15 Sep 2006 20:33:36 -0400
Received: from mailout.stusta.mhn.de ([141.84.69.5]:4361 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S932258AbWIPAdf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 15 Sep 2006 20:33:35 -0400
Date: Sat, 16 Sep 2006 02:33:04 +0200
From: Adrian Bunk <bunk@stusta.de>
To: Andrew Morton <akpm@osdl.org>
Cc: "Randy.Dunlap" <rdunlap@xenotime.net>, linux-kernel@vger.kernel.org,
       rossb@google.com, sam@ravnborg.org
Subject: Re: + allow-proc-configgz-to-be-built-as-a-module.patch added to -mm tree
Message-ID: <20060916003304.GC669@stusta.de>
References: <200609152158.k8FLw7ud018089@shell0.pdx.osdl.net> <20060915154752.d7bdb8a0.rdunlap@xenotime.net> <20060915164135.34adb303.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060915164135.34adb303.akpm@osdl.org>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 15, 2006 at 04:41:35PM -0700, Andrew Morton wrote:
> On Fri, 15 Sep 2006 15:47:52 -0700
> "Randy.Dunlap" <rdunlap@xenotime.net> wrote:
> 
> > On Fri, 15 Sep 2006 14:58:06 -0700 akpm@osdl.org wrote:
> > 
> > > 
> > > The patch titled
> > > 
> > >      allow /proc/config.gz to be built as a module
> > > 
> > > has been added to the -mm tree.  Its filename is
> > > 
> > >      allow-proc-configgz-to-be-built-as-a-module.patch
> > > 
> > > See http://www.zip.com.au/~akpm/linux/patches/stuff/added-to-mm.txt to find
> > > out what to do about this
> > > 
> > > ------------------------------------------------------
> > > Subject: allow /proc/config.gz to be built as a module
> > > From: Ross Biro <rossb@google.com>
> > 
> > When/where was this patch submitted?  I seem to have missed it
> > (or it was so long ago that I forgot about it).
> 
> Ross wrote it today and I stole it.
> 
> > > The driver for /proc/config.gz consumes rather a lot of memory and it is in
> > > fact possible to build it as a module.
> > 
> > Can you try to quantify "rather a lot of memory"?
> 
> I confused it with /proc/kallsyms.  No, /proc/config.gz doesn't use much
> memory.
> 
> > > In some ways this is a bit risky, because the .config which is used for
> > > compiling kernel/configs.c isn't necessarily the same as the .config which was
> > > used to build vmlinux.
> > 
> > and that's why a module wasn't allowed.
> > It's not worth the risk IMO.
> 
> I'd want to be hearing from distro people on that - I'd expect that the
> .config which is used to build configs.ko would not differ from that which
> is used to build vmlinux.
>...

If you are concerned about memory usage, and you are anyway building a 
kernel package for a distribution, the reasonable solution is 
place the .config in /boot/config-...

That's also what I know from the Debian kernel packages.

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

