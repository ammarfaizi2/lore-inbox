Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269229AbRHIRs5>; Thu, 9 Aug 2001 13:48:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269119AbRHIRsv>; Thu, 9 Aug 2001 13:48:51 -0400
Received: from neon-gw.transmeta.com ([63.209.4.196]:10515 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S269229AbRHIRso>; Thu, 9 Aug 2001 13:48:44 -0400
To: linux-kernel@vger.kernel.org
From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: [ANNOUNCE] Gujin graphical bootloader 0.4
Date: 9 Aug 2001 10:48:24 -0700
Organization: Transmeta Corporation, Santa Clara CA
Message-ID: <9kuid8$q57$1@cesium.transmeta.com>
In-Reply-To: <Pine.LNX.4.33.0108060228220.10664-100000@hp.masroudeau.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Disclaimer: Not speaking for Transmeta in any way, shape, or form.
Copyright: Copyright 2001 H. Peter Anvin - All Rights Reserved
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Followup to:  <Pine.LNX.4.33.0108060228220.10664-100000@hp.masroudeau.com>
By author:    Etienne Lorrain <etienne@masroudeau.com>
In newsgroup: linux.dev.kernel
> 
>  - Loads Linux kernel images (zImage and bZimage) without the help
>    of LILO, and short-circuit all real-mode code in the kernel to
>    start at the first protected mode instruction of the kernel.
> 

This is a very bad idea.  The kernel entry point is in real mode for a
reason: it means that the kernel doesn't have to rely on the boot
loader to provide the services it needs from real mode before
entering protected mode once and for all.  The interface to the real
mode entry point is narrow and stable, the protected mode entrypoint
is a kernel internal and doesn't have an interface that is guaranteed
to be stable -- again, for good reason.

	-hpa
-- 
<hpa@transmeta.com> at work, <hpa@zytor.com> in private!
"Unix gives you enough rope to shoot yourself in the foot."
http://www.zytor.com/~hpa/puzzle.txt	<amsp@zytor.com>
