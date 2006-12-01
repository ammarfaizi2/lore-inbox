Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1031498AbWLAQJT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1031498AbWLAQJT (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 1 Dec 2006 11:09:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1031530AbWLAQJT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 1 Dec 2006 11:09:19 -0500
Received: from vervifontaine.sonytel.be ([80.88.33.193]:5845 "EHLO
	vervifontaine.sonycom.com") by vger.kernel.org with ESMTP
	id S1031498AbWLAQJS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 1 Dec 2006 11:09:18 -0500
Date: Fri, 1 Dec 2006 17:09:17 +0100 (CET)
From: Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>
To: Jeff Dike <jdike@addtoit.com>
cc: Linux Kernel Development <linux-kernel@vger.kernel.org>
Subject: Re: `make checkstack' and cross-compilation
In-Reply-To: <20061201153021.GA4332@ccure.user-mode-linux.org>
Message-ID: <Pine.LNX.4.62.0612011708550.30940@pademelon.sonytel.be>
References: <Pine.LNX.4.62.0612011455040.19178@pademelon.sonytel.be>
 <20061201153021.GA4332@ccure.user-mode-linux.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 1 Dec 2006, Jeff Dike wrote:
> On Fri, Dec 01, 2006 at 02:58:16PM +0100, Geert Uytterhoeven wrote:
> > Makefile has:
> > | # Use $(SUBARCH) here instead of $(ARCH) so that this works for UML.
> > | # In the UML case, $(SUBARCH) is the name of the underlying
> > | # architecture, while for all other arches, it is the same as $(ARCH).
> > | checkstack:
> > |         $(OBJDUMP) -d vmlinux $$(find . -name '*.ko') | \
> > |         $(PERL) $(src)/scripts/checkstack.pl $(SUBARCH)
> > 
> > While this may fix `make checkstack' for UML, it breaks cross-compilation.
> > E.g. when cross-compiling for PPC on ia32, ARCH=powerpc, but SUBARCH=i386.
> > 
> > Probably it should use SUBARCH if ARCH=um, and ARCH otherwise?
> 
> Whoops, you're right.  
> 
> Do you have a patch?  If not, I'll make one.

No.

> And, do you have a cross-compilation environment which tests this?

Yes :-)

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- Sony Network and Software Technology Center Europe (NSCE)
Geert.Uytterhoeven@sonycom.com ------- The Corporate Village, Da Vincilaan 7-D1
Voice +32-2-7008453 Fax +32-2-7008622 ---------------- B-1935 Zaventem, Belgium
