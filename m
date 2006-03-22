Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750931AbWCVGkw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750931AbWCVGkw (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Mar 2006 01:40:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750934AbWCVGkd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Mar 2006 01:40:33 -0500
Received: from smtp.osdl.org ([65.172.181.4]:57279 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1750928AbWCVGkN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Mar 2006 01:40:13 -0500
Date: Tue, 21 Mar 2006 22:36:52 -0800
From: Andrew Morton <akpm@osdl.org>
To: Robin Getz <rgetz@blackfin.uclinux.org>
Cc: linux-kernel@vger.kernel.org, luke.adi@gmail.com
Subject: Re: [PATCH 1/2]Blackfin archtecture patche for 2.6.16
Message-Id: <20060321223652.25bf07f7.akpm@osdl.org>
In-Reply-To: <6.1.1.1.0.20060321224917.01ec6970@ptg1.spd.analog.com>
References: <6.1.1.1.0.20060321224917.01ec6970@ptg1.spd.analog.com>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Robin Getz <rgetz@blackfin.uclinux.org> wrote:
>
> Luke Yang wrote:
> >On 3/21/06, Andrew Morton <akpm@osdl.org> wrote:
> > > - How widespread/popular is the blackfin?  Are many devices using it?
> > >   How old/mature is it?  Is it a new thing or is it near end-of-life?
> >   As a DSP, Blackfin has been there for years and is somewhat popular.
> >But as a CPU which can run Linux, we are trying to make it popular.
> >Anyway a 5$ chip runs Linux and can do audio/video codec is a good toy to 
> >play with.
> 
> I would not describe it as a toy (sorry Luke),
>
> [ interesting info ]
>

Thanks.

> If you think our patch sucks, fine - let us know where to fix it.

It looks reasonable to me, from a ten-minute-scan.

Well.  All architecture ports suck.  Yours sucks averagely ;)

The todo list of which I'm aware is

- use serial core in that driver

- Fix up that ioctl so it a) doesn't sleep in spinlock and b) compiles

- Use generic IRQ framework

- Review all the volatiles, consolidate them in some helper-in-header-file.

- Sort out maintainance issues, gather signed-off-bys. (Done, it appears)

More things might come out once people start paying more attention, but if
that's the extent of things, I'd be OK with a merge when you're ready.
