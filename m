Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315449AbSGQROZ>; Wed, 17 Jul 2002 13:14:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315454AbSGQROZ>; Wed, 17 Jul 2002 13:14:25 -0400
Received: from kweetal.tue.nl ([131.155.2.7]:4329 "EHLO kweetal.tue.nl")
	by vger.kernel.org with ESMTP id <S315449AbSGQROZ>;
	Wed, 17 Jul 2002 13:14:25 -0400
Date: Wed, 17 Jul 2002 19:17:22 +0200
From: Andries Brouwer <aebr@win.tue.nl>
To: Elladan <elladan@eskimo.com>
Cc: Stevie O <stevie@qrpff.net>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Zack Weinberg <zack@codesourcery.com>, linux-kernel@vger.kernel.org
Subject: Re: close return value (was Re: [ANNOUNCE] Ext3 vs Reiserfs benchmarks)
Message-ID: <20020717171722.GA1352@win.tue.nl>
References: <1026867782.1688.108.camel@irongate.swansea.linux.org.uk> <20020716232225.GH358@codesourcery.com> <1026867782.1688.108.camel@irongate.swansea.linux.org.uk> <5.1.0.14.2.20020717001624.00ab8c00@whisper.qrpff.net> <20020717043853.GA31493@eskimo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20020717043853.GA31493@eskimo.com>
User-Agent: Mutt/1.3.25i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 16, 2002 at 09:38:53PM -0700, Elladan wrote:

> The question is, does the OS standard guarantee that the fd is closed,
> even if close() returns EINTR or EIO?  Just going by the normal usage of
> EINTR, one might think otherwise.  It doesn't appear to be documented
> one way or another.
> 
> Alan said you could just issue close again to make sure - the example
> shows that this is not the case.  A second close is either required or
> forbidden in that example - and the behavior has to be well defined or
> you won't know which to do.

No, the behaviour is not well-defined at all.
The standard explicitly leaves undefined what happens when close returns
EINTR or EIO.
