Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267241AbSKVAqQ>; Thu, 21 Nov 2002 19:46:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267242AbSKVAqQ>; Thu, 21 Nov 2002 19:46:16 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:6158 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S267241AbSKVAqP>; Thu, 21 Nov 2002 19:46:15 -0500
To: linux-kernel@vger.kernel.org
From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: [PATCH] export e820 table on x86
Date: 21 Nov 2002 16:53:04 -0800
Organization: Transmeta Corporation, Santa Clara CA
Message-ID: <arjv5g$c2b$1@cesium.transmeta.com>
References: <3DDD7067.6090500@us.ibm.com> <Pine.LNX.4.44.0211211556340.5779-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Disclaimer: Not speaking for Transmeta in any way, shape, or form.
Copyright: Copyright 2002 H. Peter Anvin - All Rights Reserved
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Followup to:  <Pine.LNX.4.44.0211211556340.5779-100000@penguin.transmeta.com>
By author:    Linus Torvalds <torvalds@transmeta.com>
In newsgroup: linux.dev.kernel
> 
> See also how we artificially only show 32-bit resources, because "struct
> resource" uses "unsigned long". That's a design mistake, and it _should_
> be "u64" (this actually could cause problems already on 64-bit PCI on
> 32-bit hosts, although it appears that nobody even tries to map devices
> past the 4GB area anyway), but I've never had a test-case for fixing it
> and seeing any difference.
> 

Perhaps an abstract type, like resaddr_t, would make more sense?  That
way we'll have less of an issue when the next category of weird system
architecture comes along, which may want some kind of node-based
addressing, who knows...

	-hpa
-- 
<hpa@transmeta.com> at work, <hpa@zytor.com> in private!
"Unix gives you enough rope to shoot yourself in the foot."
http://www.zytor.com/~hpa/puzzle.txt	<amsp@zytor.com>
