Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129811AbQLCHrv>; Sun, 3 Dec 2000 02:47:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130688AbQLCHrm>; Sun, 3 Dec 2000 02:47:42 -0500
Received: from neon-gw.transmeta.com ([209.10.217.66]:40976 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S129811AbQLCHrb>; Sun, 3 Dec 2000 02:47:31 -0500
To: linux-kernel@vger.kernel.org
From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: /dev/random probs in 2.4test(12-pre3)
Date: 2 Dec 2000 23:16:20 -0800
Organization: Transmeta Corporation, Santa Clara CA
Message-ID: <90cs04$6td$1@cesium.transmeta.com>
In-Reply-To: <Pine.LNX.4.10.10012021108350.31306-100000@sphinx.mythic-beasts.com> <Pine.LNX.4.21.0012021955570.11787-100000@server.serve.me.nl>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Disclaimer: Not speaking for Transmeta in any way, shape, or form.
Copyright: Copyright 2000 H. Peter Anvin - All Rights Reserved
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Followup to:  <Pine.LNX.4.21.0012021955570.11787-100000@server.serve.me.nl>
By author:    Igmar Palsenberg <maillist@chello.nl>
In newsgroup: linux.dev.kernel
>
> > Indeed, you are correct.  Is vpnd broken then, for assuming
> > that it can gather the required randomness in one read?
> 
> Yep. It assumes that if the required randommness numbers aren't met a read
> to /dev/random will block.
> 
> And it's not the only program that assumes this : I also did. 
> 
> /dev/random is called a blocking random device, which more or less implies
> that it will totally block. I suggest we put this somewhere in the kernel
> docs, since lots of people out there assume that it totally blocks.
> 

That's pretty much ALWAYS wrong -- for pipes, sockets, you name it.  A
blocking read() will only block if there is nothing to read at all.

	-hpa
-- 
<hpa@transmeta.com> at work, <hpa@zytor.com> in private!
"Unix gives you enough rope to shoot yourself in the foot."
http://www.zytor.com/~hpa/puzzle.txt
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
