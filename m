Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S278665AbRKFIdA>; Tue, 6 Nov 2001 03:33:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S278672AbRKFIck>; Tue, 6 Nov 2001 03:32:40 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:35591 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S278665AbRKFIcf>; Tue, 6 Nov 2001 03:32:35 -0500
Subject: Re: [Ext2-devel] disk throughput
To: viro@math.psu.edu (Alexander Viro)
Date: Tue, 6 Nov 2001 08:39:08 +0000 (GMT)
Cc: torvalds@transmeta.com (Linus Torvalds), linux-kernel@vger.kernel.org
In-Reply-To: <Pine.GSO.4.21.0111052132360.27563-100000@weyl.math.psu.edu> from "Alexander Viro" at Nov 05, 2001 10:02:35 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E1611lE-00086H-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > So I still claim that we should look for short-time profit, and then try
> > to fix up the problems longer term. With, if required, some kind of
> > rebalancing.
> 
> Whatever heuristics we use, it _must_ catch fast-growth scenario.  No
> arguments on that.  The question being, what will minimize the problems
> for other cases.

Surely the answer if you want short term write speed and long term balancing
is to use ext3 not ext2 and simply ensure that the relevant stuff goes to
the journal (which will be nicely ordered) first. That will give you some
buffering at least.

Alan
