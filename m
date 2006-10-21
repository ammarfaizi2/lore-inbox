Return-Path: <linux-kernel-owner+willy=40w.ods.org-S2993164AbWJURxB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S2993164AbWJURxB (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 21 Oct 2006 13:53:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423378AbWJURxA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 21 Oct 2006 13:53:00 -0400
Received: from xenotime.net ([66.160.160.81]:55995 "HELO xenotime.net")
	by vger.kernel.org with SMTP id S1423375AbWJURw7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 21 Oct 2006 13:52:59 -0400
Date: Sat, 21 Oct 2006 10:54:35 -0700
From: Randy Dunlap <rdunlap@xenotime.net>
To: Adrian Bunk <bunk@stusta.de>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Randy Dunlap <randy.dunlap@oracle.com>, Alan Cox <alan@redhat.com>,
       Patrick Jefferson <henj@hp.com>, Kenny Graunke <kenny@whitecape.org>,
       linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org
Subject: Re: [2.6.19 patch] drivers/ide/pci/generic.c: re-add the
 __setup("all-generic-ide",...)
Message-Id: <20061021105435.9f07d613.rdunlap@xenotime.net>
In-Reply-To: <20061020210533.GW3502@stusta.de>
References: <Pine.LNX.4.64.0610130941550.3952@g5.osdl.org>
	<20061017155934.GC3502@stusta.de>
	<4534C7A7.7000607@hp.com>
	<20061018221520.GK3502@stusta.de>
	<20061018231844.GA16857@devserv.devel.redhat.com>
	<20061019152651.GR3502@stusta.de>
	<20061019090741.853ea100.randy.dunlap@oracle.com>
	<20061019161338.GT3502@stusta.de>
	<1161275398.17335.87.camel@localhost.localdomain>
	<20061020210533.GW3502@stusta.de>
Organization: YPO4
X-Mailer: Sylpheed version 2.2.9 (GTK+ 2.8.10; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 20 Oct 2006 23:05:33 +0200 Adrian Bunk wrote:

> On Thu, Oct 19, 2006 at 05:29:58PM +0100, Alan Cox wrote:
> > Ar Iau, 2006-10-19 am 18:13 +0200, ysgrifennodd Adrian Bunk:
> > > > Missing update to Documentation/kernel-parameters.txt ?
> > > > (maybe it's been missing forever?)
> > > 
> > > It's been missing forever.
> > > 
> > > I'm not sure whether documenting it now where it's deprecated and nearly 
> > > dead makes sense..
> > 
> > Its not dead, its so useful that drivers/ata also supports it
> 
> But in the drivers/ata case it's a module parameter, not a __setup 
> kernel parameter.

That's just an implementation nit/detail.  Users don't care which
way it's implemented, they just need to see some reasonable
documentation.

> And I don't think it makes sense to manually add module parameters to 
> kernel-parameters.txt

There are module parameters there already...
so we are being inconsistent.

> If a documentation of all module parameters is considered useful, 
> someone should write a script to automatically generate such a list.

I think that sounds great -- in theory.  Really, I do.
I even wrote a (simple) script for it last night.[1]
(but someone else is free to redo it, and probably not in
shell script :)

And maybe one "development community" answer is that this is
a distro problem, let them handle it.  (I don't like that answer,
but possibly the distros are OK with it.  I don't know.)

Ideally, users would be able to see/read documentation (like kernel
or module parameters) (a) without reading the source code and
(b) without building the module binary files.  Maybe that's too
much to ask of the development community, so the users can just
build all 1500 or so (and growing) loadable kernel modules
and run 'modinfo' on them to see what the possible module
parameters are.  Of course, if they need this information to be
able to install their (only) Linux system, then they are out of
luck, or they can use their other (or working) OS to search the
internet for such documenation.

Anyway, regarding your suggestion:  Yes, I think that it would be
good to generate such documentation instead of maintaining it
(and sometimes not doing that).  Maybe someone can & will make
that happen.

---
~Randy
[1] http://www.xenotime.net/linux/scripts/module-params
