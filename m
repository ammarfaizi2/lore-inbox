Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281820AbRKQUfU>; Sat, 17 Nov 2001 15:35:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281821AbRKQUfL>; Sat, 17 Nov 2001 15:35:11 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:28174 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S281820AbRKQUev>; Sat, 17 Nov 2001 15:34:51 -0500
Date: Sat, 17 Nov 2001 12:30:17 -0800 (PST)
From: Linus Torvalds <torvalds@transmeta.com>
To: Momchil Velikov <velco@fadata.bg>
cc: <jh@suse.cz>, <linux-kernel@vger.kernel.org>
Subject: Re: i386 flags register clober in inline assembly
In-Reply-To: <87r8qx6t8j.fsf@fadata.bg>
Message-ID: <Pine.LNX.4.33.0111171228260.1706-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On 17 Nov 2001, Momchil Velikov wrote:
>
> Indeed, with pattern like:
> (define_insn "*ja"
>   [(set (pc)
>         (if_then_else (gtu (match_operand:CC 0 "" "") (const_int 0))
>                       (label_ref (match_operand 1 "" ""))
> 		      (pc)))]
>   ""
>   "ja ..."
>   ...)

As far as I can tell, that pattern already exists in i386.md.

So it shouldn't need any new patterns, it would only need a way to allow
the setting of cc0 from the asm - so that we can get the first part,
namely the "(set (cc0) ..asm..)" thing.

		Linus

