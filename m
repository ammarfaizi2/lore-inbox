Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261188AbVAWCjj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261188AbVAWCjj (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 22 Jan 2005 21:39:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261189AbVAWCji
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 22 Jan 2005 21:39:38 -0500
Received: from one.firstfloor.org ([213.235.205.2]:17879 "EHLO
	one.firstfloor.org") by vger.kernel.org with ESMTP id S261188AbVAWCjh
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 22 Jan 2005 21:39:37 -0500
To: Felipe Alfaro Solana <lkml@mac.com>
Cc: Trond Myklebust <trond.myklebust@fys.uio.no>, linux-kernel@vger.kernel.org,
       Buck Huppmann <buchk@pobox.com>, Neil Brown <neilb@cse.unsw.edu.au>,
       Andreas Gruenbacher <agruen@suse.de>,
       "Andries E. Brouwer" <Andries.Brouwer@cwi.nl>,
       Andrew Morton <akpm@osdl.org>, Olaf Kirch <okir@suse.de>
Subject: Re: [patch 1/13] Qsort
References: <20050122203326.402087000@blunzn.suse.de>
	<20050122203618.962749000@blunzn.suse.de>
	<Pine.LNX.4.58.0501221257440.1982@shell3.speakeasy.net>
	<FB9BAC88-6CE2-11D9-86B4-000D9352858E@mac.com>
From: Andi Kleen <ak@muc.de>
Date: Sun, 23 Jan 2005 03:39:34 +0100
In-Reply-To: <FB9BAC88-6CE2-11D9-86B4-000D9352858E@mac.com> (Felipe Alfaro
 Solana's message of "Sun, 23 Jan 2005 03:03:32 +0100")
Message-ID: <m1r7kc27ix.fsf@muc.de>
User-Agent: Gnus/5.110002 (No Gnus v0.2) Emacs/21.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Felipe Alfaro Solana <lkml@mac.com> writes:
>
> AFAIK, XOR is quite expensive on IA32 when compared to simple MOV
> operatings. Also, since the original patch uses 3 MOVs to perform the
> swapping, and your version uses 3 XOR operations, I don't see any
> gains.

Both are one cycle latency for register<->register on all x86 cores
I've looked at. What makes you think differently?

-Andi (who thinks the glibc qsort is vast overkill for kernel purposes
where there are only small data sets and it would be better to use a 
simpler one optimized for code size)

