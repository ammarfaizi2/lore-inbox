Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314330AbSE0GGP>; Mon, 27 May 2002 02:06:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314339AbSE0GGO>; Mon, 27 May 2002 02:06:14 -0400
Received: from supreme.pcug.org.au ([203.10.76.34]:15054 "EHLO pcug.org.au")
	by vger.kernel.org with ESMTP id <S314330AbSE0GGN>;
	Mon, 27 May 2002 02:06:13 -0400
Date: Mon, 27 May 2002 16:06:07 +1000
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: LKML <linux-kernel@vger.kernel.org>
Subject: [PATCH] consolidate do_signal
Message-Id: <20020527160607.1be0a83e.sfr@canb.auug.org.au>
X-Mailer: Sylpheed version 0.7.6 (GTK+ 1.2.10; i386-debian-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

11 out of our 17 architectures have basically the same code
in arch/../kernel/signal.c:do_signal.  This patch creates a
common function for that bit of code and uses it in the places
it can be.

Original extraction by Paul Mackerras, i386 version by Anton Blanchard.

The 2.5.15 version of this patch builds and runs on i386 and PPC and has
been briefly looked at by the CRIS, PARISC, PPC64 and x86_64 maintainers.

As a bonus, this fixes the "ignore SIGURG" bug for 9 more architectures
(i386 and PPC already were fixed).

see <http://www.canb.auug.org.au/~sfr/18-si.5.diff.gz>

-- 
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au
http://www.canb.auug.org.au/~sfr/
