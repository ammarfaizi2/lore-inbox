Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263315AbTGOFqK (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Jul 2003 01:46:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263355AbTGOFqK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Jul 2003 01:46:10 -0400
Received: from pizda.ninka.net ([216.101.162.242]:32464 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id S263205AbTGOFp6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Jul 2003 01:45:58 -0400
Date: Mon, 14 Jul 2003 22:51:33 -0700
From: "David S. Miller" <davem@redhat.com>
To: "Jordi Ros" <jros@xiran.com>
Cc: linux-kernel@vger.kernel.org, linux-net@vger.kernel.org,
       netdev@oss.sgi.com, alan@storlinksemi.com
Subject: Re: TCP IP Offloading Interface
Message-Id: <20030714225133.18395b69.davem@redhat.com>
In-Reply-To: <E3738FB497C72449B0A81AEABE6E713C027A43@STXCHG1.simpletech.com>
References: <E3738FB497C72449B0A81AEABE6E713C027A43@STXCHG1.simpletech.com>
X-Mailer: Sylpheed version 0.9.2 (GTK+ 1.2.6; sparc-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 14 Jul 2003 22:42:55 -0700
"Jordi Ros" <jros@xiran.com> wrote:

[ Please fix Outlook Express or whatever lame email client you
  use to put newlines into the emails that you compose.  These
  excessive long lines make your emails nearly impossible to read ]

> TCP offloading does not necessarily need to be the goal but a MUST
> if one wants to build a performance-scalable architecture. This
> vision is in fact introduced by Mogul in his paper. He writes:
> "Therefore, offloading the transport layer becomes valuable not for
> its own sake, but rather because that allows offloading of the RDMA
> [...]".

I totally disagree.  It is not a MUST, in fact I have described
an alternative implementation that requires none of the complexity
or RDMA, and none of the stupidity of TOE.

Read my lips: "We do not need to offload TCP itself to get the
attributes you desire, therefore we are NOT going to do it."

You can choose to ignore my suggestions and likewise I will continue
to ignore the endless (and frankly, broing after reading it for the
100th time) spouting from people like you that we somehow "NEED" or
"MUST" have TOE, which is complete bullshit as exemplified by my
alternative example scheme.

You also ignore the points others have made that the systems HAVE
SCALED to evolving networks technologies as they have become faster
and faster.

And when you ignore me, don't be surprised when other companies come
along, implement my scheme, it gets supported in Linux and
subsequently the stock of your company effectively becomes toilet
paper and TOE is an obscure piece of computing history gone wrong :-)

> TOE is believed to not provide performance. I may agree that TOE by
> itself may not, but TOE as a means to deliver some other technology
> (e.g. RDMA, encryption or Direct Path) it does optimize (in some
> instance dramatically) the overall performance. Let me show you the
> numbers in our Direct Path technology. 

But our point is that you don't need any of this crap.

My RX receive page accumulation scheme handles all of the
receive side problems with touching the data and getting
into the filesystem and then the device.  With my scheme
you can receive the data, go direct to the device, and the
cpu never touches one byte.

> Note that Microsoft is considering TOE under its Scalable Networking
> Program. To keep linux competitive, I would encourage a healthy
> discussion on this matter

I actually welcome Microsoft falling into this rathole of a
technology.  Let them have to support that crap and have to field bug
reports on it, having to wonder who created the packets.  And let them
deal with the negative effects TOE has on connection rates and things
like that.

Linux will be competitive, especially if people develop the scheme I
have described several times into the hardware.  There are vendors
doing this, will you choose to be different and ignore this?
