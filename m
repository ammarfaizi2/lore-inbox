Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269292AbUJFPXR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269292AbUJFPXR (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Oct 2004 11:23:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269280AbUJFPXE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Oct 2004 11:23:04 -0400
Received: from adsl-63-197-226-105.dsl.snfc21.pacbell.net ([63.197.226.105]:19603
	"EHLO cheetah.davemloft.net") by vger.kernel.org with ESMTP
	id S269301AbUJFPWj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Oct 2004 11:22:39 -0400
Date: Wed, 6 Oct 2004 08:21:45 -0700
From: "David S. Miller" <davem@davemloft.net>
To: root@chaos.analogic.com
Cc: joris@eljakim.nl, linux-kernel@vger.kernel.org
Subject: Re: UDP recvmsg blocks after select(), 2.6 bug?
Message-Id: <20041006082145.7b765385.davem@davemloft.net>
In-Reply-To: <Pine.LNX.4.61.0410061110260.6661@chaos.analogic.com>
References: <Pine.LNX.4.58.0410061616420.22221@eljakim.netsystem.nl>
	<20041006080104.76f862e6.davem@davemloft.net>
	<Pine.LNX.4.61.0410061110260.6661@chaos.analogic.com>
X-Mailer: Sylpheed version 0.9.12 (GTK+ 1.2.10; sparc-unknown-linux-gnu)
X-Face: "_;p5u5aPsO,_Vsx"^v-pEq09'CU4&Dc1$fQExov$62l60cgCc%FnIwD=.UF^a>?5'9Kn[;433QFVV9M..2eN.@4ZWPGbdi<=?[:T>y?SD(R*-3It"Vj:)"dP
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 6 Oct 2004 11:15:13 -0400 (EDT)
"Richard B. Johnson" <root@chaos.analogic.com> wrote:

> On Wed, 6 Oct 2004, David S. Miller wrote:
> 
> > On Wed, 6 Oct 2004 16:52:27 +0200 (CEST)
> > Joris van Rantwijk <joris@eljakim.nl> wrote:
> >
> >> My understanding of POSIX is limited, but it seems to me that a read call
> >> must never block after select just said that it's ok to read from the
> >> descriptor. So any such behaviour would be a kernel bug.
> >
> > There is no such guarentee.
> 
> Huh?  Then why would anybody use select()?  It can't return a
> 'guess" or it's broken. When select() or poll() claims that
> there are data available, there damn well better be data available
> or software becomes a crap-game.

So if select returns true, and another one of your threads
reads all the data from the file descriptor, what would you
like the behavior to be for the current thread when it calls
read?

So like I said, there is no such guarentee.
