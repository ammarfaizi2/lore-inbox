Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281297AbRLABF7>; Fri, 30 Nov 2001 20:05:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S283859AbRLABFt>; Fri, 30 Nov 2001 20:05:49 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:28939 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S281297AbRLABFc>; Fri, 30 Nov 2001 20:05:32 -0500
To: linux-kernel@vger.kernel.org
From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: [PATCH] task_struct colouring ...
Date: 30 Nov 2001 17:05:20 -0800
Organization: Transmeta Corporation, Santa Clara CA
Message-ID: <9u9acg$rrl$1@cesium.transmeta.com>
In-Reply-To: <E169xWr-0005EM-00@the-village.bc.nu> <Pine.LNX.4.40.0111301614000.1600-100000@blue1.dev.mcafeelabs.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Disclaimer: Not speaking for Transmeta in any way, shape, or form.
Copyright: Copyright 2001 H. Peter Anvin - All Rights Reserved
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Followup to:  <Pine.LNX.4.40.0111301614000.1600-100000@blue1.dev.mcafeelabs.com>
By author:    Davide Libenzi <davidel@xmailserver.org>
In newsgroup: linux.dev.kernel
> 
> The point is why store kernel pointers in global registers when You can
> achieve the same functionality, with a smaller patch, that does not need
> to be recoded for each CPU, without using global registers.
> 

Because global registers are faster!  This is exactly the kind of
stuff that is properly CPU-dependent and should be treated as such.
Heck, it even depends on what kind of multiprocessor architecture, if
any, you're using!

That being said, I belive that on most, if not all, processors, the
idea of having the pointer point not to "current" but to a per-CPU
memory area is *very* appealing, and a change that should be made
uniform unless it's a significant lose on some machines...

	-hpa
-- 
<hpa@transmeta.com> at work, <hpa@zytor.com> in private!
"Unix gives you enough rope to shoot yourself in the foot."
http://www.zytor.com/~hpa/puzzle.txt	<amsp@zytor.com>
