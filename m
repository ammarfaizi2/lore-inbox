Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266362AbUAOBML (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Jan 2004 20:12:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266369AbUAOBMK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Jan 2004 20:12:10 -0500
Received: from news.cistron.nl ([62.216.30.38]:6353 "EHLO ncc1701.cistron.net")
	by vger.kernel.org with ESMTP id S266362AbUAOBMI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Jan 2004 20:12:08 -0500
From: "Miquel van Smoorenburg" <miquels@cistron.nl>
Subject: Re: Slow NFS performance over wireless!
Date: Thu, 15 Jan 2004 01:12:07 +0000 (UTC)
Organization: Cistron Group
Message-ID: <bu4pd6$anf$1@news.cistron.nl>
References: <Pine.LNX.4.44.0401060055570.1417-100000@poirot.grange> <200401130155.32894.hackeron@dsl.pipex.com> <1074025508.1987.10.camel@lumiere> <1074026758.4524.65.camel@nidelv.trondhjem.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-Trace: ncc1701.cistron.net 1074129127 10991 62.216.29.200 (15 Jan 2004 01:12:07 GMT)
X-Complaints-To: abuse@cistron.nl
X-Newsreader: trn 4.0-test76 (Apr 2, 2001)
Originator: miquels@cistron-office.nl (Miquel van Smoorenburg)
To: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <1074026758.4524.65.camel@nidelv.trondhjem.org>,
Trond Myklebust  <trond.myklebust@fys.uio.no> wrote:
>There are a couple of performance related patches that should be applied
>to stock 2.6.0/2.6.1. One handles a problem with remove_suid()
>generating a whole load of SETATTR calls if you are writing to a file
>that has the "x" bit set. The other handles an efficiency issue related
>to random write + read combinations.
>
>Either look for them on my website (under
>http://www.fys.uio.no/~trondmy/src), or apply Andrew's 2.6.1-mm2 patch.

If one runs bonnie on a NFS mounted share, what should the rewrite
throughput be?

On an NFS server locally (2.6.1-mm3) I get as write/rewrite/read
speeds 107 / 25 / 110 MB/sec, CPU loads of a few percent.

On an NFS client (2.6.1-mm3, filesystem mounted with options
udp,nfsvers=3,rsize=32768,wsize=32768) I get for the same share as
write/rewrite/read speeds 36 / 4 / 38 MB/sec. CPU load is also
very high on the client for the rewrite case (80%).

That's with back-to-back GigE, full duplex, MTU 9000, P IV 3.0 Ghz.
(I tried MTU 5000 and 1500 as well, doesn't really matter).

Is that what would be expected ?

Mike.

