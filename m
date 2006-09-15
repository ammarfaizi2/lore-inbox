Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750899AbWIOKUM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750899AbWIOKUM (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 15 Sep 2006 06:20:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750907AbWIOKUM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 15 Sep 2006 06:20:12 -0400
Received: from nf-out-0910.google.com ([64.233.182.188]:33768 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S1750899AbWIOKUK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 15 Sep 2006 06:20:10 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:date:from:to:cc:subject:message-id:references:mime-version:content-type:content-disposition:in-reply-to:user-agent;
        b=Awb8uZpSprcJDNaD15SPpk2HC9aTtlz8oo1govc8RkPlXIqh5F6PYALPZwyp3091C6PEzTYympRmrHlIXxynSbBSEdZLVuMhVvTJdCUro7qLcpiF51nEP6Tt2t3UDdb0jG4cXXgTQVV/6Rnb2MF482m3x1HLYSJPtzLVXRN+pbU=
Date: Fri, 15 Sep 2006 14:20:14 +0400
From: Alexey Dobriyan <adobriyan@gmail.com>
To: Jan Engelhardt <jengelh@linux01.gwdg.de>
Cc: Madhav Bhamidipati <madhavb@gmail.com>, linux-kernel@vger.kernel.org
Subject: Re: Question on compiling a kernel Module
Message-ID: <20060915102014.GA5286@martell.zuzino.mipt.ru>
References: <50b2ce660609150302s4f3de2afwf573b40f02a8d111@mail.gmail.com> <Pine.LNX.4.61.0609151206440.26659@yvahk01.tjqt.qr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.61.0609151206440.26659@yvahk01.tjqt.qr>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 15, 2006 at 12:10:14PM +0200, Jan Engelhardt wrote:
> >
> > module/
> > module/sub-module1
> > module/sub-module2
> > module/include
> > module/objs/
>
>
> obj-m += my.o
> my-objs := sub1/foo.o sub1/bar.o sub2/abc.o sub2/xyz.o
> EXTRA_CFLAGS += -I$(src)/include
>
>
> Should be straightforward.

XFS does this and makes

	make fs/xfs/linux-2.6/xfs_stats.i

impossible.

>
> > module folder has a Makefile, it may or may not have *.c files, it
> > invokes sub-* Makefiles
> > which build respective objects, these objects need to go into objs
> > folder, finally makefile in 'objs'
> > builds the module.ko linking all sub-module *.o.
> >
> > I could not find much information for my requirement in the file
> > linux/Documentation/kbuild/makefiles.txt
> >
> > any information with an example for my requirement is greatly
> > appreciated. Also let me know
> > how do I expose module/include in sub-module/ c files, looks like
> > -I../include is not working

