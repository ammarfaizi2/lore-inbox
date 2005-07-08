Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262360AbVGHAob@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262360AbVGHAob (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Jul 2005 20:44:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262390AbVGHAob
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Jul 2005 20:44:31 -0400
Received: from nproxy.gmail.com ([64.233.182.204]:33243 "EHLO nproxy.gmail.com")
	by vger.kernel.org with ESMTP id S262360AbVGHAoa convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Jul 2005 20:44:30 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=Ub6Ul214E+RBH2IUp+TvVQpx5M3SyoLLkmOhP/Ufm/xLfRYvKp79fS/zRee0fjS0+dRoSSM3nmQeJD0xU/VTK1+Btvdl6vDtHQnWBpXdKKyIK7i2tlYj5CfvZfMf4QPsIugTs8PXtTlRi7FYi1qvs+jVXsAGF49KLxzzxcRx4iQ=
Message-ID: <2cd57c9005070717446dcc52a1@mail.gmail.com>
Date: Fri, 8 Jul 2005 08:44:28 +0800
From: Coywolf Qi Hunt <coywolf@gmail.com>
Reply-To: coywolf@lovecn.org
To: Andrew Morton <akpm@osdl.org>
Subject: Re: Swap partition vs swap file
Cc: Mike Richards <mrmikerich@gmail.com>, linux-kernel@vger.kernel.org
In-Reply-To: <20050707145944.3ad8a1ab.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <516d7fa80506281757188b2fda@mail.gmail.com>
	 <20050628220334.66da4656.akpm@osdl.org>
	 <516d7fa805070712506ab2094b@mail.gmail.com>
	 <20050707145944.3ad8a1ab.akpm@osdl.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/8/05, Andrew Morton <akpm@osdl.org> wrote:
> Mike Richards <mrmikerich@gmail.com> wrote:
> >
> > > > Given this situation, is there any significant performance or
> > > >  stability advantage to using a swap partition instead of a swap file?
> > >
> > > In 2.6 they have the same reliability and they will have the same
> > > performance unless the swapfile is badly fragmented.
> >
> > Thanks for the reply -- that's been bugging me for a while now. There
> > are a lot of different opinions on the net, and most of the
> > conventional wisdom says use a partition instead of a file. It's nice
> > to hear from an expert on the matter.
> >
> > Three more short questions if you have time:
> >
> > 1. You specify kernel 2.6 -- What about kernel 2.4? How less reliable
> > or worse performing is a swapfile on 2.4?
> 
> 2.4 is weaker: it has to allocate memory from the main page allocator when
> performing swapout.  2.6 avoids that.
> 
> > 2. Is it possible for the swapfile to become fragmented over time, or
> > does it just keep using the same blocks over and over? i.e. if it's
> > all contiguous when you first create the swapfile, will it stay that
> > way for the life of the file?
> 
> The latter.  Create the swapfile when the filesystem is young and empty,

I guess/hope dd always makes it contiguously.

> it'll be nice and contiguous.  Once created the kernel will never add or
> remove blocks.  The kernel won't let you use a sparse file for a swapfile.
> 

-- 
Coywolf Qi Hunt
http://ahbl.org/~coywolf/
