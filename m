Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266678AbSKOUUK>; Fri, 15 Nov 2002 15:20:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266682AbSKOUUK>; Fri, 15 Nov 2002 15:20:10 -0500
Received: from carisma.slowglass.com ([195.224.96.167]:34317 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id <S266678AbSKOUUJ>; Fri, 15 Nov 2002 15:20:09 -0500
Date: Fri, 15 Nov 2002 20:26:49 +0000
From: Christoph Hellwig <hch@infradead.org>
To: Trond Myklebust <trond.myklebust@fys.uio.no>
Cc: Petr Vandrovec <VANDROVE@vc.cvut.cz>, linux-kernel@vger.kernel.org,
       richard@bouska.cz
Subject: Re: NFS mountned  directory  and apache2 (2.5.47)
Message-ID: <20021115202649.A18706@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Trond Myklebust <trond.myklebust@fys.uio.no>,
	Petr Vandrovec <VANDROVE@vc.cvut.cz>, linux-kernel@vger.kernel.org,
	richard@bouska.cz
References: <79A23782BB8@vcnet.vc.cvut.cz> <15829.22032.166977.73195@helicity.uio.no>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <15829.22032.166977.73195@helicity.uio.no>; from trond.myklebust@fys.uio.no on Fri, Nov 15, 2002 at 09:16:16PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 15, 2002 at 09:16:16PM +0100, Trond Myklebust wrote:
> >>>>> " " == Petr Vandrovec <VANDROVE@vc.cvut.cz> writes:
> 
>      > It does not change anything on the brokeness of apache2 (or
>      > maybe glibc). It must be able to revert to read/write loop if
>      > sendfile fails with EINVAL. There is no guarantee that existing
>      > sendfile() API means that you can use it with all filesystems.
> 
> I disagree. Sendfile can *always* be emulated using the standard file
> 'read' method.

Linus removed that in early 2.5 because it led to kmap() deadlocks.
sendfile can fail with EINVAL and userspace must not rely on it
working on any object.

