Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266301AbUAVRUt (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 Jan 2004 12:20:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266302AbUAVRUt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 Jan 2004 12:20:49 -0500
Received: from fed1mtao01.cox.net ([68.6.19.244]:18880 "EHLO
	fed1mtao01.cox.net") by vger.kernel.org with ESMTP id S266301AbUAVRUr
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 Jan 2004 12:20:47 -0500
Date: Thu, 22 Jan 2004 10:20:35 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: "Amit S. Kale" <amitkale@emsyssoft.com>
Cc: George Anzinger <george@mvista.com>, Pavel Machek <pavel@suse.cz>,
       Linux Kernel <linux-kernel@vger.kernel.org>,
       KGDB bugreports <kgdb-bugreport@lists.sourceforge.net>,
       Matt Mackall <mpm@selenic.com>, discuss@x86-64.org
Subject: Re: KGDB 2.0.3 with fixes and development in ethernet interface
Message-ID: <20040122172035.GI15271@stop.crashing.org>
References: <200401161759.59098.amitkale@emsyssoft.com> <200401211916.49520.amitkale@emsyssoft.com> <400F0490.6000209@mvista.com> <200401221039.14979.amitkale@emsyssoft.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200401221039.14979.amitkale@emsyssoft.com>
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 22, 2004 at 10:39:14AM +0530, Amit S. Kale wrote:
> On Thursday 22 Jan 2004 4:30 am, George Anzinger wrote:
> > Amit S. Kale wrote:
> > > Now back to gdb problem of not being able to locate registers.
> > > schedule results in code of this form:
> > >
> > > schedule:
> > > framesetup
> > > registers save
> > > ...
> > > ...
> > > save registers
> > > change esp
> > > call switchto
> > > restore registers
> > > ...
> >
> > I have not analyzed this as yet.  However, it does seem to me to be the
> > same problem as trying to bt through an interrupt frame.  The correct way
> > to do this is to build the dwarf frame descriptors.  I have done this for
> > the interrupt frame and intend to send said patch out in a day or so.
> 
> Great! I had to do it this ackward way:
> 
> i386 ->
[snip]
> I guess your patch will fix this problem for i386 only. Any ideas on doing it 
> for powerpc too?

Maybe I'm missing something, but aside from having to re-write the
solution in PPC asm, if it's in i386 asm, why wouldn't this work for PPC
as well?

-- 
Tom Rini
http://gate.crashing.org/~trini/
