Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269299AbUJFPiu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269299AbUJFPiu (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Oct 2004 11:38:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269298AbUJFPiC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Oct 2004 11:38:02 -0400
Received: from ts2-075.twistspace.com ([217.71.122.75]:42397 "EHLO entmoot.nl")
	by vger.kernel.org with ESMTP id S269314AbUJFPfg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Oct 2004 11:35:36 -0400
Message-ID: <001801c4abc2$8908d8c0$161b14ac@boromir>
From: "Martijn Sipkema" <martijn@entmoot.nl>
To: "David S. Miller" <davem@davemloft.net>, <root@chaos.analogic.com>
Cc: <joris@eljakim.nl>, <linux-kernel@vger.kernel.org>
References: <Pine.LNX.4.58.0410061616420.22221@eljakim.netsystem.nl><20041006080104.76f862e6.davem@davemloft.net><Pine.LNX.4.61.0410061110260.6661@chaos.analogic.com> <20041006082145.7b765385.davem@davemloft.net>
Subject: Re: UDP recvmsg blocks after select(), 2.6 bug?
Date: Wed, 6 Oct 2004 17:35:47 +0100
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2800.1437
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1441
X-MailScanner-Information: Please contact the ISP for more information
X-MailScanner: Found to be clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: "David S. Miller" <davem@davemloft.net>
Sent: Wednesday, October 06, 2004 16:21
> On Wed, 6 Oct 2004 11:15:13 -0400 (EDT)
> "Richard B. Johnson" <root@chaos.analogic.com> wrote:
> 
> > On Wed, 6 Oct 2004, David S. Miller wrote:
> > 
> > > On Wed, 6 Oct 2004 16:52:27 +0200 (CEST)
> > > Joris van Rantwijk <joris@eljakim.nl> wrote:
> > >
> > >> My understanding of POSIX is limited, but it seems to me that a read call
> > >> must never block after select just said that it's ok to read from the
> > >> descriptor. So any such behaviour would be a kernel bug.
> > >
> > > There is no such guarentee.
> > 
> > Huh?  Then why would anybody use select()?  It can't return a
> > 'guess" or it's broken. When select() or poll() claims that
> > there are data available, there damn well better be data available
> > or software becomes a crap-game.
> 
> So if select returns true, and another one of your threads
> reads all the data from the file descriptor, what would you
> like the behavior to be for the current thread when it calls
> read?
> 
> So like I said, there is no such guarentee.

Perhaps you should have elaborated then, because this is obviously
not what was meant.

--ms


