Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129208AbRBABxd>; Wed, 31 Jan 2001 20:53:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129890AbRBABxY>; Wed, 31 Jan 2001 20:53:24 -0500
Received: from pizda.ninka.net ([216.101.162.242]:21397 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S129208AbRBABxQ>;
	Wed, 31 Jan 2001 20:53:16 -0500
From: "David S. Miller" <davem@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <14968.49462.674977.825098@pizda.ninka.net>
Date: Wed, 31 Jan 2001 17:51:50 -0800 (PST)
To: Malcolm Beattie <mbeattie@sable.ox.ac.uk>
Cc: linux-kernel@vger.kernel.org, netdev@oss.sgi.com
Subject: Re: [UPDATE] Fresh zerocopy patch on kernel.org
In-Reply-To: <20010131152653.C13345@sable.ox.ac.uk>
In-Reply-To: <14966.35438.429963.405587@pizda.ninka.net>
	<20010131152653.C13345@sable.ox.ac.uk>
X-Mailer: VM 6.75 under 21.1 (patch 13) "Crater Lake" XEmacs Lucid
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Malcolm Beattie writes:
 > David S. Miller writes:
 > > 
 > > At the usual place:
 > > 
 > > ftp://ftp.kernel.org/pub/linux/kernel/people/davem/zerocopy-2.4.1-1.diff.gz
 > 
 > Hmm, disappointing results here; maybe I've missed something.

As discussed elsewhere there is a %10 to %15 performance hit for
normal write()'s done with the new code.

If you do your testing using sendfile() as the data source, you'll
results ought to be wildly different and more encouraging.

Later,
David S. Miller
davem@redhat.com
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
