Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262711AbTDRASA (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Apr 2003 20:18:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262710AbTDRAR7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Apr 2003 20:17:59 -0400
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:36613 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id S262689AbTDRAR6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Apr 2003 20:17:58 -0400
To: linux-kernel@vger.kernel.org
From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: [BK+PATCH] remove __constant_memcpy
Date: 17 Apr 2003 17:29:23 -0700
Organization: Transmeta Corporation, Santa Clara CA
Message-ID: <b7ngt3$eln$1@cesium.transmeta.com>
References: <3E9F3D6F.9030501@pobox.com> <Pine.LNX.4.44.0304171654530.14595-100000@home.transmeta.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Disclaimer: Not speaking for Transmeta in any way, shape, or form.
Copyright: Copyright 2003 H. Peter Anvin - All Rights Reserved
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Followup to:  <Pine.LNX.4.44.0304171654530.14595-100000@home.transmeta.com>
By author:    Linus Torvalds <torvalds@transmeta.com>
In newsgroup: linux.dev.kernel
> 
> > 2) why no sse2-optimized memcpy?  just that noone has done one yet?
> 
> Yes. If you want to, it's definitely the right thing to do. More so than 
> the 3dnow stuff that is by now ancient. HOWEVER, I don't think there are 
> any really valid large memcpy() calls inside the kernel. All the valid 
> ones are either special-cased (ie "copy_page()") or to user space.
> 

It's questionable, though, if SSE-2 buys you anything SSE-1 doesn't
already have.  SSE-2 is basically integer and scalar ops for SSE, but
data moving and even XOR is perfectly well handled by SSE-1.

	-hpa
-- 
<hpa@transmeta.com> at work, <hpa@zytor.com> in private!
"Unix gives you enough rope to shoot yourself in the foot."
Architectures needed: ia64 m68k mips64 ppc ppc64 s390 s390x sh v850 x86-64
