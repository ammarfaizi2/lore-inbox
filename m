Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129735AbRABW0B>; Tue, 2 Jan 2001 17:26:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130077AbRABWZv>; Tue, 2 Jan 2001 17:25:51 -0500
Received: from neon-gw.transmeta.com ([209.10.217.66]:64011 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S129735AbRABWZr>; Tue, 2 Jan 2001 17:25:47 -0500
To: linux-kernel@vger.kernel.org
From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: Error compiling 2.4 with CVS gcc on Athlon
Date: 2 Jan 2001 13:55:03 -0800
Organization: Transmeta Corporation, Santa Clara CA
Message-ID: <92tinn$6pg$1@cesium.transmeta.com>
In-Reply-To: <3A523635.8080003@triad.rr.com> <20010102123913.A19554@twiddle.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Disclaimer: Not speaking for Transmeta in any way, shape, or form.
Copyright: Copyright 2001 H. Peter Anvin - All Rights Reserved
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Followup to:  <20010102123913.A19554@twiddle.net>
By author:    Richard Henderson <rth@twiddle.net>
In newsgroup: linux.dev.kernel
>
> On Tue, Jan 02, 2001 at 03:12:37PM -0500, Ghadi Shayban wrote:
> > {standard input}: Assembler messages:
> > {standard input}:139: Error: bad register name `%%mm0'
> 
> This is, in fact, a compiler bug.  Somehow the "%%" in the
> source didn't print as "%" as expected.
> 

Actually, gcc doesn't do % expansion (and hence %% -> %) if there are
no :'s in the asm() statement.  I don't know if that's the issue here,
though.

	-hpa
-- 
<hpa@transmeta.com> at work, <hpa@zytor.com> in private!
"Unix gives you enough rope to shoot yourself in the foot."
http://www.zytor.com/~hpa/puzzle.txt
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
