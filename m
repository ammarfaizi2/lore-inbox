Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261933AbUCDP1c (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 Mar 2004 10:27:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261935AbUCDP1c
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Mar 2004 10:27:32 -0500
Received: from fed1mtao08.cox.net ([68.6.19.123]:34774 "EHLO
	fed1mtao08.cox.net") by vger.kernel.org with ESMTP id S261933AbUCDP1a
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Mar 2004 10:27:30 -0500
Date: Thu, 4 Mar 2004 08:27:29 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: "Amit S. Kale" <amitkale@emsyssoft.com>
Cc: George Anzinger <george@mvista.com>, Pavel Machek <pavel@ucw.cz>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>,
       kgdb-bugreport@lists.sourceforge.net
Subject: Re: [Kgdb-bugreport] [PATCH] Kill kgdb_serial
Message-ID: <20040304152729.GC26065@smtp.west.cox.net>
References: <20040302213901.GF20227@smtp.west.cox.net> <200403031113.02822.amitkale@emsyssoft.com> <20040303151628.GQ20227@smtp.west.cox.net> <200403041011.39467.amitkale@emsyssoft.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200403041011.39467.amitkale@emsyssoft.com>
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 04, 2004 at 10:11:39AM +0530, Amit S. Kale wrote:
> On Wednesday 03 Mar 2004 8:46 pm, Tom Rini wrote:
> > On Wed, Mar 03, 2004 at 11:13:02AM +0530, Amit S. Kale wrote:
[snip]
> > > kgdb_serial isn't ugly. It's just a function switch, similar to several
> > > of them in the kernel. ppc is ugly, but that's anyway the case because of
> > > so many varieties of ppc. If we are trying to make ppc code clean, it
> > > makes more sense to move this weak function thing into ppc specific files
> > > IMHO.
> >
> > I think you missed the point.  The problem isn't with providing weak
> > functions, the problem is trying to set the function pointer.  PPC
> > becomes quite clean since the next step is to kill off
> > PPC_SIMPLE_SERIAL and just have kgdb_read/write_debug_char in the
> > relevant serial drivers.
> 
> We can still have one single hardcoded function pointer for ppc and manage
> the rest in ppc specific files.

I think you're still missing the point.

Regardless, the solution to this is what dwmw2 suggested on IRC I
believe, as this should remove all of the #ifdef mess.

-- 
Tom Rini
http://gate.crashing.org/~trini/
