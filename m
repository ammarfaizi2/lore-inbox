Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266152AbUA1UZ7 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Jan 2004 15:25:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266029AbUA1UZ7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Jan 2004 15:25:59 -0500
Received: from nevyn.them.org ([66.93.172.17]:15521 "EHLO nevyn.them.org")
	by vger.kernel.org with ESMTP id S266152AbUA1UZz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Jan 2004 15:25:55 -0500
Date: Wed, 28 Jan 2004 15:25:51 -0500
From: Daniel Jacobowitz <dan@debian.org>
To: linux-kernel@vger.kernel.org
Subject: Re: long long on 32-bit machines
Message-ID: <20040128202551.GA16884@nevyn.them.org>
Mail-Followup-To: linux-kernel@vger.kernel.org
References: <26879984$107531702940180925001758.71044950@config16.schlund.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <26879984$107531702940180925001758.71044950@config16.schlund.de>
User-Agent: Mutt/1.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 28, 2004 at 08:22:01PM +0100, Arnd Bergmann wrote:
> 
> H.P.A wrote:
> 
> > Does anyone happen to know if there are *any* 32-bit architectures (on 
> > which Linux runs) for which the ABI for a "long long" is different from 
> > passing two "longs" in the appropriate order, i.e. (hi,lo) for bigendian 
> > or (lo,hi) for littleendian?
> 
> Some architectures require long long arguments to be passed as an
> even/odd register pair. For example on s390, 
> 
>    void f(int a, int b, long long x) 
> 
> uses registers 2, 3, 4 and 5, while 
> 
>    void f(int a, long long x, int b)
> 
> uses registers 2, 4, 5 and 6. AFAIK, mips does the same, probably others
> as well.

Yes.  Also, IIRC, one of SH3 and SH4 requires the padding, and the
other doesn't.

-- 
Daniel Jacobowitz
MontaVista Software                         Debian GNU/Linux Developer
