Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293403AbSCKA3R>; Sun, 10 Mar 2002 19:29:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293407AbSCKA3H>; Sun, 10 Mar 2002 19:29:07 -0500
Received: from mons.uio.no ([129.240.130.14]:40359 "EHLO mons.uio.no")
	by vger.kernel.org with ESMTP id <S293403AbSCKA2u>;
	Sun, 10 Mar 2002 19:28:50 -0500
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15499.64058.442959.241470@charged.uio.no>
Date: Mon, 11 Mar 2002 01:28:42 +0100
To: Stephan von Krawczynski <skraw@ithnet.com>
Cc: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: BUG REPORT: kernel nfs between 2.4.19-pre2 (server) and 2.2.21-pre3 (client)
In-Reply-To: <200203110018.BAA11921@webserver.ithnet.com>
In-Reply-To: <shswuwkujx5.fsf@charged.uio.no>
	<200203110018.BAA11921@webserver.ithnet.com>
X-Mailer: VM 6.92 under 21.1 (patch 14) "Cuyahoga Valley" XEmacs Lucid
Reply-To: trond.myklebust@fys.uio.no
From: Trond Myklebust <trond.myklebust@fys.uio.no>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> " " == Stephan von Krawczynski <skraw@ithnet.com> writes:

     > this is a weak try of an explanation. All involved fs types are
     > reiserfs. The problem occurs reproducably only after (and

Which ReiserFS format? Is it version 3.5?

   'cat /proc/fs/reiserfs/device/version'

     > including)
     > 2.2.20 and above and _not_ in 2.2.19. There must be some
     > problem.

The client code in 2.2.20 is supposed to be the same as in 2.4.x. The
only thing I can think might be missing is the fix to cope with broken
servers that reuse filehandles (this violates the RFCs). Reiserfs 3.5
+ knfsd is one such broken combination. Another broken server is
unfsd...

     > Though I do not know whether the problem is on the client side,
     > or simply produced by this client side and effectively located
     > on 2.4.18 server, I really can't tell. But giving me something
     > to try might clear the picture.
                                                                      
You might try keeping a file open on /backup while you play with /mnt...

Cheers,
   Trond
