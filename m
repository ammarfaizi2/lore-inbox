Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318283AbSG3NsH>; Tue, 30 Jul 2002 09:48:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318290AbSG3NsH>; Tue, 30 Jul 2002 09:48:07 -0400
Received: from CPE-144-132-195-245.nsw.bigpond.net.au ([144.132.195.245]:17543
	"EHLO anakin.wychk.org") by vger.kernel.org with ESMTP
	id <S318283AbSG3NsG>; Tue, 30 Jul 2002 09:48:06 -0400
Date: Tue, 30 Jul 2002 23:31:16 +1000
From: Geoffrey Lee <snailtalk@linux-mandrake.com>
To: linux-kernel@vger.kernel.org
Subject: bind()/connect() to port 0 question for tcp/udp
Message-ID: <20020730133116.GA17743@anakin.wychk.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=big5
Content-Disposition: inline
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi list,



I want to ask a question:

In sockets, what is the correct behavior when we try to connect() to port 0
for tcp / udp?


It seems that FreeBSD returns EADDRNOTAVAIL, as does Solaris.

So something like this will fail on Solaris and FreeBSD:

[...]
saddr.sin_port = htons(0);
[...]

connect(AF_INET, (struct sockaddr *)&saddr, sizeof(struct sockaddr));


We don't do this however, and Linux will merrily accept a port of 0 in
a connect(), though most probably your connect() wouldn't succeed.

Making it return EADDRNOTAVAIL to user space would be a trivial task, so
I want to ask, is this a buglet in the Linux implementation, or is FreeBSD
and Solaris wrong?



	- G.
