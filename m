Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318380AbSGRWTa>; Thu, 18 Jul 2002 18:19:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318381AbSGRWTa>; Thu, 18 Jul 2002 18:19:30 -0400
Received: from postfix3-2.free.fr ([213.228.0.169]:31188 "EHLO
	postfix3-2.free.fr") by vger.kernel.org with ESMTP
	id <S318380AbSGRWT3>; Thu, 18 Jul 2002 18:19:29 -0400
Date: Fri, 19 Jul 2002 01:25:35 +0200
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: linux-kernel@vger.kernel.org, kaos@ocs.com.au
Subject: Re: Generic modules documentation is outdated
Message-ID: <20020718232535.GB8165@bylbo.nowhere.earth>
References: <20020704212240.GB659@bylbo.nowhere.earth> <20020718210259.GJ19580@bylbo.nowhere.earth> <1027032521.8154.48.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1027032521.8154.48.camel@irongate.swansea.linux.org.uk>
User-Agent: Mutt/1.4i
From: Yann Dirson <ydirson@altern.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 18, 2002 at 11:48:41PM +0100, Alan Cox wrote:
> On Thu, 2002-07-18 at 22:02, Yann Dirson wrote:
> > - I have installed no proprietary driver, all loaded drivers declare to be
> > "GPL" or "Dual BSD/GPL". 
> 
> Something you loaded was missing a MODULE_LICENSE tag - modern insmod
> will warn on this one

I wrote:
> I found a good candidate in the Apple HFS module

Hm, no, I found the real one (although HFS has the problem):

# modprobe ppp_deflate
Warning: loading /lib/modules/2.4.18+preempt/kernel/drivers/net/ppp_deflate.o will taint the kernel: non-GPL license - BSD without advertisement clause

I'm pretty sure the "BSD without advertisement clause" license should not
taint the kernel, should it ?

And even if there is an obscure license incompatibility, there is a problem
in that this module is in the stock kernels, and should then be advertised
as such (or maybe removed).

Regards,
-- 
Yann Dirson    <ydirson@altern.org> |    Why make M$-Bill richer & richer ?
Debian-related: <dirson@debian.org> |   Support Debian GNU/Linux:
Pro:    <yann.dirson@fr.alcove.com> |  Freedom, Power, Stability, Gratuity
     http://ydirson.free.fr/        | Check <http://www.debian.org/>
