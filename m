Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263260AbUABDU0 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 Jan 2004 22:20:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263290AbUABDU0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Jan 2004 22:20:26 -0500
Received: from mtvcafw.SGI.COM ([192.48.171.6]:47730 "EHLO zok.sgi.com")
	by vger.kernel.org with ESMTP id S263260AbUABDUZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 Jan 2004 22:20:25 -0500
Date: Thu, 1 Jan 2004 19:20:49 -0800
From: Paul Jackson <pj@sgi.com>
To: Andrew Morton <akpm@osdl.org>
Cc: trond.myklebust@fys.uio.no, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] disable gcc warnings of sign/unsigned comparison
Message-Id: <20040101192049.59dd7747.pj@sgi.com>
In-Reply-To: <20040101153303.75d37307.akpm@osdl.org>
References: <20040101043333.186a3268.pj@sgi.com>
	<1072977297.1399.14.camel@nidelv.trondhjem.org>
	<20040101151516.236cb610.pj@sgi.com>
	<20040101153303.75d37307.akpm@osdl.org>
Organization: SGI
X-Mailer: Sylpheed version 0.8.10claws (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew wrote:
> ugh, that is unacceptable.
> Unless anyone has a better idea, yes, we should apply your patch.

It seems that the only place I can find the gcc with this bug (that
-Wall implies -Wsign-compare) is the gcc 3.3 that came with my SuSE
Linux 8.2 distribution.  Each of the 3.3, 3.3.1 and 3.3.2 versions
available at ftp.gnu.org/gnu/gcc are ok - no such bug.

So it's not a big deal either way whether to apply this patch.

  In the short term, it helps a very specific version of gcc.

  In the longer term, it clutters the top Makefile with a pimple
  to address a transient glitch.

  Technically it is a no-op for other gcc versions, since
  sign-compare is off in all other cases anyway.

I vote that you:

  ==> Drop my patch in the trash

in the interests of avoiding Makefile clutter.  Tell people like
me that if it hurts to use this gcc 3.3, then don't use it ;).

-- 
                          I won't rest till it's the best ...
                          Programmer, Linux Scalability
                          Paul Jackson <pj@sgi.com> 1.650.933.1373
