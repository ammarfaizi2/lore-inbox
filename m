Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131024AbQKKBHj>; Fri, 10 Nov 2000 20:07:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131048AbQKKBHU>; Fri, 10 Nov 2000 20:07:20 -0500
Received: from neon-gw.transmeta.com ([209.10.217.66]:6413 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S131024AbQKKBHQ>; Fri, 10 Nov 2000 20:07:16 -0500
To: linux-kernel@vger.kernel.org
From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: Where is it written?
Date: 10 Nov 2000 17:06:41 -0800
Organization: Transmeta Corporation, Santa Clara CA
Message-ID: <8ui631$c1v$1@cesium.transmeta.com>
In-Reply-To: <20001110184031.A2704@munchkin.spectacle-pond.org> <200011110011.eAB0BbF244111@saturn.cs.uml.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Disclaimer: Not speaking for Transmeta in any way, shape, or form.
Copyright: Copyright 2000 H. Peter Anvin - All Rights Reserved
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Followup to:  <200011110011.eAB0BbF244111@saturn.cs.uml.edu>
By author:    "Albert D. Cahalan" <acahalan@cs.uml.edu>
In newsgroup: linux.dev.kernel
> 
> Gee that looks old. Might there be better calling conventions
> for the Pentium 4 or Athlon? Memory latency, vector registers,
> and more direct access to floating-point registers may mean
> we ought to change the calling conventions. One would start
> with the kernel of course, because it stands alone.
> 

The main win would be passing arguments in registers -- at least three
such registers could be used (%eax, %edx, %ecx) without increasing
register pressure.  Doing this for nonvaradic functions probably would
be a win.  Similarly, floating-point arguments and SSE arguments could
be passed in registers, and _Bool output (a C99 feature) could at
least theoretically be returned in a flag.

	-hpa
-- 
<hpa@transmeta.com> at work, <hpa@zytor.com> in private!
"Unix gives you enough rope to shoot yourself in the foot."
http://www.zytor.com/~hpa/puzzle.txt
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
