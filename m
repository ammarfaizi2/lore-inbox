Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263220AbTD1Lgk (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 28 Apr 2003 07:36:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263385AbTD1Lgk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 28 Apr 2003 07:36:40 -0400
Received: from zero.aec.at ([193.170.194.10]:54542 "EHLO zero.aec.at")
	by vger.kernel.org with ESMTP id S263220AbTD1Lgj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 28 Apr 2003 07:36:39 -0400
Date: Mon, 28 Apr 2003 13:47:17 +0200
From: Andi Kleen <ak@muc.de>
To: Adrian Bunk <bunk@fs.tum.de>
Cc: Andi Kleen <ak@muc.de>, torvalds@transmeta.com,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Support worst case cache line sizes as config option
Message-ID: <20030428114717.GA6904@averell>
References: <20030427022346.GA27933@averell> <20030428091616.GA27064@fs.tum.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030428091616.GA27064@fs.tum.de>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 28, 2003 at 11:16:16AM +0200, Adrian Bunk wrote:
> Your X86_GENERIC is semantically equivalent to M386.

M386 is tuning for the Intel 386

X86_GENERIC is "try to tune for all CPUs if possible" 

> This doesn't work. E.g. MPENTIUMIII has the semantics of "support 
> Pentium-III and above". If you want to compile a kernel that runs on 
> both a Pentium-III and a Pentium-4 you choose MPENTIUMIII which implies 
> X86_L1_CACHE_SHIFT=5 ...

Admittedly the other options could be changed to 

default "4" if (MELAN || M486 || M386) && !X86_GENERIC

but that looked a bit too ugly and it seems to work even without.


-Andi
