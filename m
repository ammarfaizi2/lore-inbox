Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932253AbWHJT6j@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932253AbWHJT6j (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Aug 2006 15:58:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932349AbWHJT6H
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Aug 2006 15:58:07 -0400
Received: from smtp.osdl.org ([65.172.181.4]:43181 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932474AbWHJT5y (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Aug 2006 15:57:54 -0400
Date: Thu, 10 Aug 2006 12:57:47 -0700
From: Andrew Morton <akpm@osdl.org>
To: Alexey Dobriyan <adobriyan@gmail.com>
Cc: cmm@us.ibm.com, linux-kernel@vger.kernel.org,
       ext2-devel@lists.sourceforge.net, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 2/9] sector_t format string
Message-Id: <20060810125747.87f7b1dc.akpm@osdl.org>
In-Reply-To: <20060810194440.GA6845@martell.zuzino.mipt.ru>
References: <1155172843.3161.81.camel@localhost.localdomain>
	<20060809234019.c8a730e3.akpm@osdl.org>
	<20060810191747.GL20581@ca-server1.us.oracle.com>
	<20060810194440.GA6845@martell.zuzino.mipt.ru>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.6; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 10 Aug 2006 23:44:40 +0400
Alexey Dobriyan <adobriyan@gmail.com> wrote:

> On Thu, Aug 10, 2006 at 12:17:47PM -0700, Joel Becker wrote:
> > On Wed, Aug 09, 2006 at 11:40:19PM -0700, Andrew Morton wrote:
> > > On Wed, 09 Aug 2006 18:20:43 -0700
> > > Mingming Cao <cmm@us.ibm.com> wrote:
> > > 
> > > > Define SECTOR_FMT to print sector_t in proper format
> > > 
> > > We've thus-far avoided doing this.  In fact a similar construct in
> > > device-mapper was recently removed.
> > 
> > 	Yeah, OCFS2 had similar formats, and we were asked to change
> > them to naked casts before inclusion.  Seems quite consistent with the
> > rest of the kernel.
> 
> Will
> 
> 	printk("%S", sector_t);
> 
> kill at least one kitten?

It would be really nice to be able to define local enhancements like this
to printf.  It would solve lots of these problems quite nicely.

Bus alas, there's no way (afaik) to teach __attribute__((format)) about
them, so gcc will warn.
