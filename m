Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263031AbSJGORP>; Mon, 7 Oct 2002 10:17:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263058AbSJGORO>; Mon, 7 Oct 2002 10:17:14 -0400
Received: from chaos.physics.uiowa.edu ([128.255.34.189]:64898 "EHLO
	chaos.physics.uiowa.edu") by vger.kernel.org with ESMTP
	id <S263040AbSJGORN>; Mon, 7 Oct 2002 10:17:13 -0400
Date: Mon, 7 Oct 2002 09:22:51 -0500 (CDT)
From: Kai Germaschewski <kai-germaschewski@uiowa.edu>
X-X-Sender: kai@chaos.physics.uiowa.edu
To: "David S. Miller" <davem@redhat.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: kbuild news
In-Reply-To: <20021007.010843.130618724.davem@redhat.com>
Message-ID: <Pine.LNX.4.44.0210070919330.14294-100000@chaos.physics.uiowa.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 7 Oct 2002, David S. Miller wrote:

>    From: Kai Germaschewski <kai-germaschewski@uiowa.edu>
>    Date: Sat, 5 Oct 2002 21:10:06 -0500 (CDT)
> 
>    o The final link of vmlinux is now always done as a two step process:
> 
> This doesn't seem to be happening "always" now in current
> 2.5.x, I did not see a .tmp_vmlinux get generated.
> 
> It seems the whole mechanism to do kallsyms got redone since
> you sent this email.

Yes, that's true, my idea on how to do that was completely broken, so 
we're basically back to the old way.

BTW: That also means that your and everybody's vmlinux.lds.S does *not* 
need adapting.

I'll take a look on how to do sparc's btfixup in a similar way, without 
messing up the common code too much. BTW, the combination kallsyms +
btfixup, does that need a particular ordering?

--Kai


