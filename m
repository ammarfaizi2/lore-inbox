Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261402AbSIZQFh>; Thu, 26 Sep 2002 12:05:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261362AbSIZQFK>; Thu, 26 Sep 2002 12:05:10 -0400
Received: from cpe-24-221-152-185.az.sprintbbd.net ([24.221.152.185]:52655
	"EHLO Bill-The-Cat.bloom.county") by vger.kernel.org with ESMTP
	id <S261361AbSIZQDe>; Thu, 26 Sep 2002 12:03:34 -0400
Date: Thu, 26 Sep 2002 09:08:42 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: Bj?rn Stenberg <bjorn@haxx.se>
Cc: Meelis Roos <mroos@linux.ee>, linux-kernel@vger.kernel.org, greg@kroah.com
Subject: Re: PPC: unresolved module symbols in 2.4.20-pre7+bk
Message-ID: <20020926160842.GG5746@opus.bloom.county>
References: <20020924234815.GE788@opus.bloom.county> <Pine.GSO.4.44.0209261127110.27736-100000@rubiin.physic.ut.ee> <20020926142927.GE5746@opus.bloom.county> <20020926175909.E11535@linux3.contactor.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20020926175909.E11535@linux3.contactor.se>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 26, 2002 at 05:59:09PM +0200, Bj?rn Stenberg wrote:
> Tom Rini wrote:
> > > > > depmod: *** Unresolved symbols in /lib/modules/2.4.20-pre7/kernel/drivers/usb/storage/usb-storage.o
> > > > > depmod: 	ppc_generic_ide_fix_driveid
> > 
> > Configuration issue.  CONFIG_USB_STORAGE_ISD200 needs to depend on
> > CONFIG_IDE, since it calls ide_fixup_driveid().  Greg? Bj?rn?
> 
> This is only an issue for PPC and SPARC64. Other targets have an empty macro for ide_fix_driveid().
> 
> I don't know how this kind of "target-dependent dependency" is normally handled. The attached patch is one way.

It should be a universal depenancy on CONFIG_IDE, since you're still
using IDE code regardless of it being empty or not, IMHO.

-- 
Tom Rini (TR1265)
http://gate.crashing.org/~trini/
