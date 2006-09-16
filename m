Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932247AbWIPANO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932247AbWIPANO (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 15 Sep 2006 20:13:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932249AbWIPANO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 15 Sep 2006 20:13:14 -0400
Received: from xenotime.net ([66.160.160.81]:24969 "HELO xenotime.net")
	by vger.kernel.org with SMTP id S932247AbWIPANN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 15 Sep 2006 20:13:13 -0400
Date: Fri, 15 Sep 2006 17:14:27 -0700
From: "Randy.Dunlap" <rdunlap@xenotime.net>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, rossb@google.com, sam@ravnborg.org
Subject: Re: + allow-proc-configgz-to-be-built-as-a-module.patch added to
 -mm tree
Message-Id: <20060915171427.1054e78d.rdunlap@xenotime.net>
In-Reply-To: <20060915164135.34adb303.akpm@osdl.org>
References: <200609152158.k8FLw7ud018089@shell0.pdx.osdl.net>
	<20060915154752.d7bdb8a0.rdunlap@xenotime.net>
	<20060915164135.34adb303.akpm@osdl.org>
Organization: YPO4
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.10; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 15 Sep 2006 16:41:35 -0700 Andrew Morton wrote:

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
> 
> Plus it's configurable.
> 
> Am not particularly fussed either way, really.  It would be better if
> treading on /proc/config.gz were to cause a modprobe of the driver for it,
> but procfs doesn't work that way.

I'm not terribly fussed either way either.  We have just about
hit my quota/limit for discussion of this patch.  :)

If memory is an issue, one should just build the .config file
into the kernel image and use scripts/extract-ikconfig to
read it back (IMHO).

---
~Randy
