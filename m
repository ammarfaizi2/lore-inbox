Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317779AbSGVTs0>; Mon, 22 Jul 2002 15:48:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317778AbSGVTsZ>; Mon, 22 Jul 2002 15:48:25 -0400
Received: from cs180154.pp.htv.fi ([213.243.180.154]:25489 "EHLO
	devil.pp.htv.fi") by vger.kernel.org with ESMTP id <S317770AbSGVTsY>;
	Mon, 22 Jul 2002 15:48:24 -0400
Subject: Re: 2.2 to 2.4... serious TCP send slowdowns
From: Mika Liljeberg <Mika.Liljeberg@welho.com>
To: Hayden Myers <hayden@spinbox.com>
Cc: linux-kernel@vger.kernel.org, linux-net@vger.kernel.org
In-Reply-To: <Pine.LNX.4.10.10207221352430.27914-100000@compaq.skyline.net>
References: <Pine.LNX.4.10.10207221352430.27914-100000@compaq.skyline.net>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.7 
Date: 22 Jul 2002 22:51:27 +0300
Message-Id: <1027367487.10556.3.camel@cs180154>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2002-07-22 at 21:47, Hayden Myers wrote: 

> Tcpdump output is where I'm seeing the difference in the clients receive
> window.  Below is tcpdump from the server 
> 
> [root@install spinbox]# /usr/sbin/tcpdump src port 80

Your dump is showing only one direction of the connection. The receive
window visible in this dump is used for the reverse direction. Use
"tcpdump port 80" instead to get some useful output. 

Linux 2.4 starts with a small receive window and rapidly increases it
when the data starts to flow. This is a type of receiver oriented
congestion control. You don't see the window increase here, because
there is very little data sent from client to server. 

Also, next time try not to wrap the dump output. Beastly hard to make
sense of. 

	MikaL 

