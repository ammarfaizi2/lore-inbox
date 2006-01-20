Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751167AbWATVjw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751167AbWATVjw (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 20 Jan 2006 16:39:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751169AbWATVjw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 20 Jan 2006 16:39:52 -0500
Received: from uproxy.gmail.com ([66.249.92.203]:62161 "EHLO uproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751167AbWATVjv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 20 Jan 2006 16:39:51 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:date:from:to:cc:subject:message-id:references:mime-version:content-type:content-disposition:in-reply-to:user-agent;
        b=HLY81b8iVuxfxXN0CHlynmg3XJJDNw8vcaneNF8JtqnoVxBaz/+nKADSIIuNCFT+Y73UzVhd1dK4e99ctnJdoLfqraQv6EjxIYMTie0P1QQ4gNJYMTdJo+RI1puO3Dk7iNvaFPexPK+xxShWZ4Q/qJdXHq4/Dm2lxcPdo0HfsaU=
Date: Sat, 21 Jan 2006 00:57:17 +0300
From: Alexey Dobriyan <adobriyan@gmail.com>
To: Adrian Bunk <bunk@stusta.de>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org, spyro@f2s.com
Subject: Re: 2.6.16-rc1-mm2: arch/arm26/kernel/fiq.c still doesn't compile
Message-ID: <20060120215717.GA13620@mipter.zuzino.mipt.ru>
References: <20060120031555.7b6d65b7.akpm@osdl.org> <20060120212635.GC31803@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060120212635.GC31803@stusta.de>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 20, 2006 at 10:26:35PM +0100, Adrian Bunk wrote:
> On Fri, Jan 20, 2006 at 03:15:55AM -0800, Andrew Morton wrote:
> >...
> > Changes since 2.6.16-rc1-mm1:
> >...
> > +arm26-fixup-asm-statement-in-kernel-fiqc.patch
> >...
> >  arm25 fixes
> >...
>
> This doesn't seem to be enough to fix the arm27 compilation [1]:

>   CC      arch/arm26/kernel/fiq.o
> /usr/src/ctest/mm/kernel/arch/arm26/kernel/fiq.c:1: note: future releases of GCC will not support -mapcs-26
> /usr/src/ctest/mm/kernel/arch/arm26/kernel/fiq.c: In function `set_fiq_regs':
> /usr/src/ctest/mm/kernel/arch/arm26/kernel/fiq.c:122: error: fp cannot be used in asm here
> make[2]: *** [arch/arm26/kernel/fiq.o] Error 1

HOSTCC=gcc-3.4

Downgrading to 3.3.* helped me.

