Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129076AbQKPSox>; Thu, 16 Nov 2000 13:44:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129132AbQKPSon>; Thu, 16 Nov 2000 13:44:43 -0500
Received: from sisley.ri.silicomp.fr ([62.160.165.44]:9487 "EHLO
	sisley.ri.silicomp.fr") by vger.kernel.org with ESMTP
	id <S129076AbQKPSod>; Thu, 16 Nov 2000 13:44:33 -0500
Date: Thu, 16 Nov 2000 19:14:21 +0100 (CET)
From: Jean-Marc Saffroy <saffroy@ri.silicomp.fr>
To: Linus Torvalds <torvalds@transmeta.com>
cc: viro@math.psu.edu, linux-kernel@vger.kernel.org,
        Eric Paire <paire@ri.silicomp.fr>
Subject: Re: [BUG] Inconsistent behaviour of rmdir
In-Reply-To: <Pine.LNX.4.10.10011160747260.2184-100000@penguin.transmeta.com>
Message-ID: <Pine.LNX.4.21.0011161904580.30811-100000@sisley.ri.silicomp.fr>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 16 Nov 2000, Linus Torvalds wrote:

> The cwd is not the problem. The '.' is.
> 
> The reason for that check is that allowing "rmdir(".")" confuses a lot of
> UNIX programs, because it wasn't traditionally allowed.

This is a point I don't understand here : do you mean that they are
confused if they can rmdir "." but not if they can rmdir their cwd
differently ? What's the difference ?

I am not saying that rmdir MUST be allowed on "." ; I just suggested that
it be allowed _because_ you can rmdir your cwd anyway. Now if rmdir "." is
forbidden, then I think rmdir `pwd` should fail as well. Or am I missing
something ?


-- 
Jean-Marc Saffroy - Research Engineer - Silicomp Research Institute
mailto:jms@migrantprogrammer.com

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
