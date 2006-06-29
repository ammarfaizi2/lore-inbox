Return-Path: <linux-kernel-owner+willy=40w.ods.org-S933100AbWF2Xnt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933100AbWF2Xnt (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Jun 2006 19:43:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933102AbWF2Xnt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Jun 2006 19:43:49 -0400
Received: from scrub.xs4all.nl ([194.109.195.176]:48798 "EHLO scrub.xs4all.nl")
	by vger.kernel.org with ESMTP id S933100AbWF2Xns (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Jun 2006 19:43:48 -0400
Date: Fri, 30 Jun 2006 01:43:35 +0200 (CEST)
From: Roman Zippel <zippel@linux-m68k.org>
X-X-Sender: roman@scrub.home
To: "H. Peter Anvin" <hpa@zytor.com>
cc: Jan Engelhardt <jengelh@linux01.gwdg.de>, linux-kernel@vger.kernel.org,
       klibc@zytor.com
Subject: Re: [klibc 07/31] i386 support for klibc
In-Reply-To: <44A322BB.2010006@zytor.com>
Message-ID: <Pine.LNX.4.64.0606300133050.12900@scrub.home>
References: <klibc.200606272217.00@tazenda.hos.anvin.org>
 <klibc.200606272217.07@tazenda.hos.anvin.org> <Pine.LNX.4.61.0606280937150.29068@yvahk01.tjqt.qr>
 <44A2A147.9020501@zytor.com> <Pine.LNX.4.64.0606290207580.17704@scrub.home>
 <44A322BB.2010006@zytor.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Wed, 28 Jun 2006, H. Peter Anvin wrote:

> > On Wed, 28 Jun 2006, H. Peter Anvin wrote:
> > 
> > > The i386 ones are a bit special... usually the reason I have added libgcc
> > > functions is that on some architectures, gcc has various problems linking
> > > with
> > > libgcc in some configurations.
> > 
> > If gcc has problems to link its own libgcc you really have a serious
> > problem...
> 
> The way libgcc is handled inside gcc is, indeed, completely screwed up; even
> the gcc people admit that.  They pretty much don't have a way to handle the
> effects of compiler options on libgcc, especially the ones that affect binary
> compatibility.

Nobody said it's perfect. Especially the last point speaks against 
multiple versions of the same library, as it makes it hard to mix 
binaries/libraries. With a single kinit binary it's not really a problem 
yet, but will it stay this way?

> > The standard libgcc may not be as small as you like, but it still should be
> > the first choice. If there is a problem with it, the gcc people do accept
> > patches.
> 
> That's just an asinine statement.  Under that logic we should just forget
> about the kernel and go hack the gcc bugs du jour; we certainly have enough
> workarounds for gcc bugs in the kernel.

Sorry, but I can't follow this logic.

bye, Roman
