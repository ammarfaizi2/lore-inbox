Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261501AbREOUwi>; Tue, 15 May 2001 16:52:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261503AbREOUw2>; Tue, 15 May 2001 16:52:28 -0400
Received: from neon-gw.transmeta.com ([209.10.217.66]:65288 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S261501AbREOUwM>; Tue, 15 May 2001 16:52:12 -0400
Date: Tue, 15 May 2001 13:51:43 -0700 (PDT)
From: Linus Torvalds <torvalds@transmeta.com>
To: Alexander Viro <viro@math.psu.edu>
cc: "H. Peter Anvin" <hpa@transmeta.com>,
        James Simmons <jsimmons@transvirtual.com>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>,
        Neil Brown <neilb@cse.unsw.edu.au>,
        Jeff Garzik <jgarzik@mandrakesoft.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: LANANA: To Pending Device Number Registrants
In-Reply-To: <Pine.GSO.4.21.0105151632380.21081-100000@weyl.math.psu.edu>
Message-ID: <Pine.LNX.4.21.0105151345410.2569-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Tue, 15 May 2001, Alexander Viro wrote:
>
> If you want them all to inherit it - inherit from mountpoint.

..which is exactly what the device node ends up being. The implicit
mount-point.

And which point, btw, it is completely indistinguishable to user space
whether the thing is implemented as a full filesystem, or whether it's
just that the device node exports a simple "lookup()" that it passes down
to the device driver. So this is also the point where it becomes nothing
but an implementation issue, and as such it's much less contentious.

Done right, they'll be automatic mount-points, which gives us:
 - perfect backwards compatibility (opening just the node will do what it
   has always done)
 - _zero_ extra system administration.

And I really think the zero system administration thing is the important
one. For some reason, sysadmin is where all the fights break out (see
devfs, but historically we had all the same problems with the original
device naming etc).

Sysadmin and editors. The holy wars of UNIX.

		Linus

