Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315406AbSFJODa>; Mon, 10 Jun 2002 10:03:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315370AbSFJOBb>; Mon, 10 Jun 2002 10:01:31 -0400
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:18525 "EHLO
	frodo.biederman.org") by vger.kernel.org with ESMTP
	id <S315335AbSFJOBN>; Mon, 10 Jun 2002 10:01:13 -0400
To: Thunder from the hill <thunder@ngforever.de>
Cc: David Woodhouse <dwmw2@infradead.org>, Dave Jones <davej@suse.de>,
        "Albert D. Cahalan" <acahalan@cs.uml.edu>,
        OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>,
        <linux-kernel@vger.kernel.org>, <chaffee@cs.berkeley.edu>
Subject: Re: [patch] fat/msdos/vfat crud removal
In-Reply-To: <Pine.LNX.4.44.0206091417250.8715-100000@hawkeye.luckynet.adm>
From: ebiederm@xmission.com (Eric W. Biederman)
Date: 10 Jun 2002 07:51:22 -0600
Message-ID: <m1zny3utr9.fsf@frodo.biederman.org>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.1
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Thunder from the hill <thunder@ngforever.de> writes:

> Hi,
> 
> On Sun, 9 Jun 2002, David Woodhouse wrote:
> > Er, no. If you randomly reassign errno values, the world breaks.
> > Don't even contemplate it.
> 
> I meant adding. Not just errno, even PF_..., etc.
> 
> > To that end, we should put '#ifndef __KERNEL__ #error' into all kernel
> > headers, and C libraries should maintain a _separate_ set of headers which
> > contain only the ABI definitions and are suitable for userspace. I believe 
> > dietlibc already does this, and recent Red Hat distributions contain a 
> > 'glibc-kernheaders' package with a slightly-sanitised version of kernel 
> > headers, which should become more sanitised over time.
> 
> I wouldn't call dietlibc an HighEnd open end API.

All linux libc's do this.  glibc, dietlibc, and uclibc.

Beyond this if you really object you can come up with a set of header
that just describe the kernel/user space ABI, and build them so either
the kernel or user space can use them.  And then this ABI-headers
package can be used to hold the common definitions.

Until someone builds a kernel-abi-headers package everyone will do it
by copying the appropriate headers periodically.

Eric
