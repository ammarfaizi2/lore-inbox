Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750909AbWDLTGm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750909AbWDLTGm (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 12 Apr 2006 15:06:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750928AbWDLTGm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 12 Apr 2006 15:06:42 -0400
Received: from xenotime.net ([66.160.160.81]:54667 "HELO xenotime.net")
	by vger.kernel.org with SMTP id S1750909AbWDLTGm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 12 Apr 2006 15:06:42 -0400
Date: Wed, 12 Apr 2006 12:09:04 -0700
From: "Randy.Dunlap" <rdunlap@xenotime.net>
To: "Luca Falavigna" <dktrkranz@gmail.com>
Cc: ak@suse.de, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] CONSOLE_LP_STRICT Kconfig option
Message-Id: <20060412120904.e2fce912.rdunlap@xenotime.net>
In-Reply-To: <ff1cadb20604121153k6552ea84maf58b44869412f2@mail.gmail.com>
References: <43F1ED62.4050609@gmail.com>
	<p731wy63s0j.fsf@verdi.suse.de>
	<ff1cadb20602150103u437562ddu@mail.gmail.com>
	<20060411151716.58278056.rdunlap@xenotime.net>
	<ff1cadb20604121153k6552ea84maf58b44869412f2@mail.gmail.com>
Organization: YPO4
X-Mailer: Sylpheed version 2.2.4 (GTK+ 2.8.3; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 12 Apr 2006 20:53:28 +0200 Luca Falavigna wrote:

> 2006/4/12, Randy.Dunlap <rdunlap@xenotime.net>:
> > On Wed, 15 Feb 2006 10:03:30 +0100 Luca Falavigna wrote:
> >
> > > Oops, I noticed I sent twice my email. Sorry.
> > >
> > > 14 Feb 2006 15:59:56 +0100, Andi Kleen <ak@suse.de>:
> > > > This shouldn't be a CONFIG. This should be a runtime option.
> > > > It's ridiculous to have to recompile your kernel just to fix some
> > > > problem with your printer.
> > > >
> > > > e.g. sysctl, ioctl, sysfs entry, module parameter. Whatever is en
> > > > vogue these days. Easiest would be probably a module_param().
> > >
> > > This feature only gets involved when passing console=lp0 parameter to
> > > the bootloader. I never tried to load a new system console while
> > > system was running so I'm not sure if it behaves correctly. If it
> > > does, I will modify this patch following your advices.
> >
> > Andi's suggestion seems fine to me:  use a module_param() for
> > CONSOLE_LP_STRICT instead of a hidden build-time (non-Kconfig)
> > option.  Are you interested in making this change?
> >
> > ---
> 
> I can give it a try. I'm not sure if this can be done when system is loaded.

I think that if you make it a module_param() and use (root-) writeable
permissions on it, it's just a variable that can be changed after the
driver is loaded and running.

Andi, did you want just a boot-time option or a run-time (changeable) option?

---
~Randy
