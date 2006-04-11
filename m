Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751154AbWDKWOu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751154AbWDKWOu (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 Apr 2006 18:14:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751155AbWDKWOu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 Apr 2006 18:14:50 -0400
Received: from xenotime.net ([66.160.160.81]:43482 "HELO xenotime.net")
	by vger.kernel.org with SMTP id S1751154AbWDKWOt (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 Apr 2006 18:14:49 -0400
Date: Tue, 11 Apr 2006 15:17:16 -0700
From: "Randy.Dunlap" <rdunlap@xenotime.net>
To: Luca Falavigna <dktrkranz@gmail.com>
Cc: ak@suse.de, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] CONSOLE_LP_STRICT Kconfig option
Message-Id: <20060411151716.58278056.rdunlap@xenotime.net>
In-Reply-To: <ff1cadb20602150103u437562ddu@mail.gmail.com>
References: <43F1ED62.4050609@gmail.com>
	<p731wy63s0j.fsf@verdi.suse.de>
	<ff1cadb20602150103u437562ddu@mail.gmail.com>
Organization: YPO4
X-Mailer: Sylpheed version 2.2.4 (GTK+ 2.8.3; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 15 Feb 2006 10:03:30 +0100 Luca Falavigna wrote:

> Oops, I noticed I sent twice my email. Sorry.
> 
> 14 Feb 2006 15:59:56 +0100, Andi Kleen <ak@suse.de>:
> > This shouldn't be a CONFIG. This should be a runtime option.
> > It's ridiculous to have to recompile your kernel just to fix some
> > problem with your printer.
> >
> > e.g. sysctl, ioctl, sysfs entry, module parameter. Whatever is en
> > vogue these days. Easiest would be probably a module_param().
> 
> This feature only gets involved when passing console=lp0 parameter to
> the bootloader. I never tried to load a new system console while
> system was running so I'm not sure if it behaves correctly. If it
> does, I will modify this patch following your advices.

Andi's suggestion seems fine to me:  use a module_param() for
CONSOLE_LP_STRICT instead of a hidden build-time (non-Kconfig)
option.  Are you interested in making this change?

---
~Randy
