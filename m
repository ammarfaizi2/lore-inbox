Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266234AbUARG6a (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 18 Jan 2004 01:58:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266235AbUARG63
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 18 Jan 2004 01:58:29 -0500
Received: from pcp05127596pcs.sanarb01.mi.comcast.net ([68.42.103.198]:27530
	"EHLO nidelv.trondhjem.org") by vger.kernel.org with ESMTP
	id S266234AbUARG62 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 18 Jan 2004 01:58:28 -0500
Subject: Re: [RFC] kill sleep_on
From: Trond Myklebust <trond.myklebust@fys.uio.no>
To: Andrew Morton <akpm@osdl.org>
Cc: David Woodhouse <dwmw2@infradead.org>,
       Alexander Viro <viro@parcelfarce.linux.theplanet.co.uk>,
       manfred@colorfullife.com, linux-kernel@vger.kernel.org
In-Reply-To: <20040117224139.5585fb9c.akpm@osdl.org>
References: <40098251.2040009@colorfullife.com>
	 <1074367701.9965.2.camel@imladris.demon.co.uk>
	 <20040117201000.GL21151@parcelfarce.linux.theplanet.co.uk>
	 <1074383111.9965.4.camel@imladris.demon.co.uk>
	 <20040117224139.5585fb9c.akpm@osdl.org>
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8BIT
Message-Id: <1074409074.1569.12.camel@nidelv.trondhjem.org>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Sun, 18 Jan 2004 01:57:54 -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

På su , 18/01/2004 klokka 01:41, skreiv Andrew Morton:
> It would be nice to fix up the lock_kernel()s in the NFS client: SMP lock
> contention is quite high in there.

Chuck did a study of that particular issue some 2-3 years ago, but we've
addressed all the top problems on his list since then. Do you have any
new numbers to show us? I ask because I'm not at all convinced that the
BKL adds significantly to our latencies for the moment (I've been
looking at those number in the last few days due to the readahead
problems that have already been reported).

I am, however, quite convinced that we need new statistics on this sort
of issue. Chuck is therefore working on a set of patches to add an
"iostat"-like tool to the NFS client. Hopefully that will help settle
these questions.

Cheers,
  Trond
