Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318307AbSG3P7R>; Tue, 30 Jul 2002 11:59:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318314AbSG3P7R>; Tue, 30 Jul 2002 11:59:17 -0400
Received: from pc2-cwma1-5-cust12.swa.cable.ntl.com ([80.5.121.12]:58350 "EHLO
	irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S318307AbSG3P7Q>; Tue, 30 Jul 2002 11:59:16 -0400
Subject: Re: Weirdness with AF_INET listen() backlog [2.4.18]
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Michael Kerrisk <m.kerrisk@gmx.net>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <008a01c237de$29d6b700$0200a8c0@MichaelKerrisk>
References: <008a01c237de$29d6b700$0200a8c0@MichaelKerrisk>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.3 (1.0.3-6) 
Date: 30 Jul 2002 18:18:51 +0100
Message-Id: <1028049531.7974.1.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2002-07-30 at 16:31, Michael Kerrisk wrote:
> > If you expect
> >the server to say something you'll see the timeout there instead of
> >seeing it on the connect.
> 
> Sorry, I don't quite understand this last sentence!  Can you elaborate?

If your client current does

	connect
	if timedout error
	read
	if timedout error

then it will fail on the read, and since the code should already handle
that case will work out fine

> >Since a timeout on the data can happen in the real world Im sure your
> >code already correctly handles this case ;)
> 
> You mean on a send() or write(), right?

If the client writes first then it may well not fail until the read
after the write

