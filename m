Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262190AbSKHPnq>; Fri, 8 Nov 2002 10:43:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262196AbSKHPnq>; Fri, 8 Nov 2002 10:43:46 -0500
Received: from fed1mtao04.cox.net ([68.6.19.241]:24555 "EHLO
	fed1mtao04.cox.net") by vger.kernel.org with ESMTP
	id <S262190AbSKHPnp>; Fri, 8 Nov 2002 10:43:45 -0500
Message-ID: <014f01c2873e$794089b0$0200a8c0@cirilium.com>
From: "Mark Hamblin" <MarkHamblin@cox.net>
To: "Davide Libenzi" <davidel@xmailserver.org>
Cc: "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>
References: <Pine.LNX.4.44.0211071521070.1751-100000@blue1.dev.mcafeelabs.com>
Subject: Re: [PATCH] 2.5.46: epoll ep_insert doesn't wake waiters if events exist 
Date: Fri, 8 Nov 2002 08:49:46 -0700
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2600.0000
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2600.0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Looking at the documentation at
http://www.xmailserver.org/linux-patches/epoll_wait.txt, I noticed that the
description for epoll_wait states:  "On success, epoll_wait(2) returns the
number of file descriptors ready for the requested I/O."  My question is if
I have, for example, 1000 sockets registered with epoll and 100 of them have
received data and I call epoll_wait with max_events set to 10, will
epoll_wait return 10 or 100?  Furthermore, does the edge-triggered nature of
epoll "eat the edge" for the other 90 sockets even though they didn't get
returned?  Finally, if those 10 sockets get more data before I call
epoll_wait with max_events = 10 again, will those same 10 sockets get
returned?

- Mark


