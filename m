Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265533AbUAPSkr (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 16 Jan 2004 13:40:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265581AbUAPSkr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 16 Jan 2004 13:40:47 -0500
Received: from waste.org ([209.173.204.2]:45026 "EHLO waste.org")
	by vger.kernel.org with ESMTP id S265533AbUAPSkq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 16 Jan 2004 13:40:46 -0500
Date: Fri, 16 Jan 2004 12:39:51 -0600
From: Matt Mackall <mpm@selenic.com>
To: "Amit S. Kale" <amitkale@emsyssoft.com>
Cc: Andi Kleen <ak@suse.de>, linux-kernel@vger.kernel.org,
       kgdb-bugreport@lists.sourceforge.net, pavel@suse.cz, discuss@x86-64.org,
       george@mvista.com
Subject: Re: [discuss] KGDB 2.0.3 with fixes and development in ethernet interface
Message-ID: <20040116183950.GP28521@waste.org>
References: <200401161759.59098.amitkale@emsyssoft.com> <20040116140551.2da2815b.ak@suse.de> <200401161951.51597.amitkale@emsyssoft.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200401161951.51597.amitkale@emsyssoft.com>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 16, 2004 at 07:51:51PM +0530, Amit S. Kale wrote:
> On Friday 16 Jan 2004 6:35 pm, Andi Kleen wrote:
> > On Fri, 16 Jan 2004 17:59:59 +0530
> >
> > "Amit S. Kale" <amitkale@emsyssoft.com> wrote:
> > > Hi,
> > >
> > > KGDB 2.0.3 is available at
> > > http://kgdb.sourceforge.net/kgdb-2/linux-2.6.1-kgdb-2.0.3.tar.bz2
> > >
> > > Ethernet interface still doesn't work. It responds to gdb for a couple of
> > > packets and then panics. gdb log for ethernet interface is pasted below.
> >
> > Did you add the fix for netpoll Jim posted?
> 
> I am not using netpoll (yet). My patch doesn't require any driver 
> modifications, that the mm ethernet patch required.

I went the no-modified-drivers route originally and a long discussion
with Jeff Garzik eventually convinced me of the error of my ways.
There are a bunch of paths that are racy if you try to make a generic
poll function. 

-- 
Matt Mackall : http://www.selenic.com : Linux development and consulting
