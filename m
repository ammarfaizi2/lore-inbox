Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268191AbTBNBTk>; Thu, 13 Feb 2003 20:19:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268192AbTBNBTk>; Thu, 13 Feb 2003 20:19:40 -0500
Received: from ns.suse.de ([213.95.15.193]:8205 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id <S268191AbTBNBTj>;
	Thu, 13 Feb 2003 20:19:39 -0500
Date: Fri, 14 Feb 2003 02:29:31 +0100
From: Andi Kleen <ak@suse.de>
To: Peter Tattam <peter@jazz-1.trumpet.com.au>
Cc: Andi Kleen <ak@suse.de>, "Eric W. Biederman" <ebiederm@xmission.com>,
       linux-kernel@vger.kernel.org, discuss@x86-64.org
Subject: Re: [discuss] Re: [Bug 350] New: i386 context switch very slow compared to 2.4 due to wrmsr (performance)
Message-ID: <20030214012931.GA24282@wotan.suse.de>
References: <20030213180705.GB27560@wotan.suse.de> <Pine.BSF.3.96.1030214103845.369E-100000@jazz-1.trumpet.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.BSF.3.96.1030214103845.369E-100000@jazz-1.trumpet.com.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> I have a need to run v86 code from ring 0, so I'm not keen to slip other
...

[for the unsuspecting readers - Peter is talking about non Linux here]


> people's code in there.  This would mean I'd need to write a v86 emulator from
> scratch which I think is more time than writing the warping code that I've
> suggested.

Have you taken a look at valgrind? (http://developer.kde.org/~sewardj/)

It is a free software x86 JIT. I don't think it supports 16bit code currently,
but it probably wouldn't be too difficult to add. It wasn't primarily designed
for speed - its main application is to instrument programs - but its slowdown
compared to running on the real CPU is moderate and its certainly fast enough
for anything designed to run on DoS.

-Andi
