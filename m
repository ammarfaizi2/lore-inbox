Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265409AbSLBX4d>; Mon, 2 Dec 2002 18:56:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265413AbSLBX4d>; Mon, 2 Dec 2002 18:56:33 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:40196 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S265409AbSLBX4c>; Mon, 2 Dec 2002 18:56:32 -0500
To: linux-kernel@vger.kernel.org
From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: Large block device patch, part 1 of 9
Date: 2 Dec 2002 16:03:44 -0800
Organization: Transmeta Corporation, Santa Clara CA
Message-ID: <asgsd0$ovi$1@cesium.transmeta.com>
References: <15732.34929.657481.777572@notabene.cse.unsw.edu.au> <Pine.LNX.4.44.0209030900410.1997-100000@home.transmeta.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Disclaimer: Not speaking for Transmeta in any way, shape, or form.
Copyright: Copyright 2002 H. Peter Anvin - All Rights Reserved
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Followup to:  <Pine.LNX.4.44.0209030900410.1997-100000@home.transmeta.com>
By author:    Linus Torvalds <torvalds@transmeta.com>
In newsgroup: linux.dev.kernel
> 
> I wonder if the right answer isn't to just make things like "__u64" be
> "long long" even on 64-bit architectures (at least those on which it is 64
> bit, of course. I _think_ that's true of all of them). And then just use 
> "llu" for it all.
> 
> Of course, the really _best_ option would be to have gcc's printf string 
> format be extensible and dynamic.
> 
> Davem, is sparc64 "long long" 64-bit?
> 

Some C libraries have "Ixx" as an extension meaning (u)intXX_t -- it's
used in the same way as the other size modifiers, i.e. %I64x instead
of %lx.  This might be a useful extension to mimic.

	-hpa
-- 
<hpa@transmeta.com> at work, <hpa@zytor.com> in private!
"Unix gives you enough rope to shoot yourself in the foot."
http://www.zytor.com/~hpa/puzzle.txt	<amsp@zytor.com>
