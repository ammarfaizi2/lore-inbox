Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965075AbWIKX3I@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965075AbWIKX3I (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 11 Sep 2006 19:29:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965041AbWIKX3I
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Sep 2006 19:29:08 -0400
Received: from smtp.osdl.org ([65.172.181.4]:913 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S965080AbWIKX3H (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Sep 2006 19:29:07 -0400
Date: Mon, 11 Sep 2006 16:28:59 -0700
From: Judith Lebzelter <judith@osdl.org>
To: Andrew Morton <akpm@osdl.org>
Cc: Judith Lebzelter <judith@osdl.org>, tglx@linutronix.de,
       linux-kernel@vger.kernel.org, Greg KH <greg@kroah.com>,
       linux-xfs@oss.sgi.com
Subject: Re: 2.6.18-rc6-mm1 'uio_read' redefined, breaks allyesconfig on i386
Message-ID: <20060911232859.GK9335@shell0.pdx.osdl.net>
References: <20060911224520.GJ9335@shell0.pdx.osdl.net> <20060911155311.270a8fbb.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060911155311.270a8fbb.akpm@osdl.org>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 11, 2006 at 03:53:11PM -0700, Andrew Morton wrote:
> On Mon, 11 Sep 2006 15:45:20 -0700
> Judith Lebzelter <judith@osdl.org> wrote:
> > I noticed in the 'allyesconfig' build for i386 is not working for 2.6.18-rc6-mm1.
> > The function 'uio_read' in gregkh-driver-uio.patch has the same name as a 
> > function in fs/xfs/support/move.c.  Here is the error message:
> > 
> >   LD      init/built-in.o
> >   LD      .tmp_vmlinux1
> > drivers/built-in.o(.text+0x6eb597): In function `uio_read':
> > drivers/uio/uio_dev.c:59: multiple definition of `uio_read'
> > fs/built-in.o(.text+0x2f4ee8):fs/xfs/support/move.c:26: first defined here
> > i686-unknown-linux-gnu-ld: Warning: size of symbol `uio_read' changed from 123 in fs/built-in.o to 397 in drivers/built-in.o
> > make: [.tmp_vmlinux1] Error 1 (ignored)
> >   KSYM    .tmp_kallsyms1.S
> > i686-unknown-linux-gnu-nm: '.tmp_vmlinux1': No such file
> > No valid symbol.
> > make: [.tmp_kallsyms1.S] Error 1 (ignored)
> > 
> 
> Thanks.   I'd suggest that XFS is being poorly behaved here.  "uio_read" isn't
> an appropriately named symbol for a filesystem to be exposing.

Great.  This is showing up on other platforms as well in PLM (OSDL's cross-compile 
build farm), so it will be good to see it fixed.:~)  

Judith

