Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289533AbSAJQgz>; Thu, 10 Jan 2002 11:36:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289534AbSAJQgq>; Thu, 10 Jan 2002 11:36:46 -0500
Received: from cpe-24-221-152-185.az.sprintbbd.net ([24.221.152.185]:44710
	"EHLO opus.bloom.county") by vger.kernel.org with ESMTP
	id <S289533AbSAJQge>; Thu, 10 Jan 2002 11:36:34 -0500
Date: Thu, 10 Jan 2002 09:35:33 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: Corey Minyard <minyard@acm.org>
Cc: Keith Owens <kaos@ocs.com.au>, linux-kernel@vger.kernel.org
Subject: Re: Moving zlib so that others may use it
Message-ID: <20020110163533.GZ13931@cpe-24-221-152-185.az.sprintbbd.net>
In-Reply-To: <3C3D1743.40900@acm.org> <24080.1010637887@kao2.melbourne.sgi.com> <20020110153657.GY13931@cpe-24-221-152-185.az.sprintbbd.net> <3C3DBF5F.4070603@acm.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3C3DBF5F.4070603@acm.org>
User-Agent: Mutt/1.3.25i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 10, 2002 at 10:20:47AM -0600, Corey Minyard wrote:
> Tom Rini wrote:
> 
> >
> >It's possible they can share, but the bootloaders (PPC & MIPS) need a
> >slight change to the zlib.c code to to allow using zero as a real
> >address to store the uncompressed data.  So we'd want to guard the
> >changes with __BOOTER__ or so, and then cp the file or do
> >#define __BOOTER__
> >#include "zlib.c"
> >
> >And do -I$(TOPDIR)/lib, or something along those lines.
>
> I agree, but I think it would be better to do this one step at a time. 

So do I.  So it can work, but lets get this in and I'll make the PPC
stuff use it (since I've got lots of other updates for it I'm getting
ready to push out).

-- 
Tom Rini (TR1265)
http://gate.crashing.org/~trini/
