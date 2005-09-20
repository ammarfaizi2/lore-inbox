Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964845AbVITSLx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964845AbVITSLx (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 Sep 2005 14:11:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964871AbVITSLw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 Sep 2005 14:11:52 -0400
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:13323 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S964845AbVITSLw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 Sep 2005 14:11:52 -0400
Date: Tue, 20 Sep 2005 19:11:44 +0100
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: Andrew Morton <akpm@osdl.org>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, penberg@cs.Helsinki.FI,
       viro@ftp.linux.org.uk, linux-kernel@vger.kernel.org, torvalds@osdl.org
Subject: Re: p = kmalloc(sizeof(*p), )
Message-ID: <20050920181144.GD493@flint.arm.linux.org.uk>
Mail-Followup-To: Andrew Morton <akpm@osdl.org>,
	Alan Cox <alan@lxorguk.ukuu.org.uk>, penberg@cs.Helsinki.FI,
	viro@ftp.linux.org.uk, linux-kernel@vger.kernel.org,
	torvalds@osdl.org
References: <20050918100627.GA16007@flint.arm.linux.org.uk> <84144f0205092004187f86840c@mail.gmail.com> <20050920114003.GA31025@flint.arm.linux.org.uk> <Pine.LNX.4.58.0509201501440.9304@sbz-30.cs.Helsinki.FI> <20050920123149.GA29112@flint.arm.linux.org.uk> <20050920101128.70fec697.akpm@osdl.org> <1127239361.7763.3.camel@localhost.localdomain> <20050920105939.3c9c5e39.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050920105939.3c9c5e39.akpm@osdl.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 20, 2005 at 10:59:39AM -0700, Andrew Morton wrote:
> > "I want to grep for
> > initialisations" is pretty pointless because a) it won't catch everything
> > anyway and b) most structures are allocated and initialised at a single
> > place and many of those which aren't should probably be converted to do
> > that anyway.
> >
> > The broader point is that you're trying to optimise for the wrong thing. 
> > We should optimise for those who read code, not for those who write it.
> >
> 
> If you look back, your five reasons tend to address modifiability, not
> readability.

So what you're saying is that we should optimise the code so that
we make mistakes when we modify it.  Umm, yes, of course.

This is a contentious issue, and I don't think anyone should be
stipulating which way is the right way - which is exactly what
has been done by placing it in Coding Style.  Remember, we have
kernel janitors who _will_ change code to match that.

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 Serial core
