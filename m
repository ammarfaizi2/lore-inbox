Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750737AbVHHGWG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750737AbVHHGWG (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 8 Aug 2005 02:22:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750739AbVHHGWG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 Aug 2005 02:22:06 -0400
Received: from mx1.redhat.com ([66.187.233.31]:38822 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1750737AbVHHGWF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 Aug 2005 02:22:05 -0400
Date: Mon, 8 Aug 2005 14:26:36 +0800
From: David Teigland <teigland@redhat.com>
To: Arjan van de Ven <arjan@infradead.org>, akpm@osdl.org
Cc: linux-kernel@vger.kernel.org, linux-cluster@redhat.com
Subject: Re: [PATCH 00/14] GFS
Message-ID: <20050808062636.GB13951@redhat.com>
References: <20050802071828.GA11217@redhat.com> <1122968724.3247.22.camel@laptopd505.fenrus.org> <20050805071415.GC14880@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050805071415.GC14880@redhat.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 05, 2005 at 03:14:15PM +0800, David Teigland wrote:
> On Tue, Aug 02, 2005 at 09:45:24AM +0200, Arjan van de Ven wrote:

> > * +++ b/fs/gfs2/fixed_div64.h	2005-08-01 14:13:08.009808200 +0800
> > ehhhh why?
> 
> I'm not sure, actually, apart from the comments:
> 
> do_div: /* For ia32 we need to pull some tricks to get past various versions
>            of the compiler which do not like us using do_div in the middle
>            of large functions. */
> 
> do_mod: /* Side effect free 64 bit mod operation */
> 
> fs/xfs/linux-2.6/xfs_linux.h (the origin of this file) has the same thing,
> perhaps this is an old problem that's now fixed?

I've looked into getting rid of these:

- The existing do_div() works fine for me with 64 bit numerators, so I'll
  get rid of the "fixed" version.

- The "fixed" do_mod() seems to be the only way to do 64 bit modulus.
  It would be great if I was wrong about that...

Thanks,
Dave

