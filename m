Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262931AbTESVD2 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 19 May 2003 17:03:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262934AbTESVD1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 19 May 2003 17:03:27 -0400
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:24585 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id S262931AbTESVD0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 19 May 2003 17:03:26 -0400
To: linux-kernel@vger.kernel.org
From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: Recent changes to sysctl.h breaks glibc
Date: 19 May 2003 14:16:04 -0700
Organization: Transmeta Corporation, Santa Clara CA
Message-ID: <babhik$sbd$1@cesium.transmeta.com>
References: <20030519165623.GA983@mars.ravnborg.org> <Pine.LNX.4.44.0305191039320.16596-100000@home.transmeta.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Disclaimer: Not speaking for Transmeta in any way, shape, or form.
Copyright: Copyright 2003 H. Peter Anvin - All Rights Reserved
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Followup to:  <Pine.LNX.4.44.0305191039320.16596-100000@home.transmeta.com>
By author:    Linus Torvalds <torvalds@transmeta.com>
In newsgroup: linux.dev.kernel
> 
> A number of headers have historical baggage, mainly to support the 
> old libc5 habits, and because removing the ifdef's is something that 
> nobody has felt was worth the pain.
> 
> I think the only header file that should be considered truly exported is 
> something like "asm/posix_types.h". For the others, we'll add __KERNEL__ 
> protection on demand if the glibc guys can give good arguments that it 
> helps them do the "copy-and-cleanup" phase.
> 

Copy and cleanup isn't realistic either, though, because it doesn't
track ABI changes.  ABI headers is the only realistic solution.  We
can't realistically get real ABI headers for 2.5, so please don't just
break things randomly until then.

	-hpa
-- 
<hpa@transmeta.com> at work, <hpa@zytor.com> in private!
"Unix gives you enough rope to shoot yourself in the foot."
Architectures needed: ia64 m68k mips64 ppc ppc64 s390 s390x sh v850 x86-64
