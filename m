Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266496AbUFZXY1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266496AbUFZXY1 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 26 Jun 2004 19:24:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266500AbUFZXY1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 26 Jun 2004 19:24:27 -0400
Received: from mtvcafw.SGI.COM ([192.48.171.6]:5737 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S266496AbUFZXYX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 26 Jun 2004 19:24:23 -0400
Date: Sat, 26 Jun 2004 16:24:29 -0700
From: Paul Jackson <pj@sgi.com>
To: Russell King <rmk+lkml@arm.linux.org.uk>
Cc: torvalds@osdl.org, linux-kernel@vger.kernel.org, akpm@osdl.org,
       rusty@rustcorp.com.au
Subject: Re: 2.6.7-bk: asm/setup.h and linux/init.h
Message-Id: <20040626162429.4592cced.pj@sgi.com>
In-Reply-To: <20040626174904.B30532@flint.arm.linux.org.uk>
References: <20040626153511.A30532@flint.arm.linux.org.uk>
	<Pine.LNX.4.58.0406260903190.14449@ppc970.osdl.org>
	<20040626174904.B30532@flint.arm.linux.org.uk>
Organization: SGI
X-Mailer: Sylpheed version 0.8.10claws (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Could someone speak a few words on why a patch such as this is
desirable?

Apparently, there is more value to avoiding non-essential include's than
I realize.  I'd have preferred doing a memcpy of "sizeof(some_struct)"
over doing it for SOME_STRUCT_SIZE constant, and I'd have thought it
appropriate to include whatever header files were needed to do that.

The simple "wc -l" size of the kernel source goes up a couple of lines,
the code complexity is unchanged, and the generated code is unchanged. 
So obviously none of those factors motivate this change.

-- 
                          I won't rest till it's the best ...
                          Programmer, Linux Scalability
                          Paul Jackson <pj@sgi.com> 1.650.933.1373
