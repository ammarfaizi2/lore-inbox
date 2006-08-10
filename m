Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932116AbWHJUmZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932116AbWHJUmZ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Aug 2006 16:42:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932280AbWHJUmY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Aug 2006 16:42:24 -0400
Received: from nf-out-0910.google.com ([64.233.182.188]:19343 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S932116AbWHJUlw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Aug 2006 16:41:52 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:date:from:to:cc:subject:message-id:references:mime-version:content-type:content-disposition:in-reply-to:user-agent;
        b=fcr2bx3zNVfxr0v3Jbv2hnAg8XmzFmVs944Y+tK8E6xyO7J7N/f7Xjv1jH0Ei2aaQPQ1ao2XpKvkjXvuqPh5X+uhkZerr3TjWBkPjXGRcScZMWOjCxOol5rCaHtLN1AiEhYvDGGB4OGB9+pCBIIBgcXKPyGwQbilrQGM87bMe3w=
Date: Fri, 11 Aug 2006 00:41:31 +0400
From: Alexey Dobriyan <adobriyan@gmail.com>
To: Andrew Morton <akpm@osdl.org>
Cc: cmm@us.ibm.com, linux-kernel@vger.kernel.org,
       ext2-devel@lists.sourceforge.net, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 2/9] sector_t format string
Message-ID: <20060810204131.GB6845@martell.zuzino.mipt.ru>
References: <1155172843.3161.81.camel@localhost.localdomain> <20060809234019.c8a730e3.akpm@osdl.org> <20060810191747.GL20581@ca-server1.us.oracle.com> <20060810194440.GA6845@martell.zuzino.mipt.ru> <20060810125747.87f7b1dc.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060810125747.87f7b1dc.akpm@osdl.org>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 10, 2006 at 12:57:47PM -0700, Andrew Morton wrote:
> On Thu, 10 Aug 2006 23:44:40 +0400
> Alexey Dobriyan <adobriyan@gmail.com> wrote:
> > On Thu, Aug 10, 2006 at 12:17:47PM -0700, Joel Becker wrote:
> > > On Wed, Aug 09, 2006 at 11:40:19PM -0700, Andrew Morton wrote:
> > > > On Wed, 09 Aug 2006 18:20:43 -0700
> > > > Mingming Cao <cmm@us.ibm.com> wrote:
> > > >
> > > > > Define SECTOR_FMT to print sector_t in proper format
> > > >
> > > > We've thus-far avoided doing this.  In fact a similar construct in
> > > > device-mapper was recently removed.
> > >
> > > 	Yeah, OCFS2 had similar formats, and we were asked to change
> > > them to naked casts before inclusion.  Seems quite consistent with the
> > > rest of the kernel.
> >
> > Will
> >
> > 	printk("%S", sector_t);
> >
> > kill at least one kitten?
>
> It would be really nice to be able to define local enhancements like this
> to printf.  It would solve lots of these problems quite nicely.
>
> Bus alas, there's no way (afaik) to teach __attribute__((format)) about
> them, so gcc will warn.

Arrrgh!

from gcc-local(1)
  -   gcc recognizes a new format attribute, kprintf, to deal with the ex-
      tra format arguments `%b', `%r', and `%z' used in the OpenBSD kernel.

One word: bastards.

