Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264915AbSJPEcZ>; Wed, 16 Oct 2002 00:32:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264916AbSJPEcZ>; Wed, 16 Oct 2002 00:32:25 -0400
Received: from pizda.ninka.net ([216.101.162.242]:48044 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S264915AbSJPEcY>;
	Wed, 16 Oct 2002 00:32:24 -0400
Date: Tue, 15 Oct 2002 21:31:02 -0700 (PDT)
Message-Id: <20021015.213102.80213000.davem@redhat.com>
To: neilb@cse.unsw.edu.au
Cc: taka@valinux.co.jp, linux-kernel@vger.kernel.org,
       nfs@lists.sourceforge.net
Subject: Re: [PATCH] zerocopy NFS for 2.5.36
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <15788.57476.858253.961941@notabene.cse.unsw.edu.au>
References: <15786.23306.84580.323313@notabene.cse.unsw.edu.au>
	<20021014.210144.74732842.taka@valinux.co.jp>
	<15788.57476.858253.961941@notabene.cse.unsw.edu.au>
X-FalunGong: Information control.
X-Mailer: Mew version 2.1 on Emacs 21.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: Neil Brown <neilb@cse.unsw.edu.au>
   Date: Wed, 16 Oct 2002 13:44:04 +1000

   Presumably on a sufficiently large SMP machine that this became an
   issue, there would be multiple NICs.  Maybe it would make sense to
   have one udp socket for each NIC.  Would that make sense? or work?
   It feels to me to be cleaner than one for each CPU.
   
Doesn't make much sense.

Usually we are talking via one IP address, and thus over
one device.  It could be using multiple NICs via BONDING,
but that would be transparent to anything at the socket
level.

Really, I think there is real value to making the socket
per-cpu even on a 2 or 4 way system.
