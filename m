Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318319AbSG3QK0>; Tue, 30 Jul 2002 12:10:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318327AbSG3QK0>; Tue, 30 Jul 2002 12:10:26 -0400
Received: from mout1.freenet.de ([194.97.50.132]:3720 "EHLO mout1.freenet.de")
	by vger.kernel.org with ESMTP id <S318319AbSG3QKY>;
	Tue, 30 Jul 2002 12:10:24 -0400
Message-ID: <00b901c237e4$136bd3a0$0200a8c0@MichaelKerrisk>
From: "Michael Kerrisk" <m.kerrisk@gmx.net>
To: "Alan Cox" <alan@lxorguk.ukuu.org.uk>
Cc: <linux-kernel@vger.kernel.org>
Subject: Re: Weirdness with AF_INET listen() backlog [2.4.18]
Date: Tue, 30 Jul 2002 18:13:08 +0200
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

Hello Alan,

And a further small point to help me clear things up things cleanly...

>You will get connections completing, they will time out. If you expect
>the server to say something you'll see the timeout there instead of
>seeing it on the connect. 

Perhaps also to further clarify the meaning og backlog in 2.4.  
The situation is this:

1. Pending requests up to backlog are always established.

2. Pending requests in excess of backlog are established, but may 
timeout if not accepted() in a timely fashion.

Have I got it right?

Cheers

Michael

