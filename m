Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266337AbUGPFP5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266337AbUGPFP5 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 16 Jul 2004 01:15:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266460AbUGPFP4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 16 Jul 2004 01:15:56 -0400
Received: from 209-128-98-078.BAYAREA.NET ([209.128.98.78]:44683 "EHLO
	terminus.zytor.com") by vger.kernel.org with ESMTP id S266337AbUGPE33
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 16 Jul 2004 00:29:29 -0400
Message-ID: <40F75984.4010002@zytor.com>
Date: Thu, 15 Jul 2004 21:28:52 -0700
From: "H. Peter Anvin" <hpa@zytor.com>
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.6) Gecko/20040510
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Linus Torvalds <torvalds@osdl.org>
CC: Mikael Pettersson <mikpe@csd.uu.se>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH][2.6.6-rc3] gcc-3.4.0 fixes
References: <200404292146.i3TLkfI0019612@harpo.it.uu.se> <c892nk$5pf$1@terminus.zytor.com> <16572.38987.239160.819836@alkaid.it.uu.se> <Pine.LNX.4.58.0406011020310.14095@ppc970.osdl.org>
In-Reply-To: <Pine.LNX.4.58.0406011020310.14095@ppc970.osdl.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds wrote:
> 
> I don't see any point where we cast any function pointers to anything 
> else.
> 
> We cast data pointers all over the place, but that is actually guaranteed
> to work in C for some "large enough" integer type, and "unsigned long" is
> pretty much it. 
> 

It would be nice at some point to switch that to [u]intptr_t, before someone 
comes up with 128-bit machines (in other words, no rush whatsoever, but after 
seeing Sony build processors with 128-bit integer registers I'm willing to 
believe it's just a matter of time...)  The other thing about it is that it's 
nice to be explicit about the "pointer-sized integerness" of it all.

> And even function pointers should be safeish. The fact that some broken
> architecture (can you say "ia64"?) has totally idiotic calling conventions
> and requires the caller to load the GP value is _their_ problem. The
> architecture will either die or hide the fact that it's being silly. For
> now it's hiding it.
> 
> Repeat after me: practice is more important than theory. A _lot_ more 
> important.

Indeed.

	-hpa
