Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262481AbRENUbC>; Mon, 14 May 2001 16:31:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262484AbRENUaw>; Mon, 14 May 2001 16:30:52 -0400
Received: from neon-gw.transmeta.com ([209.10.217.66]:23556 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S262481AbRENUai>; Mon, 14 May 2001 16:30:38 -0400
Date: Mon, 14 May 2001 13:29:51 -0700 (PDT)
From: Linus Torvalds <torvalds@transmeta.com>
To: Jeff Garzik <jgarzik@mandrakesoft.com>
cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, "H. Peter Anvin" <hpa@transmeta.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        <viro@math.psu.edu>
Subject: Re: LANANA: To Pending Device Number Registrants
In-Reply-To: <3B003EFC.61D9C16A@mandrakesoft.com>
Message-ID: <Pine.LNX.4.31.0105141328020.22874-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Mon, 14 May 2001, Jeff Garzik wrote:
>
> Note also that persistence of permissions and hardcoded in-kernel naming
> is a problem throughout proc...  It's not unique to in-driver
> filesystems.

Also note how a 32-bit (or 64-bit) dev_t does NOT make it any easier to
manage permissions or anything like that anyway. Look at the current mess
/dev is. Imagine it an order of magnitude worse.

Big device numbers are _not_ a solution. I will accept a 32-bit one, but
no more, and I will _not_ accept a "manage by hand" approach any more. The
time has long since come to say "No". Which I've done. If you can't make
it manage the thing automatically with a script, you won't get a hardcoded
major device number just because you're lazy.

End of discussion.

		Linus

