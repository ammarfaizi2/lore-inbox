Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262128AbUABBa6 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 Jan 2004 20:30:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262129AbUABBa6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Jan 2004 20:30:58 -0500
Received: from mtvcafw.SGI.COM ([192.48.171.6]:38195 "EHLO zok.sgi.com")
	by vger.kernel.org with ESMTP id S262128AbUABBaz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 Jan 2004 20:30:55 -0500
Date: Thu, 1 Jan 2004 17:31:09 -0800
From: Paul Jackson <pj@sgi.com>
To: Tomas Szepe <szepe@pinerecords.com>
Cc: trond.myklebust@fys.uio.no, akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] disable gcc warnings of sign/unsigned comparison
Message-Id: <20040101173109.44a58362.pj@sgi.com>
In-Reply-To: <20040102005945.GJ32477@louise.pinerecords.com>
References: <20040101043333.186a3268.pj@sgi.com>
	<1072977297.1399.14.camel@nidelv.trondhjem.org>
	<20040101151516.236cb610.pj@sgi.com>
	<1073004403.1376.14.camel@nidelv.trondhjem.org>
	<20040102005945.GJ32477@louise.pinerecords.com>
Organization: SGI
X-Mailer: Sylpheed version 0.8.10claws (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

My suspicion is that Tomas is right - and that something changed in gcc
between 3.3 and 3.3.2, to affectively remove the sign compare warning
from -Wall.

I will look into that more carefully now.

If so, then:

  1) The alternative to my patch would be telling everyone to not use
     gcc 3.3 or 3.3.1.

  2) On the other hand, my patch would still be desirable on the
     grounds that it makes gcc 3.3 and 3.3.1 usable for kernel builds,
     and is essentially a no-op otherwise, for kernel builds.

I'll post again after I compare some gcc code.

-- 
                          I won't rest till it's the best ...
                          Programmer, Linux Scalability
                          Paul Jackson <pj@sgi.com> 1.650.933.1373
