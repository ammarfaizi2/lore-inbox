Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264191AbTDJVbL (for <rfc822;willy@w.ods.org>); Thu, 10 Apr 2003 17:31:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264193AbTDJVbK (for <rfc822;linux-kernel-outgoing>);
	Thu, 10 Apr 2003 17:31:10 -0400
Received: from wohnheim.fh-wedel.de ([195.37.86.122]:19648 "EHLO
	wohnheim.fh-wedel.de") by vger.kernel.org with ESMTP
	id S264191AbTDJVbF (for <rfc822;linux-kernel@vger.kernel.org>); Thu, 10 Apr 2003 17:31:05 -0400
Date: Thu, 10 Apr 2003 23:32:32 +0200
From: =?iso-8859-1?Q?J=F6rn?= Engel <joern@wohnheim.fh-wedel.de>
To: Dan Kegel <dank@kegel.com>
Cc: wd@denx.de, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: gcc-2.95 broken on PPC?
Message-ID: <20030410213232.GB31167@wohnheim.fh-wedel.de>
References: <3E95AF4F.20105@kegel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <3E95AF4F.20105@kegel.com>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 10 April 2003 10:52:15 -0700, Dan Kegel wrote:
> 
> Hi Wolfgang, when you say you see more problems with gcc-3.x
> compilers, what is x?  I'd understand if you saw problems
> with gcc-3.0.*, but I had hoped that gcc-3.2.2 would compile
> good kernels for ppc.
> (Me, I'm still using Montavista Linux 2.0's gcc-2.95.3 to build my ppc 
> kernels,
> but am looking for an excuse to switch to gcc-3.2.* or gcc-3.3.*.)

We've had a "problem" with 3.2. Some conditional new code looked like
this:

#define LONG_MACRO \
	asm \
	asm \
	asm \
#ifdef FOO \
	asm \
	asm \
#else \
	asm \
#endif \
	asm \
	asm

Interesting, isn't it? The fun part was that it was compiling cleanly
in 3.2, but not in 2.95.
Sadly, noone bothered to compile this with 2.95 for a long time.

Jörn

-- 
More computing sins are committed in the name of efficiency (without
necessarily achieving it) than for any other single reason - including
blind stupidity.
-- W. A. Wulf 
