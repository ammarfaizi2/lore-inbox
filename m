Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265770AbSLBX7l>; Mon, 2 Dec 2002 18:59:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265773AbSLBX7l>; Mon, 2 Dec 2002 18:59:41 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:52228 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S265770AbSLBX7j>; Mon, 2 Dec 2002 18:59:39 -0500
To: linux-kernel@vger.kernel.org
From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: Large block device patch, part 1 of 9
Date: 2 Dec 2002 16:06:51 -0800
Organization: Transmeta Corporation, Santa Clara CA
Message-ID: <asgsir$p18$1@cesium.transmeta.com>
References: <p73u1l7qbxs.fsf@oldwotan.suse.de> <Pine.LNX.4.44.0209030113420.12861-100000@kiwi.transmeta.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Disclaimer: Not speaking for Transmeta in any way, shape, or form.
Copyright: Copyright 2002 H. Peter Anvin - All Rights Reserved
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Followup to:  <Pine.LNX.4.44.0209030113420.12861-100000@kiwi.transmeta.com>
By author:    Linus Torvalds <torvalds@transmeta.com>
In newsgroup: linux.dev.kernel
> 
> The printk warnings should be easy to fix once everybody uses the same
> types - I think we right now have workarounds exactly for 64-bit machines
> where w check BITS_PER_LONG and use different formats for them (exactly
> because they historically have _not_ had the same types as the 32-bit
> machines).
> 
> However, if anybody on the list is hacking gcc, the best option really
> would be to just allow better control over gcc printf formats. I have
> wanted that in user space too at times. And it doesn't matter if it only
> happens in new versions of gcc - we can disable the warning altogether for
> old gcc's, as long as enough people have the new gcc to catch new
> offenders..
> 
> (I'd _love_ to be able to add printk modifiers for other common types in
> the kernel, like doing the NIPQUAD thing etc inside printk() instead of
> having it pollute the callers. All of which has been avoided because of
> the hardcoded gcc format warning..)
> 

While we're talking about printk()... is there any reason *not* to
rename it printf()?

	-hpa
-- 
<hpa@transmeta.com> at work, <hpa@zytor.com> in private!
"Unix gives you enough rope to shoot yourself in the foot."
http://www.zytor.com/~hpa/puzzle.txt	<amsp@zytor.com>
