Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132171AbRAJJWT>; Wed, 10 Jan 2001 04:22:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132937AbRAJJWK>; Wed, 10 Jan 2001 04:22:10 -0500
Received: from pat.uio.no ([129.240.130.16]:59326 "EHLO pat.uio.no")
	by vger.kernel.org with ESMTP id <S132171AbRAJJWB>;
	Wed, 10 Jan 2001 04:22:01 -0500
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <14940.10672.413028.265595@charged.uio.no>
Date: Wed, 10 Jan 2001 10:21:52 +0100 (CET)
To: "David S. Miller" <davem@redhat.com>
Cc: linux-kernel@vger.kernel.org, netdev@oss.sgi.com
Subject: Re: [PLEASE-TESTME] Zerocopy networking patch, 2.4.0-1
In-Reply-To: <200101092119.NAA05633@pizda.ninka.net>
In-Reply-To: <200101080124.RAA08134@pizda.ninka.net>
	<shs4rz8vnmf.fsf@charged.uio.no>
	<200101091342.FAA02414@pizda.ninka.net>
	<14939.11765.649805.239618@charged.uio.no>
	<200101092119.NAA05633@pizda.ninka.net>
X-Mailer: VM 6.72 under 21.1 (patch 12) "Channel Islands" XEmacs Lucid
Reply-To: trond.myklebust@fys.uio.no
From: Trond Myklebust <trond.myklebust@fys.uio.no>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> " " == David S Miller <davem@redhat.com> writes:

     >    Date: Tue, 9 Jan 2001 16:27:49 +0100 (CET) From: Trond
     >    Myklebust <trond.myklebust@fys.uio.no>

     >    OK, but can you eventually generalize it to non-stream
     >    protocols (i.e. UDP)?

     > Sure, this is what MSG_MORE is meant to accomodate.  UDP could
     > support it just fine.

Great! I've been waiting for something like this. In particular the
knfsd TCP server code can get very buffer-intensive without it since
you need to pre-allocate 1 set of buffers per TCP connection (else you
get DOS due to buffer saturation when doing wait+retry for blocked
sockets).

If it all gets in to the kernel, I'll do the work of adapting the NFS
+ sunrpc stuff.

Cheers,
  Trond
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
