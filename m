Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316235AbSHIWj5>; Fri, 9 Aug 2002 18:39:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316258AbSHIWj4>; Fri, 9 Aug 2002 18:39:56 -0400
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:63236 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S316235AbSHIWj4>; Fri, 9 Aug 2002 18:39:56 -0400
To: linux-kernel@vger.kernel.org
From: "H. Peter Anvin" <hpa@zytor.com>
Subject: klibc: Need psABIs and #defines
Date: 9 Aug 2002 15:43:23 -0700
Organization: Transmeta Corporation, Santa Clara CA
Message-ID: <aj1gib$6vd$1@cesium.transmeta.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Disclaimer: Not speaking for Transmeta in any way, shape, or form.
Copyright: Copyright 2002 H. Peter Anvin - All Rights Reserved
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

I could use some help with portability for non-x86 platforms.  In
particular, I need to figure out how to make crt0.[cS] to work on
various platforms, which unfortunately doesn't seem to be all that
obvious.  Unfortunately the SysV ABI creators didn't do the obvious
thing, which would have been to call _start() with its parameters
using the standard C calling sequence; instead, each platform seems to
put things on the stack in various ways (the sparc, for example, needs
a register window save area.)

a) If you'd be willing to write crt0.c/crt0.S for any platform, let me
   know. 

b) If you know where to get psABIs other than x86, x86-64, mips32 and
   sparc32, let me know.

c) If you know what #ifdefs one can use to test for any platform, let
   me know...

	-hpa
-- 
<hpa@transmeta.com> at work, <hpa@zytor.com> in private!
"Unix gives you enough rope to shoot yourself in the foot."
http://www.zytor.com/~hpa/puzzle.txt	<amsp@zytor.com>
