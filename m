Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261173AbSJCVjG>; Thu, 3 Oct 2002 17:39:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261305AbSJCVjF>; Thu, 3 Oct 2002 17:39:05 -0400
Received: from pina.terra.com.br ([200.176.3.17]:20401 "EHLO pina.terra.com.br")
	by vger.kernel.org with ESMTP id <S261173AbSJCVit>;
	Thu, 3 Oct 2002 17:38:49 -0400
Date: Thu, 3 Oct 2002 18:44:18 -0300
From: Christian Reis <kiko@async.com.br>
To: NFS@lists.sourceforge.net
Cc: linux-kernel@vger.kernel.org
Subject: 2.4.19+trond and diskless locking problems
Message-ID: <20021003184418.K3869@blackjesus.async.com.br>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hey there,

We've got a network with about 20 diskless boxes at a client office.
They've been running 2.4.19 (both the knfsd server and the clients) with
Trond's patches for a while now, and though performance is really nice,
occasionally one box or another will end up with a strange locking
problem. 

At bootup, and at shutdown, and for certain other tasks (reading utmp,
etc) the box hangs for a long while (during which I suspect it is trying
to lock). It hangs for about 300 seconds and then goes on normally.

When this happens, there is always a file left in /var/lib/nfs/sm
(normally there are no files in there for none of the clients, even when
they are on) for the hanging box. Is this normal?

We also occasionally get a log message in the server for this box like:

    kernel:Aug 10 17:39:22 anthem kernel: lockd: cannot monitor 192.168.99.7

Trond, can I get you more troubleshooting information, or should I try
2.4.20-pre on server *and* clients? This is a bit wierd, but since I
don't know a lot of what went on in the last changes, I'm not sure where
to start looking.

Take care,
--
Christian Reis, Senior Engineer, Async Open Source, Brazil.
http://async.com.br/~kiko/ | [+55 16] 261 2331 | NMFL
