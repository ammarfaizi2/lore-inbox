Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261759AbRE2UON>; Tue, 29 May 2001 16:14:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261791AbRE2UOF>; Tue, 29 May 2001 16:14:05 -0400
Received: from cibs23.sns.it ([192.167.206.162]:13061 "EHLO cibs23.sns.it")
	by vger.kernel.org with ESMTP id <S261759AbRE2UNy>;
	Tue, 29 May 2001 16:13:54 -0400
Date: Tue, 29 May 2001 22:13:57 +0200 (CEST)
From: Roberto Zunino <zunino@cibslogin.sns.it>
To: linux-kernel@vger.kernel.org
Subject: Transparent proxy support in linux 2.4 ?
Message-ID: <Pine.LNX.4.10.10105291447180.14595-100000@cibs10.sns.it>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


How can I simulate the linux 2.2.x transparent proxy support in linux 2.4?

Using linux 2.2 on my router I can bind() a socket to an address X and
then connect() to another host Y. Y would see an incoming connection from
X and reply accordingly: if the replies towards X pass through my router
they are rerouted towards the local socket and all works smoothly.

This is a (IMO) tricky hack to fake requests from host X: it is used for
example by nat-enabled IDENT servers that forward the incoming requests
towards the right host on the internal network. Normally the IDENT server
on these hosts wouldn't answer queries from hosts != X and therefore the
router has to fake the connection from X.

Linux 2.4 doesn't have this behaviour. Setting ip_nonlocal_bind doesn't
help. Maybe it could be done with some SNAT and libiptc & friends,...

Maybe there is a simpler way. Does anyone know one?

TIA,
Zun.

