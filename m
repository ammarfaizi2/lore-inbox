Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130153AbRBZO25>; Mon, 26 Feb 2001 09:28:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130232AbRBZO2u>; Mon, 26 Feb 2001 09:28:50 -0500
Received: from zeus.kernel.org ([209.10.41.242]:53191 "EHLO zeus.kernel.org")
	by vger.kernel.org with ESMTP id <S130202AbRBZO2h>;
	Mon, 26 Feb 2001 09:28:37 -0500
Message-ID: <000d01c0a05e$9f59b400$8f1cc818@videotron.ca>
Reply-To: "Daniel Shane" <daniel@insu.com>
From: "Daniel Shane" <daniel@insu.com>
To: <linux-kernel@vger.kernel.org>
Subject: Listening on a socket in kernel space
Date: Mon, 26 Feb 2001 17:43:02 -0800
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 5.50.4522.1200
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4522.1200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I am currently writing a device driver that must listen to a socket
connection in kernel space. By looking at various code, I found out that
many drivers in the kernel use the socket->sk->sleep wait queue to queue
themselves on that list and get waken_up() by the socket.

My question is : if I expect to receive *a lot* of traffic, isnt this
sleep/wake_up a little slow? Maybe it cant be done, but is it possible for
the socket to generate an interrupt whenever some data arrives instead of
sleeping the the sockets queue?

I'm a little afraid of loosing some packets because the wake_up call doesnt
garantee that I will be waken_up any time soon (or will the kernel
automaticlaly schedule the kernel thread first when the data arrives because
it's always highest priority?).

 Thanks!
Daniel Shane
--
GNU/Linux programmer
iNsu Innovations Inc.

