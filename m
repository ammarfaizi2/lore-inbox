Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317852AbSG3P2H>; Tue, 30 Jul 2002 11:28:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318220AbSG3P2H>; Tue, 30 Jul 2002 11:28:07 -0400
Received: from mout0.freenet.de ([194.97.50.131]:7579 "EHLO mout0.freenet.de")
	by vger.kernel.org with ESMTP id <S317852AbSG3P2G>;
	Tue, 30 Jul 2002 11:28:06 -0400
Message-ID: <008a01c237de$29d6b700$0200a8c0@MichaelKerrisk>
From: "Michael Kerrisk" <m.kerrisk@gmx.net>
To: "Alan Cox" <alan@lxorguk.ukuu.org.uk>
Cc: <linux-kernel@vger.kernel.org>
Subject: Re: Weirdness with AF_INET listen() backlog [2.4.18]
Date: Tue, 30 Jul 2002 17:31:20 +0200
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 4.72.3110.1
X-MimeOLE: Produced By Microsoft MimeOLE V4.72.3110.3
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Alan (et al.),

Thanks for the quick replies.

>> I had expected that if a server creates a listening socket, but does not
>> accept() the incoming connections, then after the (possibly
fudge-factored)
>> Is this all expected behaviour?  If so, is there a way of getting Linux
to
>> behave more like other implementations here?  (As a wild shot I tried
setting
>> /proc/sys/net/ipv4/tcp_syncookies to 0, but this made no apparent
>> difference.)
>
>The world of tcp synflooding changed how stacks handle this sort of
>stuff forever. Welcome to the new world order 8)

Yes, I was gathering that it was synflooding that led to these changes.

>You will get connections completing, they will time out.

What causes the delay of a few seconds following each of the connect()s
in excess of backlog?

> If you expect
>the server to say something you'll see the timeout there instead of
>seeing it on the connect.

Sorry, I don't quite understand this last sentence!  Can you elaborate?

>Since a timeout on the data can happen in the real world Im sure your
>code already correctly handles this case ;)

You mean on a send() or write(), right?

Cheers

Michael

