Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268929AbUIMVHY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268929AbUIMVHY (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Sep 2004 17:07:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268964AbUIMVHY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Sep 2004 17:07:24 -0400
Received: from modemcable166.48-200-24.mc.videotron.ca ([24.200.48.166]:60851
	"EHLO xanadu.home") by vger.kernel.org with ESMTP id S268929AbUIMVGN
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Sep 2004 17:06:13 -0400
Date: Mon, 13 Sep 2004 17:06:06 -0400 (EDT)
From: Nicolas Pitre <nico@cam.org>
X-X-Sender: nico@xanadu.home
To: Herbert Poetzl <herbert@13thfloor.at>
cc: Dan Kegel <dank@kegel.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Fix allnoconfig on arm with small tweak to kconfig?
In-Reply-To: <20040913192900.GC4317@MAIL.13thfloor.at>
Message-ID: <Pine.LNX.4.61.0409131653070.12375@xanadu.home>
References: <414551FD.4020701@kegel.com> <20040913091534.B27423@flint.arm.linux.org.uk>
 <4145BB30.60309@kegel.com> <20040913195119.B4658@flint.arm.linux.org.uk>
 <20040913192900.GC4317@MAIL.13thfloor.at>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 13 Sep 2004, Herbert Poetzl wrote:

> On Mon, Sep 13, 2004 at 07:51:19PM +0100, Russell King wrote:
> > Basically, there's a fair amount of conditions under which Kconfig
> > fails to perform reasonably, and these (little used) targets are
> > an example of that.
> > 
> > If you want something that's guaranteed to work, use one of the
> > per-platform default configurations.  Nothing else carries any
> > guarantee what so ever on ARM.
> > 
> > (Also, I have no interest in all*config myself so even if someone
> > does fix it, chances are it'll get broken again.  I believe that
> > the concept of all*config is a fundamentally broken concept for an
> > architecture with numerous platform configurations.)
> 
> what about providing a reasonable (not necessarily useful)
> configuration for a minimal arm setup (maybe for each endianess)
> and one for a maximal (read: as many as possible) options
> selected which - and this is the important part - are known
> and supposed to compile (regardless if they make sense or are
> used in actual systems)?

See arch/arm/configs/* for many configuration examples.  They are all 
separate ARM targets and usually a given config enables as much 
sensible options 
as possible for that target.  It seems to me that using
'make neponset_defconfig && make all' is a relatively good configuration 
to test toolchain regressions, at least for an ARMv4 build.

If you need, say, a minimal test configurations with the least selected 
options as possible, I don't think anyone would object including such a 
default config file.

> if this isn't in _your_ interest, then maybe some specific
> (considered representative) system defaults can be used instead

Right.


Nicolas
