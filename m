Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264072AbTFCUBY (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 3 Jun 2003 16:01:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264073AbTFCUBY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 3 Jun 2003 16:01:24 -0400
Received: from ip68-107-142-198.tc.ph.cox.net ([68.107.142.198]:53376 "EHLO
	opus.bloom.county") by vger.kernel.org with ESMTP id S264072AbTFCUBX
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 3 Jun 2003 16:01:23 -0400
Date: Tue, 3 Jun 2003 13:14:34 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: Alex Romosan <romosan@sycorax.lbl.gov>
Cc: Jeff Garzik <jgarzik@pobox.com>,
       Marcelo Tosatti <marcelo@conectiva.com.br>,
       lkml <linux-kernel@vger.kernel.org>
Subject: Re: Linux 2.4.21-rc7
Message-ID: <20030603201434.GA803@ip68-0-152-218.tc.ph.cox.net>
References: <Pine.LNX.4.55L.0306031353580.3892@freak.distro.conectiva> <877k83xbbw.fsf@sycorax.lbl.gov> <20030603192711.GA22150@gtf.org> <873cirx79r.fsf@sycorax.lbl.gov>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <873cirx79r.fsf@sycorax.lbl.gov>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 03, 2003 at 12:58:40PM -0700, Alex Romosan wrote:

> Jeff Garzik <jgarzik@pobox.com> writes:
> 
> > On Tue, Jun 03, 2003 at 11:30:59AM -0700, Alex Romosan wrote:
> >> Marcelo Tosatti <marcelo@conectiva.com.br> writes:
> >> 
> >> > Now I really hope its the last one, all this rc's are making me mad.
> >> 
> >> i still can't get it to compile for sparc32:
> >> 
> >> gcc -D__KERNEL__ -I/usr/src/linux/include -Wall -Wstrict-prototypes -Wno-trigraphs -O2 -fno-strict-aliasing -fno-common -fomit-frame-pointer -m32 -pipe -mno-fpu -fcall-used-g5 -fcall-used-g7   -nostdinc -iwithprefix include -DKBUILD_BASENAME=ksyms  -DEXPORT_SYMTAB -c ksyms.c
> >> /usr/src/linux/include/asm/checksum.h: In function `csum_partial_copy_nocheck':
> >> /usr/src/linux/include/asm/checksum.h:59: error: asm-specifier for variable `d' conflicts with asm clobber list
> >> /usr/src/linux/include/asm/checksum.h:59: error: asm-specifier for variable `l' conflicts with asm clobber list
> >> /usr/src/linux/include/asm/checksum.h: In function `csum_partial_copy_from_user':
> >
> > That looks like you either need a different compiler version,
> > or different binutils version...
> 
> gcc (GCC) 3.3 (Debian)
> GNU ld version 2.14.90.0.4 20030523 Debian GNU/Linux

That would do it.

> the same versions work on i386 though...

Yes, but i386 either didn't have now invalid clober lists, or they were
fixed in the -pre portion (like it was on PPC32 as well).

-- 
Tom Rini
http://gate.crashing.org/~trini/
