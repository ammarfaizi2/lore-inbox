Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S285042AbRLMTjw>; Thu, 13 Dec 2001 14:39:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S285079AbRLMTjc>; Thu, 13 Dec 2001 14:39:32 -0500
Received: from freki.otago.ac.nz ([139.80.32.87]:34958 "EHLO freki.otago.ac.nz")
	by vger.kernel.org with ESMTP id <S285053AbRLMTjY>;
	Thu, 13 Dec 2001 14:39:24 -0500
Date: Fri, 14 Dec 2001 08:39:20 +1300 (NZDT)
From: Corrin Lakeland <lakeland@cs.otago.ac.nz>
X-X-Sender: <lakeland@freki.otago.ac.nz>
Reply-To: <lakeland@acm.org>
To: <linux-kernel@vger.kernel.org>
Subject: Re: 2.4.16 not booting with Athlon optimisations
Message-ID: <Pine.LNX.4.33.0112140827020.21910-100000@freki.otago.ac.nz>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello all again,

Firstly, thanks for the quick responses!

A number of people suggested the problem was the memory write queue, via
chipset, Athlon bug.  Looking into this I found I have a VIA chipset that
wasn't supported by 2.4.16 so the workaround wasn't being activated.

Last night I applied the 2.4.17-pre8 patch as well as a via-mwq.patch that
Troels sent me since the mwq appeard to add support for my chipset while
.17 didn't.  These both applied fine and the machine booted with Duron
optimisation on :-)  I ran an overnight stress test and it seems to be
stable.

So now all I have to do is remove the mwq patch to see if the problem was
solved just by upgrading to .17.  I'll report back once I've found exactly
what fixed it.

Many thanks to all

Corrin

