Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129610AbRAKKML>; Thu, 11 Jan 2001 05:12:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130063AbRAKKLv>; Thu, 11 Jan 2001 05:11:51 -0500
Received: from Cantor.suse.de ([194.112.123.193]:6672 "HELO Cantor.suse.de")
	by vger.kernel.org with SMTP id <S129610AbRAKKLt>;
	Thu, 11 Jan 2001 05:11:49 -0500
Date: Thu, 11 Jan 2001 11:11:45 +0100
From: Andi Kleen <ak@suse.de>
To: "Udo A. Steinberg" <sorisor@Hell.WH8.TU-Dresden.De>
Cc: Linus Torvalds <torvalds@transmeta.com>, andrea@suse.de,
        Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: 2.4.1-pre1 breaks XFree 4.0.2 and "w"
Message-ID: <20010111111145.A19584@gruyere.muc.suse.de>
In-Reply-To: <3A5C6417.6670FCB7@Hell.WH8.TU-Dresden.De> <20010110181516.X10035@nightmaster.csn.tu-chemnitz.de> <3A5C96BB.96B19DB@Hell.WH8.TU-Dresden.De> <200101110841.AAA01652@penguin.transmeta.com> <3A5D8583.F5F30BD2@Hell.WH8.TU-Dresden.De>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <3A5D8583.F5F30BD2@Hell.WH8.TU-Dresden.De>; from sorisor@Hell.WH8.TU-Dresden.De on Thu, Jan 11, 2001 at 11:05:55AM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 11, 2001 at 11:05:55AM +0100, Udo A. Steinberg wrote:
> Linus Torvalds wrote:
> > 
> > Mind trying it with the "HAVE_FXSR" and "HAVE_XMM" macros in
> > 
> >         linux/include/asm-i386/processor.h
> > 
> > fixed? They _should_ be just
> > 
> >         #define HAVE_FXSR       (cpu_has_fxsr)
> >         #define HAVE_XMM        (cpu_has_xmm)
> 
> That doesn't help either.

Did you have CONFIG_X86_FXSR or CONFIG_X86_RUNTIME_FXSR enabled when it
worked? 

If not it probably means that the XServer is testing OSFXSR and the branch
that handles it doesn't work.


-Andi
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
