Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265759AbSLBX6H>; Mon, 2 Dec 2002 18:58:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265767AbSLBX6H>; Mon, 2 Dec 2002 18:58:07 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:45060 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S265759AbSLBX6F>; Mon, 2 Dec 2002 18:58:05 -0500
To: linux-kernel@vger.kernel.org
From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: Large block device patch, part 1 of 9
Date: 2 Dec 2002 16:05:17 -0800
Organization: Transmeta Corporation, Santa Clara CA
Message-ID: <asgsft$p0e$1@cesium.transmeta.com>
References: <15717.52317.654149.636236@wombat.chubb.wattle.id.au> <20020827185833.B26573@redhat.com> <15732.34929.657481.777572@notabene.cse.unsw.edu.au> <E17mJZh-0005jw-00@starship>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Disclaimer: Not speaking for Transmeta in any way, shape, or form.
Copyright: Copyright 2002 H. Peter Anvin - All Rights Reserved
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Followup to:  <E17mJZh-0005jw-00@starship>
By author:    Daniel Phillips <phillips@arcor.de>
In newsgroup: linux.dev.kernel
> 
> We've been through this before.  Last time, the winning solution was:
> 
>    printk("at least %lli of your u64s are belong to us\n", (long long) sect_num);
> 
> and I expect it will be this time too.  It's just a printk!  Who cares if it
> wastes a few bytes.  It's even conceivable that if we use this idiom heavily
> enough, some gcc boffin will take the time to optimize away the useless
> conversions.
> 

Why can't we use the C99 standard:

printk("at least %ji of your u64s are belong to us\n", (uintmax_t) sect_num);

I, for one, would be rather happy at having <inttypes.h> available in
the kernel, as either an alternative or instead of the [su]XX/__[su]XX types.

	-hpa
-- 
<hpa@transmeta.com> at work, <hpa@zytor.com> in private!
"Unix gives you enough rope to shoot yourself in the foot."
http://www.zytor.com/~hpa/puzzle.txt	<amsp@zytor.com>
