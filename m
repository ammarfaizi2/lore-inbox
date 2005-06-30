Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262903AbVF3I2b@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262903AbVF3I2b (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 30 Jun 2005 04:28:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262886AbVF3I2a
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 30 Jun 2005 04:28:30 -0400
Received: from wproxy.gmail.com ([64.233.184.204]:24358 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S262903AbVF3I2C convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 30 Jun 2005 04:28:02 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=UgkJokGx9OnP0+m0MfzFa5bS1l8wQDA2vBuLZopdcCdLgjKm7vPYoZngSC9uxGP+iUnidF5AnXrlahrWj48NgPBz+iPdIgXHgvEdSJCRpwyX2NZbTgeyjhbKf5tv8UsD290cSl48+6VA0PgyEBGzOgEeK5emw34w16mVYYyn+Lw=
Message-ID: <cce092220506300128356b3bbb@mail.gmail.com>
Date: Thu, 30 Jun 2005 16:28:01 +0800
From: Wang Jian <larkwang@gmail.com>
Reply-To: Wang Jian <larkwang@gmail.com>
To: Jens Axboe <axboe@suse.de>
Subject: Re: 2.6.12.1 problems I meet (please CC: me)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <cce092220506292344264b9a53@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <20050630111916.FEA2.LARKWANG@gmail.com>
	 <20050630063721.GB2243@suse.de>
	 <cce092220506292344264b9a53@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The problem #1 is gone for 2.6.12.2. Thanks.

2005/6/30, Wang Jian <larkwang@gmail.com>:
> [root@devel root]# gcc --version
> gcc (GCC) 3.3.2 (Mandrake Linux 10.0 3.3.2-6mdk)
> 
> I will try 2.6.12.2 and report back.
> 
> On 6/30/05, Jens Axboe <axboe@suse.de> wrote:
> > On Thu, Jun 30 2005, Wang Jian wrote:
> > > Hi,
> > >
> > > I use a customized kernel to do packets analysis. The analysis code is
> > > linked into kernel. It will vmalloc() nearly 128M (a little less) when
> > > initialized.
> > >
> > > The original code runs on 2.6.10 and works fine. The platform is a
> > > general P4 with 100M ethernet. The user space system is a 8M compressed
> > > ramdisk image which is a 32M filesystem.
> > >
> > > Now I want to make it work on 2.6.12+ and on Athlon64 platform, for
> > > better driver and better CPU/NIC performance.
> > >
> > > I have a P4 box (compilation bed, CB), a 2-way Athlon64 box (test bed,
> > > TB).
> > >
> > > The problems are:
> > >
> > > 1. I port the code directly to 2.6.12.1 on CB, and it compiles ok. But
> > > during boot, the kernel boot with error "unknown bus type 0" and freeze.
> > > Especially, it can't detect harddisk's partition table. I use "quiet" to
> > > strip non-error message and hand copy error messages
> >
> > Which compiler? 2.6.12.2 should work for you, looks like you are hit my
> > the memcpy reordering bug.
> >
> > --
> > Jens Axboe
> >
> >
>
