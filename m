Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281321AbRKQVBK>; Sat, 17 Nov 2001 16:01:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281323AbRKQVBA>; Sat, 17 Nov 2001 16:01:00 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:62990 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S281321AbRKQVAw>; Sat, 17 Nov 2001 16:00:52 -0500
To: linux-kernel@vger.kernel.org
From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: i386 flags register clober in inline assembly
Date: 17 Nov 2001 13:00:17 -0800
Organization: Transmeta Corporation, Santa Clara CA
Message-ID: <9t6j51$lle$1@cesium.transmeta.com>
In-Reply-To: <87y9l58pb5.fsf@fadata.bg> <200111171920.fAHJKjJ01550@penguin.transmeta.com> <20011117214041.D3789@atrey.karlin.mff.cuni.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Disclaimer: Not speaking for Transmeta in any way, shape, or form.
Copyright: Copyright 2001 H. Peter Anvin - All Rights Reserved
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Followup to:  <20011117214041.D3789@atrey.karlin.mff.cuni.cz>
By author:    Jan Hubicka <jh@suse.cz>
In newsgroup: linux.dev.kernel
> 
> Actually the main dificulty I see is storing cc0 to variable.  CC0 is hard
> register and pretty strange one - you can't move it, you can't spill.  Using
> the syntax above you can easilly make cc0 from asm statement to span another
> cc0 set resulting in incorrect code or compiler crash.
> (the code generator may insert any code in between statements as it don't
> know he can't clobber cc0. In fact this is happening in from of if
> construct as deffered stack deallocators are flushed).
> 

Why can't you move or spill it?  There are a whole lot of ways you
could do either: pushf, sahf, setcc...

	-hpa
-- 
<hpa@transmeta.com> at work, <hpa@zytor.com> in private!
"Unix gives you enough rope to shoot yourself in the foot."
http://www.zytor.com/~hpa/puzzle.txt	<amsp@zytor.com>
