Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S285273AbSALHxV>; Sat, 12 Jan 2002 02:53:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S285161AbSALHxM>; Sat, 12 Jan 2002 02:53:12 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:13324 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S285099AbSALHxI>; Sat, 12 Jan 2002 02:53:08 -0500
To: linux-kernel@vger.kernel.org
From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: [Q] Looking for an emulation for CMOV* instructions.
Date: 11 Jan 2002 23:52:50 -0800
Organization: Transmeta Corporation, Santa Clara CA
Message-ID: <a1oq0i$ino$1@cesium.transmeta.com>
In-Reply-To: <m26669olcu.fsf@goliath.csn.tu-chemnitz.de.suse.lists.linux.kernel> <E16Oocq-0005tX-00@the-village.bc.nu.suse.lists.linux.kernel> <p737kqpp60w.fsf@oldwotan.suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Disclaimer: Not speaking for Transmeta in any way, shape, or form.
Copyright: Copyright 2002 H. Peter Anvin - All Rights Reserved
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Followup to:  <p737kqpp60w.fsf@oldwotan.suse.de>
By author:    Andi Kleen <ak@suse.de>
In newsgroup: linux.dev.kernel
>  
> One corner case where emulation would IMHO make sense would be CMPXCHG8.
> It would allow to do efficient inline mutexes in pthreads, and hit the
> emulation only on 386/486. cpu feature flag checking is unfortunately
> not an option normally for inline code.
> 

You don't need CMPXCHG8B to do efficient inline mutexes.  In fact, the
pthreads code for i386 uses the same mutexes the kernel does (LOCK INC
based, I believe), complete with section hacking to make them
efficiently inlinable -- and then they're put inside a function call.
I believe "kill me now" is an appropriate response.

	-hpa

-- 
<hpa@transmeta.com> at work, <hpa@zytor.com> in private!
"Unix gives you enough rope to shoot yourself in the foot."
http://www.zytor.com/~hpa/puzzle.txt	<amsp@zytor.com>
