Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263051AbSJGOaD>; Mon, 7 Oct 2002 10:30:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263058AbSJGOaD>; Mon, 7 Oct 2002 10:30:03 -0400
Received: from chaos.physics.uiowa.edu ([128.255.34.189]:2691 "EHLO
	chaos.physics.uiowa.edu") by vger.kernel.org with ESMTP
	id <S263051AbSJGOaC>; Mon, 7 Oct 2002 10:30:02 -0400
Date: Mon, 7 Oct 2002 09:35:35 -0500 (CDT)
From: Kai Germaschewski <kai-germaschewski@uiowa.edu>
X-X-Sender: kai@chaos.physics.uiowa.edu
To: "David S. Miller" <davem@redhat.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: kbuild news
In-Reply-To: <20021007.072426.93474936.davem@redhat.com>
Message-ID: <Pine.LNX.4.44.0210070934580.14294-100000@chaos.physics.uiowa.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 7 Oct 2002, David S. Miller wrote:

>    I'll take a look on how to do sparc's btfixup in a similar way, without 
>    messing up the common code too much. BTW, the combination kallsyms +
>    btfixup, does that need a particular ordering?
> 
> No, the kallsyms object file would not need to be seen by
> the btfixup.o generator.  It could therefore be done validly
> as:
> 
> 	1) build .tmp_vmlinux
> 	2) build btfixup.o
> 	3) build kallsyms
> 	4) link final vmlinux image
> 
> The order of #2 and #3 could be transposed and that would be fine too.

Alright, that's helpful ;)

--Kai


