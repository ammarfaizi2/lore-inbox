Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314459AbSDRVHB>; Thu, 18 Apr 2002 17:07:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314460AbSDRVHA>; Thu, 18 Apr 2002 17:07:00 -0400
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:2829 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S314459AbSDRVHA>; Thu, 18 Apr 2002 17:07:00 -0400
To: linux-kernel@vger.kernel.org
From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: SSE related security hole
Date: 18 Apr 2002 14:06:36 -0700
Organization: Transmeta Corporation, Santa Clara CA
Message-ID: <a9ncgs$2s2$1@cesium.transmeta.com>
In-Reply-To: <20020418183639.20946.qmail@science.horizon.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Disclaimer: Not speaking for Transmeta in any way, shape, or form.
Copyright: Copyright 2002 H. Peter Anvin - All Rights Reserved
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Followup to:  <20020418183639.20946.qmail@science.horizon.com>
By author:    linux@horizon.com
In newsgroup: linux.dev.kernel
>
> Um, people here seem to be assuming that, in the absence of MMX,
> fninit *doesn't* leak information.
> 
> I thought it was well-known to just clear (set to all-ones) the
> tag register and not alter the actual floating-point registers.
> 
> Thus, it seems quite feasible to reset the tag word with FLDENV and
> store out the FPU registers, even on an 80387.
> 
> Isn't this the same security hole?  Shouldn't there be 8 FLDZ instructions
> (or equivalent) in the processor state initialization?
> 

Perhaps the right thing to do is to have a description in data of the
desired initialization state and just F[NX]RSTOR it?

	-hpa
-- 
<hpa@transmeta.com> at work, <hpa@zytor.com> in private!
"Unix gives you enough rope to shoot yourself in the foot."
http://www.zytor.com/~hpa/puzzle.txt	<amsp@zytor.com>
