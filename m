Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131937AbQKQLou>; Fri, 17 Nov 2000 06:44:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131967AbQKQLok>; Fri, 17 Nov 2000 06:44:40 -0500
Received: from tonib-gw-old.customer.0rbitel.net ([195.24.39.218]:11012 "HELO
	gateway.izba.bg") by vger.kernel.org with SMTP id <S131937AbQKQLo0>;
	Fri, 17 Nov 2000 06:44:26 -0500
Date: Fri, 17 Nov 2000 13:14:33 +0200 (EET)
From: Vasil Kolev <lnxkrnl@mail.ludost.net>
To: linux-kernel@vger.kernel.org
Subject: __alloc_pages: 2-order allocation failed.
Message-ID: <Pine.LNX.4.10.10011171310110.4185-100000@doom.bastun.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  Hello,
This error ( $subj) started appearing today on my machine when I started
experimenting with ircd. I wrote small program that makes many connections
to the server,to see how much it can support. I increased the maximum
number of file descriptors, and after 520 connectons, syslogd printed sth.
about too many orphaned sockets... I then checked the source, saw that
this is because the lower value in /proc/sys/net/ipv4/tcp_mem, and
increased it 4 times... it then ran with 720 connectons and all the tcp
stopped working, and started printing $subj... I increased the values 4
more times, and it ran to 824 connections. I'm using linux-2.4.0test10, on
Celeron/300 with 192 MB ram. Suggestions?

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
