Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312574AbSDXTVm>; Wed, 24 Apr 2002 15:21:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312575AbSDXTVl>; Wed, 24 Apr 2002 15:21:41 -0400
Received: from tmr-02.dsl.thebiz.net ([216.238.38.204]:62475 "EHLO
	gatekeeper.tmr.com") by vger.kernel.org with ESMTP
	id <S312574AbSDXTVk>; Wed, 24 Apr 2002 15:21:40 -0400
Date: Wed, 24 Apr 2002 15:18:14 -0400 (EDT)
From: Bill Davidsen <davidsen@tmr.com>
To: "Saxena, Sunil" <sunil.saxena@intel.com>
cc: "'Andi Kleen'" <ak@muc.de>, linux-kernel@vger.kernel.org
Subject: RE: Initial process CPU state was Re: SSE related security hole
In-Reply-To: <9287DC1579B0D411AA2F009027F44C3F171C1AC9@FMSMSX41>
Message-ID: <Pine.LNX.3.96.1020424151712.3065E-100000@gatekeeper.tmr.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 23 Apr 2002, Saxena, Sunil wrote:

> The correct sequence for initializing MMX/SSE/SSE2 CPU state (I exchanged
> mail with Linus) is:
> 
> 	memset(&fxsave, 0, sizeof(struct i387_fxsave_struct));
> 	fxsave.cwd = 0x37f;
> 	fxsave.mxcsr = 0x1f80;
> 
> 	fxrstor(&fxsave);
> 
> The above is architectural feature and you can expect this to work in the
> future.   Intel will work to document this in our Monthly Specification
> Updates and update "IA-32 Intel(R) Architecture Software Developer Manual"s.

Sure is nice to see some vendor support!

-- 
bill davidsen <davidsen@tmr.com>
  CTO, TMR Associates, Inc
Doing interesting things with little computers since 1979.

